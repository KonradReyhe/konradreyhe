# konradreyhe.de

Personal portfolio website. Software Developer & Automation Specialist.

## Stack

| Tool | Purpose |
|------|---------|
| Astro 5 | Static site generator |
| Tailwind CSS v4 | Styling |
| TypeScript | Type safety |

## Commands

```bash
npm install      # Install deps
npm run dev      # Dev server (localhost:4321)
npm run build    # Production build
npm run preview  # Preview build
./deploy.sh      # Deploy to server
```

## Configuration

All content lives in `src/config.ts`:

```typescript
siteConfig = {
  name, title, description,
  accentColor,
  social: { email, linkedin, github },
  aboutMe,
  skills: [...],
  projects: [...],    // Empty = hidden
  experience: [...],
  education: [...],
}
```

## Structure

```
src/
├── components/     # UI components
├── pages/          # Routes
├── styles/         # Global CSS
└── config.ts       # Content
docs/               # Documentation
infra/nginx/        # Server configs
```

## Deployment

Server: `deploy@91.99.104.132`
Domain: `konradreyhe.de`
Web root: `/var/www/konradreyhe`

Full guide: `docs/DEPLOYMENT.md`

---

## Code Principles

### DRY (Don't Repeat Yourself)
- Single config file for all content
- Reusable components
- Tailwind utilities over custom CSS

### SOLID
- Single Responsibility: one component = one job
- Open/Closed: extend via config, not code changes
- Interface Segregation: minimal component props
- Dependency Inversion: components read config

### KISS (Keep It Simple)
- Static site, no runtime
- Config-driven content
- Minimal dependencies
- No unnecessary abstractions

### YAGNI (You Aren't Gonna Need It)
- No features until needed
- No portfolio section yet
- No blog yet
- No analytics yet

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

**Commit regularly. Small commits > big commits.**

---

## Links

- Live: https://konradreyhe.de
- Repo: https://github.com/KonradReyhe/konradreyhe
