
# Variables
COMPOSE_DEV = docker-compose -f docker/compose.development.yaml --env-file .env
COMPOSE_PROD = docker-compose -f docker/compose.production.yaml --env-file .env

# Default target
.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Development:"
	@echo "  dev-up        Start development environment"
	@echo "  dev-down      Stop development environment"
	@echo "  dev-build     Build development containers"
	@echo "  dev-logs      View development logs"
	@echo "  dev-restart   Restart development services"
	@echo "  dev-ps        Show running development containers"
	@echo ""
	@echo "Production:"
	@echo "  prod-up       Start production environment"
	@echo "  prod-down     Stop production environment"
	@echo "  prod-build    Build production containers"
	@echo "  prod-logs     View production logs"
	@echo "  prod-restart  Restart production services"
	@echo "  prod-ps       Show running production containers"
	@echo ""
	@echo "Utilities:"
	@echo "  logs          View logs (use SERVICE=backend or SERVICE=gateway)"
	@echo "  shell         Open shell in container (use SERVICE=backend or SERVICE=gateway)"
	@echo "  mongo-shell   Open MongoDB shell"
	@echo "  health        Check service health"
	@echo "  clean         Remove all containers and networks"
	@echo "  clean-all     Remove containers, networks, volumes, and images"

# ==================== Development ====================

.PHONY: dev-up
dev-up:
	$(COMPOSE_DEV) up -d --build

.PHONY: dev-down
dev-down:
	$(COMPOSE_DEV) down

.PHONY: dev-build
dev-build:
	$(COMPOSE_DEV) build

.PHONY: dev-logs
dev-logs:
	$(COMPOSE_DEV) logs -f

.PHONY: dev-restart
dev-restart:
	$(COMPOSE_DEV) restart

.PHONY: dev-ps
dev-ps:
	$(COMPOSE_DEV) ps

# ==================== Production ====================

.PHONY: prod-up
prod-up:
	$(COMPOSE_PROD) up -d --build

.PHONY: prod-down
prod-down:
	$(COMPOSE_PROD) down

.PHONY: prod-build
prod-build:
	$(COMPOSE_PROD) build

.PHONY: prod-logs
prod-logs:
	$(COMPOSE_PROD) logs -f

.PHONY: prod-restart
prod-restart:
	$(COMPOSE_PROD) restart

.PHONY: prod-ps
prod-ps:
	$(COMPOSE_PROD) ps

# ==================== Utilities ====================

.PHONY: logs
logs:
	$(COMPOSE_DEV) logs -f $(SERVICE)

.PHONY: shell
shell:
	docker exec -it $(or $(SERVICE),backend)-dev sh

.PHONY: mongo-shell
mongo-shell:
	docker exec -it mongo-dev mongosh -u admin -p password123 --authenticationDatabase admin

.PHONY: health
health:
	@echo "Checking Gateway health..."
	@curl -s http://localhost:5921/health || echo "Gateway not responding"
	@echo ""
	@echo "Checking Backend health via Gateway..."
	@curl -s http://localhost:5921/api/health || echo "Backend not responding"

.PHONY: clean
clean:
	$(COMPOSE_DEV) down --remove-orphans
	$(COMPOSE_PROD) down --remove-orphans

.PHONY: clean-all
clean-all:
	$(COMPOSE_DEV) down -v --remove-orphans --rmi all
	$(COMPOSE_PROD) down -v --remove-orphans --rmi all

