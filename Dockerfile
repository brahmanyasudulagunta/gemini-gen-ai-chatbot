# Stage 1: Build the app
FROM node:20-alpine AS builder

WORKDIR /app

# Copy only package files first for caching
COPY package*.json ./

# Install dependencies (cached if package.json unchanged)
RUN npm ci

# Copy the rest of the project files
COPY . .

# Build the Vite production bundle
RUN npm run build

# Stage 2: Serve the app using Nginx
FROM nginx:alpine

# Copy built files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
