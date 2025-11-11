# ----------------------------------------------------
# STAGE 1: Builder
# Builds the production assets for the frontend application.
# ----------------------------------------------------
FROM node:20-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
# Note: Using 'npm ci' is often faster and more reliable than 'npm install' in CI
COPY package*.json ./
RUN npm install

# Copy source code and run the production build command
# This creates the optimized, static files (usually in a 'dist' folder for Vite/Next/etc.)
COPY . .
RUN npm run build 

# ----------------------------------------------------
# STAGE 2: Final / Runner
# Serves the static build artifacts using a lightweight server.
# ----------------------------------------------------
FROM node:20-alpine as final

# Set the working directory
WORKDIR /app

# Install 'serve' package globally to serve static files efficiently
RUN npm install -g serve

# Copy the built application from the builder stage (assuming output is 'dist')
# into a static folder in the final image.
COPY --from=builder /app/dist /usr/share/app/build

# EXPOSE the correct internal port (5171) which the 'serve' command will listen on
EXPOSE 5171

# Command to run the 'serve' web server:
# -s flag is for Single Page Application (SPA) routing (fallback to index.html)
# -l flag ensures it listens on the correct port 5171
CMD ["serve", "-s", "/usr/share/app/build", "-l", "5171"]
