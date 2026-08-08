# Frontend en dev (Vite con HMR). Contexto de build = apps/web.
FROM node:22-alpine

WORKDIR /srv/web

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host"]
