#!/bin/bash

PORTAINER_URL="https://localhost:9443"
NGINX_URL="http://localhost:8080"

echo "Running service health checks..."

echo "Checking Nginx..."

if curl -f -s "$NGINX_URL" > /dev/null; then
    echo "Nginx: HEALTHY"
else
    echo "Nginx: UNHEALTHY"
fi

echo "Checking Portainer..."

if curl -k -f -s "$PORTAINER_URL" > /dev/null; then
    echo "Portainer: HEALTHY"
else
    echo "Portainer: UNHEALTHY"
fi