# Handover Prompt for AI Assistant

Read this document to continue working on this project.

---

## Project Overview

**What:** Personal portfolio website for Konrad Reyhe
**URL:** https://konradreyhe.de (not yet deployed)
**Repo:** https://github.com/KonradReyhe/konradreyhe
**Tech:** Astro 5 + Tailwind CSS v4 + TypeScript

---

## Owner Profile

- **Name:** Konrad Reyhe
- **Role:** Fachinformatiker für Anwendungsentwicklung (Software Developer)
- **Experience:** ~3 years (including 2 year training)
- **Current Job:** 8 months at an energy company, building internal tools
- **Specialty:** Automation, data pipelines, internal tools
- **Unique Angle:** Early adopter of AI-assisted development (Claude, Cursor)
- **Email:** kreyhe@yahoo.com
- **LinkedIn:** https://www.linkedin.com/in/konrad-reyhe-6a055b293/
- **GitHub:** https://github.com/KonradReyhe

---

## Project Status

### Completed
- [x] DevPortfolio template cloned and configured
- [x] Config updated with personal info
- [x] Projects section hidden (can't show employer work)
- [x] LinkedIn + GitHub added
- [x] Bio updated (early AI adopter, DRY/SOLID principles)
- [x] Git initialized and pushed to GitHub
- [x] README with code principles
- [x] Server/deployment docs created

### Pending
- [ ] Domain registration (konradreyhe.de)
- [ ] DNS setup (A record → 91.99.104.132)
- [ ] Server deployment
- [ ] SSL certificate (certbot)
- [ ] Profile picture (user mentioned adding one)
- [ ] Impressum/legal pages (need real address)

---

## Server Details

| Property | Value |
|----------|-------|
| IP | 91.99.104.132 |
| User | deploy |
| Auth | SSH key only (NO passwords, NO root) |
| Web root | /var/www/konradreyhe |
| Existing project | LOGOS at /var/www/logos/ |

**Connect:** `ssh deploy@91.99.104.132`

---

## Key Files

| File | Purpose |
|------|---------|
| `src/config.ts` | ALL site content (name, bio, skills, etc.) |
| `docs/DEPLOYMENT.md` | Full deployment guide |
| `docs/AI_GTM_CONTEXT.md` | Marketing/sales strategy |
| `infra/nginx/konradreyhe.conf` | nginx config (HTTPS) |
| `infra/nginx/konradreyhe-initial.conf` | nginx config (HTTP, pre-SSL) |
| `deploy.sh` | One-command deploy script |
| `SERVER.md` | Server access docs |

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

1. **No portfolio section** - Can't show projects from employer
2. **Side business** - Testing market for freelance work
3. **Employer situation** - Works at energy company, needs clean separation
4. **Focus** - Automation, internal tools, data pipelines
5. **Pricing** - Fixed-price pilots, not hourly

---

## Next Steps When Resuming

1. Ask if domain is registered
2. If yes, guide through DNS setup
3. Deploy to server using `docs/DEPLOYMENT.md`
4. Add profile picture if provided
5. Set up Impressum with real address

---

## Commands Reference

```bash
# Development
cd C:\Users\kreyh\Projekte\devportfolio-temp
npm run dev

# Build
npm run build

# Deploy (after server setup)
./deploy.sh

# Git
git add .
git commit -m "type: description"
git push
```

---

## Always Remember

- **Commit and document regularly**
- **Keep code DRY, SOLID, KISS, YAGNI**
- **User prefers pragmatic solutions over fancy complexity**
- **No dashes (—) in content - user dislikes them**
- **German content preferred**

---

*Last updated: 2024-12-31*
