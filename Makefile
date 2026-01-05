# Variables
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = $(HOME)/data

# Colors
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
NC = \033[0m

.PHONY: all build up down clean fclean re logs ps

all: build up

# Create data directories for volumes
setup:
	@echo "$(YELLOW)Creating data directories...$(NC)"
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@echo "$(GREEN)Data directories created!$(NC)"

# Build all containers
build: setup
	@echo "$(YELLOW)Building containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) build
	@echo "$(GREEN)Build completed!$(NC)"

# Start all containers
up:
	@echo "$(YELLOW)Starting containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)Containers are running!$(NC)"
	@echo "$(YELLOW)Access WordPress at: https://zchtaibi.42.fr$(NC)"

# Stop all containers
down:
	@echo "$(YELLOW)Stopping containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)Containers stopped!$(NC)"

# Clean containers and images
clean: down
	@echo "$(YELLOW)Cleaning containers and images...$(NC)"
	@docker system prune -af
	@echo "$(GREEN)Clean completed!$(NC)"

# Full clean including volumes and data
fclean: clean
	@echo "$(RED)Removing volumes and data directories...$(NC)"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf $(DATA_PATH)/mariadb
	@sudo rm -rf $(DATA_PATH)/wordpress
	@echo "$(GREEN)Full clean completed!$(NC)"

# Rebuild everything
re: fclean all

# Show container logs
logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

# Show running containers
ps:
	@docker-compose -f $(COMPOSE_FILE) ps
