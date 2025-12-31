# Server Access Instructions

## SSH Connection

| Property | Value |
|----------|-------|
| **Host** | `91.99.104.132` |
| **User** | `deploy` |
| **Auth** | SSH key only (NO passwords) |

**Connection command:**
```bash
ssh deploy@91.99.104.132
```

---

## Critical Rules

1. **NEVER use `root@`** — Root SSH is completely disabled on this server
2. **NEVER use passwords** — Password auth is disabled, SSH keys only
3. **Always use `deploy` user** for everything

---

## Common Commands

### Test connection
```bash
ssh deploy@91.99.104.132 "echo 'Connection OK'"
```

### Check disk space
```bash
ssh deploy@91.99.104.132 "df -h"
```

### List files in web root
```bash
ssh deploy@91.99.104.132 "ls -la /var/www/"
```

### Upload a file
```bash
scp file.txt deploy@91.99.104.132:/path/to/destination/
```

### Upload a directory
```bash
scp -r folder/ deploy@91.99.104.132:/path/to/destination/
```

### Rsync (better for large transfers)
```bash
rsync -avz --progress local/path/ deploy@91.99.104.132:/remote/path/
```

---

## Web Root

| Project | Path |
|---------|------|
| LOGOS (existing) | `/var/www/logos/` |
| konradreyhe.de | `/var/www/konradreyhe/` |

---

## SSH Config (Optional)

Add this to `~/.ssh/config` for easier access:

```
Host konradreyhe
    HostName 91.99.104.132
    User deploy
    IdentityFile ~/.ssh/id_rsa
```

Then connect with just:
```bash
ssh konradreyhe
```

---

## Sudo Access

The `deploy` user has passwordless sudo for specific commands:
```bash
# Reload nginx
sudo systemctl reload nginx

# Restart app service
sudo systemctl restart <appname>

# View nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

---

## Firewall (UFW)

Allowed ports:
- **22** — SSH
- **80** — HTTP (redirects to HTTPS)
- **443** — HTTPS

Check status:
```bash
ssh deploy@91.99.104.132 "sudo ufw status"
```
