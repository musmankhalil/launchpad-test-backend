# ── deps ──────────────────────────────────────────────────────────────────────
FROM node:22-alpine AS deps
WORKDIR /app
COPY package*.json ./
# Use npm install so it works with or without a lockfile
RUN npm install

# ── builder ───────────────────────────────────────────────────────────────────
FROM deps AS builder
COPY . .
RUN npm run build

# ── runner ────────────────────────────────────────────────────────────────────
FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Production dependencies only
COPY package*.json ./
RUN npm install --omit=dev

# Built output
COPY --from=builder /app/dist ./dist

# LaunchPad sets PORT via environment — default 3000
EXPOSE 3000

CMD ["node", "dist/main"]
