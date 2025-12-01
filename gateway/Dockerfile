# Production Dockerfile for Gateway

FROM node:20-alpine AS production

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev && npm cache clean --force

# Copy source code
COPY src ./src

# Expose gateway port (this is the only externally exposed port)
EXPOSE 5921

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:5921/health || exit 1

# Start the application
CMD ["node", "src/gateway.js"]