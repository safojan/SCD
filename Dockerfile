# This Dockerfile builds both backend and frontend, but in practice
# you might want to keep them separate for independent scaling

# Build backend
FROM node:18-alpine AS backend-build

WORKDIR /app/backend

# Copy backend package.json and install dependencies
COPY backend/package*.json ./
RUN npm install

# Copy backend source
COPY backend/ ./

# Build frontend
FROM node:18-alpine AS frontend-build

WORKDIR /app/frontend

# Copy frontend package.json and install dependencies
COPY frontend/package*.json ./
RUN npm install

# Copy frontend source and build
COPY frontend/ ./
RUN npm run build

# Final image with both services
FROM node:18-alpine

# Copy backend from backend-build
WORKDIR /app/backend
COPY --from=backend-build /app/backend ./

# Copy frontend build to serve from backend
COPY --from=frontend-build /app/frontend/build ../frontend/build

# Expose backend port
EXPOSE 5000

# Start the backend server
CMD ["node", "index.js"]