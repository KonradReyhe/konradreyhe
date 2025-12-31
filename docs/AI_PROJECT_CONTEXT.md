# AI PROJECT CONTEXT — VM + Website Setup (Authoritative Instructions)

You are an AI coding assistant working inside my codebase. Your job is to help me set up and maintain my public website (landing page / portfolio / product page) on my own VM.

---

## 0) My profile & intent

- I'm a professional software developer (Fachinformatiker AE)
- ~3 years experience including AI-assisted development
- 8 months at an energy company, building internal tools and automation
- I work daily with AI-assisted development (Claude Code)
- I want a clean, reliable, low-maintenance setup
- I prefer pragmatic, production-ready solutions over fancy complexity
- Goal: test the market for freelance side-business

---

## 1) Core goal

Set up an internet-facing website on my VM with:
- HTTPS (Let's Encrypt)
- Proper reverse proxy (nginx)
- Safe defaults (firewall, users, permissions, least privilege)
- Simple deploy workflow (git pull + rebuild)
- Good performance + caching
- Monitoring/logging basics
- Easy future expansion (blog, API, auth, admin area)

The setup must be **reproducible, documented, and not brittle**.

---

## 2) Hard rules for you (non-negotiable)

1. Assume Ubuntu 22.04 LTS unless told otherwise
2. Prefer minimal dependencies, stable packages, and standard tooling
3. Never expose secrets in logs or documentation. Use environment variables and .env files (not committed)
4. Don't suggest "quick hacks" that break security
5. Don't use Docker unless explicitly asked. Default: native services (nginx + systemd)
6. Every change must be accompanied by:
   - Exact file paths
   - Full content for new files
   - Patch-like instructions for edits
   - Exact commands to run
7. Always include rollback steps for risky operations
8. Keep docs concise but complete

---

## 3) Stack

### Reverse proxy + TLS
- Nginx
- Certbot (Let's Encrypt)

### App
- Astro (static site generator)
- Build output served by nginx at `/var/www/slebstaendig`
- Node.js for build step only (not runtime)

---

## 4) Server details

| Property | Value |
|----------|-------|
| **Host** | `91.99.104.132` |
| **User** | `deploy` |
| **Auth** | SSH key only |
| **Web root** | `/var/www/slebstaendig/` |
| **Existing project** | LOGOS at `/var/www/logos/` |

### Connection
```bash
ssh deploy@91.99.104.132
```

### Critical rules
- NEVER use `root@` — Root SSH is disabled
- NEVER use passwords — Password auth is disabled
- Always use `deploy` user

---

## 5) Domain (to be confirmed)

- Primary: `slebstaendig.de`
- With www: `www.slebstaendig.de`
- DNS: A record → `91.99.104.132`

---

## 6) Deployment workflow

```
1. SSH into VM
2. cd /home/deploy/apps/slebstaendig
3. git pull
4. npm install (if deps changed)
5. npm run build
6. Copy dist/* to /var/www/slebstaendig/
7. Reload nginx (if config changed)
```

Or use `deploy.sh` script for automation.

---

## 7) Security baseline

### HTTP headers (nginx)
- Content-Security-Policy (permissive start)
- X-Content-Type-Options: nosniff
- X-Frame-Options: DENY
- Referrer-Policy: strict-origin-when-cross-origin
- Permissions-Policy: minimal

### TLS
- Modern ciphers via certbot defaults
- HSTS enabled
- HTTP → HTTPS redirect

### Server
- No default server exposing welcome page
- Services start on boot
- fail2ban active

---

## 8) Documentation format

When proposing changes, output:
1. Summary of what will change
2. Commands to run (copy/paste)
3. Files to create/edit (full content)
4. Validation steps (curl, nginx -t, systemctl status)
5. Rollback steps

---

## 9) Error handling

If any command fails:
- Ask for exact output
- Propose minimal fix
- Avoid random guessing

---

## 10) Output style

- Be direct and step-by-step
- Prefer stable solutions
- No fluff
- Assume I can handle technical details
- Always consider least privilege and good defaults
