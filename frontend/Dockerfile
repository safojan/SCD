# Stage 1: Build the React app
FROM node:18-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app for production 
RUN npm run build

# Stage 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the build folder from the first stage into Nginx's html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Run Nginx in the foreground (prevent container from exiting)
CMD ["nginx", "-g", "daemon off;"]
