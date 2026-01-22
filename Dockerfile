FROM node:20-alpine

WORKDIR /app

# Accept API key as build argument
ARG REACT_APP_API_KEY
# Set environment variable for React app
ENV REACT_APP_API_KEY=${REACT_APP_API_KEY}

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
