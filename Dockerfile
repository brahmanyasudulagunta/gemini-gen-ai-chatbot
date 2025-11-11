# Step 1: Build stage
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the code
COPY . .

# Build the project
RUN npm run build

# Step 2: Production stage (Nginx)
FROM nginx:alpine

# Copy built files from build stage to nginx html directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for web
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
