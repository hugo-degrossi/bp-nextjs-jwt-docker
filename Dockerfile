FROM node:14-alpine AS builderWORKDIR "/api"

COPY . .

RUN npm ci
RUN npm run build
RUN npm prune --production

FROM node:14-alpine AS productionWORKDIR "/api"

COPY --from=builder /api/package.json ./package.json
COPY --from=builder /api/package-lock.json ./package-lock.json
COPY --from=builder /api/dist ./dist
COPY --from=builder /api/node_modules ./node_modules

CMD [ "sh", "-c", "npm run start:prod"]