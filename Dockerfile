FROM node:20-alpine

WORKDIR /app

# Accept API key as build argument
ARG VITE_API_KEY
ARG VITE_API_URL
# Set environment variable for React app
ENV VITE_API_KEY=${VITE_API_KEY}
ENV VITE_API_URL=${VITE_API_URL}

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Expose Vite default port
EXPOSE 5173

# Run the dev server (disable host checking for container)
CMD ["npm", "run", "dev"]
