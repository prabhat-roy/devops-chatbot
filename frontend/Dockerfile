# Frontend Dockerfile (Vite + React)
FROM node:20-slim AS build
WORKDIR /app

# Copy package files first for caching
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy rest of the frontend source (since build context is already ./frontend)
COPY . ./
RUN npm run build

# Serve with nginx
FROM nginx:alpine AS prod
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
