FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Expose Vite default port
EXPOSE 5173

# Run the dev server (disable host checking for container)
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
