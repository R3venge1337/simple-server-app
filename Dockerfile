# Etap 1: Budowanie statycznych plików na szybkim serwerze GitHuba
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Etap 2: Serwowanie gotowych plików przez super lekki Nginx
FROM nginx:alpine

# Kopiujemy skompilowany folder /dist do katalogu Nginxa
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]