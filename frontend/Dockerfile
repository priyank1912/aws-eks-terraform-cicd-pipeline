# Frontend Dockerfile
FROM node:24-alpine3.21 AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Use a lightweight web server to serve static files
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/dist .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]  
