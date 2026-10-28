FROM node:22-alpine

WORKDIR /app

RUN apk add --no-cache wget

COPY package*.json ./
COPY frontend/package*.json ./frontend/
COPY backend/package*.json ./backend/

RUN npm install
RUN npm install --prefix ./frontend
RUN npm install --prefix ./backend

COPY . .

RUN npm run build

ENV NODE_ENV=production
ENV PORT=8000

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8000/health || exit 1

CMD ["npm", "start"]
