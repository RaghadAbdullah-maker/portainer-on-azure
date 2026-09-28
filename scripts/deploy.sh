#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
COMPOSE_FILE="$PROJECT_DIR/docker/docker-compose.yml"

echo "Checking deployment requirements..."

if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed."
    exit 1
fi

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: docker-compose.yml was not found."
    exit 1
fi

echo "Starting Portainer stack..."

docker compose -f "$COMPOSE_FILE" up -d

echo "Deployment completed."
docker compose -f "$COMPOSE_FILE" ps