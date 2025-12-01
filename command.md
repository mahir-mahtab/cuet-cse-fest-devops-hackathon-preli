# Docker Commands

## Development

```bash
# Start development environment
docker-compose -f docker/compose.development.yaml --env-file .env up -d --build

# Stop development environment
docker-compose -f docker/compose.development.yaml --env-file .env down

# View development logs
docker-compose -f docker/compose.development.yaml --env-file .env logs -f

# Restart development services
docker-compose -f docker/compose.development.yaml --env-file .env restart

# Show running containers
docker-compose -f docker/compose.development.yaml --env-file .env ps
```

## Production

```bash
# Start production environment
docker-compose -f docker/compose.production.yaml --env-file .env up -d --build

# Stop production environment
docker-compose -f docker/compose.production.yaml --env-file .env down

# View production logs
docker-compose -f docker/compose.production.yaml --env-file .env logs -f

# Restart production services
docker-compose -f docker/compose.production.yaml --env-file .env restart

# Show running containers
docker-compose -f docker/compose.production.yaml --env-file .env ps
```

## Cleanup

```bash
# Remove containers and networks (development)
docker-compose -f docker/compose.development.yaml --env-file .env down --remove-orphans

# Remove containers and networks (production)
docker-compose -f docker/compose.production.yaml --env-file .env down --remove-orphans

# Remove everything including volumes and images (development)
docker-compose -f docker/compose.development.yaml --env-file .env down -v --remove-orphans --rmi all

# Remove everything including volumes and images (production)
docker-compose -f docker/compose.production.yaml --env-file .env down -v --remove-orphans --rmi all
```
