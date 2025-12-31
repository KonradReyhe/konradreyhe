# Deployment Guide — konradreyhe.de

Complete guide to deploy the website to production.

---

## Prerequisites

### Local machine
- Node.js 18+ installed
- SSH key configured for `deploy@91.99.104.132`
- Git repository cloned

### Server (already configured)
- Ubuntu (deploy user set up)
- nginx installed
- Certbot installed
- UFW firewall (ports 22, 80, 443 open)
- Existing project: LOGOS at `/var/www/logos/`

---

## First-Time Server Setup

Run these commands **once** on the server.

### 1. Create directories

```bash
ssh deploy@91.99.104.132

# Create web directory
sudo mkdir -p /var/www/konradreyhe
sudo chown -R deploy:deploy /var/www/konradreyhe

# Create certbot directory (if not exists)
sudo mkdir -p /var/www/certbot
```

### 2. Upload initial nginx config (HTTP only)

From your local machine:

```bash
scp infra/nginx/konradreyhe-initial.conf deploy@91.99.104.132:/tmp/

ssh deploy@91.99.104.132 "sudo mv /tmp/konradreyhe-initial.conf /etc/nginx/sites-available/konradreyhe"
ssh deploy@91.99.104.132 "sudo ln -sf /etc/nginx/sites-available/konradreyhe /etc/nginx/sites-enabled/"
ssh deploy@91.99.104.132 "sudo nginx -t && sudo systemctl reload nginx"
```

### 3. DNS setup

Create these DNS records at your registrar:

| Type | Name | Value | TTL |
|------|------|-------|-----|
| A | @ | 91.99.104.132 | 300 |
| A | www | 91.99.104.132 | 300 |

Wait for DNS propagation:
```bash
dig konradreyhe.de +short
# Should return: 91.99.104.132
```

### 4. First deploy (upload site files)

```bash
# Build locally
npm install
npm run build

# Upload to server
rsync -avz --delete ./dist/ deploy@91.99.104.132:/var/www/konradreyhe/

# Set permissions
ssh deploy@91.99.104.132 "sudo chown -R www-data:www-data /var/www/konradreyhe"
```

### 5. Obtain SSL certificate

```bash
ssh deploy@91.99.104.132

# Get certificate
sudo certbot certonly --webroot -w /var/www/certbot \
    -d konradreyhe.de -d www.konradreyhe.de \
    --email kontakt@konradreyhe.de --agree-tos --no-eff-email
```

### 6. Switch to HTTPS config

From local machine:

```bash
scp infra/nginx/konradreyhe.conf deploy@91.99.104.132:/tmp/

ssh deploy@91.99.104.132 "sudo mv /tmp/konradreyhe.conf /etc/nginx/sites-available/konradreyhe"
ssh deploy@91.99.104.132 "sudo nginx -t && sudo systemctl reload nginx"
```

### 7. Verify

```bash
curl -I https://konradreyhe.de
```

Should show:
- `HTTP/2 200`
- Security headers present
- HSTS header

---

## Regular Deployments

After initial setup, use the deploy script:

```bash
./deploy.sh
```

Or manually:

```bash
npm run build
rsync -avz --delete ./dist/ deploy@91.99.104.132:/var/www/konradreyhe/
ssh deploy@91.99.104.132 "sudo chown -R www-data:www-data /var/www/konradreyhe"
```

---

## Logs

```bash
# Access log
ssh deploy@91.99.104.132 "sudo tail -f /var/log/nginx/konradreyhe.access.log"

# Error log
ssh deploy@91.99.104.132 "sudo tail -f /var/log/nginx/konradreyhe.error.log"
```

---

## SSL Certificate Renewal

Certbot auto-renews. Verify with:

```bash
ssh deploy@91.99.104.132 "sudo certbot certificates"
ssh deploy@91.99.104.132 "sudo certbot renew --dry-run"
```

---

## Rollback

### Rollback site files

Before deploying, create backup:
```bash
ssh deploy@91.99.104.132 "sudo cp -r /var/www/konradreyhe /var/www/konradreyhe.backup"
```

Restore if needed:
```bash
ssh deploy@91.99.104.132 "sudo rm -rf /var/www/konradreyhe && sudo mv /var/www/konradreyhe.backup /var/www/konradreyhe"
```

---

## Troubleshooting

### Site not loading
```bash
ssh deploy@91.99.104.132 "sudo nginx -t"
ssh deploy@91.99.104.132 "sudo systemctl status nginx"
ssh deploy@91.99.104.132 "ls -la /var/www/konradreyhe/"
```

### Certificate issues
```bash
ssh deploy@91.99.104.132 "sudo certbot certificates"
ssh deploy@91.99.104.132 "sudo certbot renew --force-renewal"
ssh deploy@91.99.104.132 "sudo systemctl reload nginx"
```

### Permission issues
```bash
ssh deploy@91.99.104.132 "sudo chown -R www-data:www-data /var/www/konradreyhe"
ssh deploy@91.99.104.132 "sudo chmod -R 755 /var/www/konradreyhe"
```
