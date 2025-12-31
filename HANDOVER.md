# Handover Prompt for AI Assistant

Read this document to continue working on this project.

---

## Project Overview

**What:** Personal portfolio website for Konrad Reyhe
**URL:** https://konradreyhe.de (domain purchased, DNS configured, NOT YET DEPLOYED)
**Repo:** https://github.com/KonradReyhe/konradreyhe
**Tech:** Astro 5 + Tailwind CSS v4 + TypeScript
**Location:** `C:\Users\kreyh\Projekte\devportfolio-temp`

---

## Owner Profile

- **Name:** Konrad Reyhe
- **Role:** Fachinformatiker für Anwendungsentwicklung (Software Developer)
- **Experience:** ~3 years (including 2 year training)
- **Current Job:** 8 months at an energy company, building internal tools
- **Internship:** 6 months at 4Kanalytics (Playwright, AI bots, RAGAS)
- **Specialty:** Automation, data pipelines, internal tools, test automation
- **Unique Angle:** Early adopter of AI-assisted development (Claude, Cursor)
- **Email:** kreyhe@yahoo.com
- **LinkedIn:** https://www.linkedin.com/in/konrad-reyhe-6a055b293/
- **GitHub:** https://github.com/KonradReyhe
- **Address:** Alfred-Kästner-Straße 84, 04275 Leipzig

---

## Current Status

### COMPLETED
- [x] DevPortfolio template configured
- [x] Multilingual support (DE/EN) with language toggle
- [x] Bio updated (humble, professional tone)
- [x] Experience section with 2 jobs (Energieunternehmen + 4Kanalytics)
- [x] Profile picture added to Hero section
- [x] Impressum page (DE + EN)
- [x] Domain purchased: konradreyhe.de at INWX (5.97€/year)
- [x] DNS configured: A records pointing to 91.99.104.132
- [x] Site built locally (`npm run build`)
- [x] Files uploaded to server at ~/konradreyhe/

### BLOCKED - NEEDS SUDO PASSWORD
- [ ] Move files from ~/konradreyhe/ to /var/www/konradreyhe/
- [ ] Set up nginx config for konradreyhe.de
- [ ] SSL certificate with certbot
- [ ] Final deployment

### SUDO PASSWORD ISSUE
The deploy user needs sudo to:
1. Create /var/www/konradreyhe/
2. Copy files there
3. Set permissions for www-data

**Attempted password:** `Sachsenquelle1!` - DID NOT WORK

**Solution needed:** Either:
1. Get correct sudo password from user
2. Use Hetzner Console to reset password
3. Set up passwordless sudo: `echo 'deploy ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/deploy`

---

## Server Details

| Property | Value |
|----------|-------|
| Provider | Hetzner Cloud |
| Server Name | logos-web |
| IP | 91.99.104.132 |
| User | deploy |
| Auth | SSH key (works!) |
| Web root (target) | /var/www/konradreyhe |
| Files uploaded to | ~/konradreyhe/ |
| Existing project | LOGOS at /var/www/logos/ |

**Connect:** `ssh deploy@91.99.104.132` (works from Git Bash, NOT PowerShell)

---

## Key Files

| File | Purpose |
|------|---------|
| `src/i18n/de.ts` | German translations |
| `src/i18n/en.ts` | English translations |
| `src/config.ts` | Shared config (colors, social, skills) |
| `src/pages/index.astro` | German homepage |
| `src/pages/en/index.astro` | English homepage |
| `src/pages/impressum.astro` | German legal page |
| `src/pages/en/imprint.astro` | English legal page |
| `public/profile.jpg` | Profile picture |
| `docs/DEPLOYMENT.md` | Full deployment guide |
| `infra/nginx/konradreyhe.conf` | nginx config (HTTPS) |
| `infra/nginx/konradreyhe-initial.conf` | nginx config (HTTP, pre-SSL) |

---

## To Complete Deployment

Once sudo works, run these commands:

```bash
# 1. Create directory and copy files
ssh deploy@91.99.104.132
sudo mkdir -p /var/www/konradreyhe
sudo cp -r ~/konradreyhe/* /var/www/konradreyhe/
sudo chown -R www-data:www-data /var/www/konradreyhe

# 2. Set up nginx (from local machine)
scp infra/nginx/konradreyhe-initial.conf deploy@91.99.104.132:/tmp/
ssh deploy@91.99.104.132 "sudo mv /tmp/konradreyhe-initial.conf /etc/nginx/sites-available/konradreyhe"
ssh deploy@91.99.104.132 "sudo ln -sf /etc/nginx/sites-available/konradreyhe /etc/nginx/sites-enabled/"
ssh deploy@91.99.104.132 "sudo nginx -t && sudo systemctl reload nginx"

# 3. Get SSL certificate
ssh deploy@91.99.104.132
sudo certbot certonly --webroot -w /var/www/certbot \
    -d konradreyhe.de -d www.konradreyhe.de \
    --email kreyhe@yahoo.com --agree-tos --no-eff-email

# 4. Switch to HTTPS config
scp infra/nginx/konradreyhe.conf deploy@91.99.104.132:/tmp/
ssh deploy@91.99.104.132 "sudo mv /tmp/konradreyhe.conf /etc/nginx/sites-available/konradreyhe"
ssh deploy@91.99.104.132 "sudo nginx -t && sudo systemctl reload nginx"
```

---

## Code Principles (User Explicitly Requested)

1. **DRY** - Don't Repeat Yourself
2. **SOLID** - Single responsibility, etc.
3. **KISS** - Keep It Simple
4. **YAGNI** - No features until needed
5. **Commit often** - Small commits, clear messages

---

## Commit Convention

```
<type>: <description>

feat:     New feature
fix:      Bug fix
docs:     Documentation
style:    Formatting
refactor: Restructure
chore:    Maintenance
```

---

## Important Context

1. **No portfolio projects section** - Can't show projects from employer
2. **Side business** - Testing market for freelance work
3. **Focus** - Automation, internal tools, data pipelines, test automation
4. **German content preferred** - But bilingual DE/EN
5. **No dashes (—)** - User dislikes em-dashes
6. **Humble tone** - Professional, not boastful

---

## User's Work Experience Summary

### Energieunternehmen (2024 - Present)
- 5 productive systems, 150k+ LOC
- Data processing, sync services, admin panel, customer portal
- Excel automation, API integrations
- Clean architecture, structured logging

### 4Kanalytics Internship (2023 - 2024)
- Test automation with Playwright
- AI chatbot development
- RAG systems, RAGAS evaluation
- 6 months mandatory internship

---

## Next Steps When Resuming

1. **FIRST:** Solve sudo password issue (Hetzner console or get correct password)
2. Deploy files to /var/www/konradreyhe/
3. Set up nginx config
4. Get SSL certificate
5. Verify site works at https://konradreyhe.de
6. Commit all changes and push
7. User plans to advertise on eBay Kleinanzeigen

---

## Commands Reference

```bash
# Development
cd C:\Users\kreyh\Projekte\devportfolio-temp
npm run dev

# Build
npm run build

# Upload to server
scp -r ./dist/* deploy@91.99.104.132:~/konradreyhe/

# SSH (use Git Bash, not PowerShell!)
ssh deploy@91.99.104.132

# Git
git add .
git commit -m "type: description"
git push
```

---

## Always Remember

- **Commit and document regularly**
- **Keep code DRY, SOLID, KISS, YAGNI**
- **User prefers pragmatic solutions**
- **German content preferred**
- **SSH only works from Git Bash on Windows**

---

*Last updated: 2025-12-31 14:20 UTC*
