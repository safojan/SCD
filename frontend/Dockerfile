FROM node:18-alpine as build

WORKDIR /app/client

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

#expose the port 
EXPOSE 5000

# Build the application
CMD ["npm","run","start"]

