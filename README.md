# NestJS Service Template — LaunchPad Ready

A minimal, production-ready NestJS service pre-configured for deployment on [Techinoid LaunchPad](https://launchpad.techinoid.app).

## What's included

- `GET /api/v1/health` — LaunchPad readiness/liveness probe endpoint
- Multi-stage `Dockerfile` (build → slim production image)
- `ConfigModule` for environment variable management
- `PORT` env var support (default: `3000`)

---

## Local development

```bash
npm install
cp .env.example .env
npm run start:dev
```

Check health: `curl http://localhost:3000/api/v1/health`

---

## Deploying on LaunchPad

### 1 — Push to GitHub

Push this repo to GitHub (can be private — see [Private Repo Access](#private-repo-access) below).

### 2 — Create a Product in the portal

Go to **LaunchPad → Products → New Product**:

| Field | Value |
|-------|-------|
| Name | Your service name |
| Repository URL | `https://github.com/your-org/your-repo.git` |
| Default branch | `main` |

### 3 — Add an Environment

In the product detail → **Environments tab → Add Environment**:

| Field | Value |
|-------|-------|
| Name | `production` |
| Branch | `main` |

### 4 — Add a Service

In the product detail → **Services tab → Add Service**:

| Field | Value |
|-------|-------|
| Name | `api` (or any name) |
| Dockerfile path | `Dockerfile` |
| Source path | `.` |
| Container port | `3000` |
| Health check path | `/api/v1/health` |
| Exposure type | `PUBLIC` or `INTERNAL` |

### 5 — Add environment variables (optional)

**Secrets tab** → add your variables (e.g. `DATABASE_URL`, `REDIS_URL`).  
They are encrypted at rest and injected into the pod at runtime.

### 6 — Deploy

Click **Deploy** in the portal, or push to your configured branch to trigger auto-deploy via webhook.

---

## Private Repo Access

If your repo is private, add a **Deploy Key** to your GitHub repo with read access, and configure the SSH key in the LaunchPad Secrets tab as `GIT_SSH_KEY`.

---

## Structure

```
.
├── Dockerfile
├── .dockerignore
├── nest-cli.json
├── package.json
├── tsconfig.json
├── .env.example
└── src/
    ├── main.ts          # App bootstrap, reads PORT from env
    ├── app.module.ts    # Root module
    ├── app.controller.ts # GET /health + root route
    └── app.service.ts
```

---

## Customising

Add your modules under `src/` following standard NestJS patterns. The `/api/v1/health` route **must stay available** — LaunchPad uses it to determine pod readiness.
