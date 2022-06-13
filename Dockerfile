FROM node:14-alpine AS builder
WORKDIR "/app"

COPY . .

WORKDIR "/app/api"

RUN npm ci
RUN npm run build
RUN npm prune --production

FROM node:14-alpine AS production
WORKDIR "/app/api"

COPY --from=builder /app/api/package.json ./package.json
COPY --from=builder /app/api/package-lock.json ./package-lock.json
COPY --from=builder /app/api/dist ./dist
COPY --from=builder /app/api/node_modules ./node_modules

CMD [ "sh", "-c", "npm run start:prod"]