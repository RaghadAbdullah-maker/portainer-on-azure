#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
COMPOSE_FILE="$PROJECT_DIR/docker/docker-compose.yml"
PROJECT_NAME="azureadmin"

if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed."
    exit 1
fi

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: docker-compose.yml was not found."
    exit 1
fi

ACTION="$1"

case "$ACTION" in
    status)
        echo "Checking service status..."
        docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" ps
        ;;

    logs)
        echo "Showing service logs..."
        docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" logs --tail=50
        ;;

    restart)
        echo "Restarting services..."
        docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" restart
        ;;

    stop)
        echo "Stopping services..."
        docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" stop
        ;;
    
    cleanup)
        echo "Cleaning up deployment while preserving persistent data..."
        docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" down
        ;;
    *)
        echo "Usage: $0 {status|logs|restart|stop|cleanup}"
        exit 1
        ;;
esac

