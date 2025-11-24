# --- 1. Build Stage ---
FROM node:20-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy entire project
COPY . .

# Build Next.js
RUN npm run build


# --- 2. Production Stage ---
FROM node:20-alpine AS runner
WORKDIR /app

# Copy EVERYTHING from builder (including node_modules)
COPY --from=builder /app ./

ENV NODE_ENV=production

EXPOSE 3000

# Start Next.js production server
CMD ["npm", "start"]
