#!/bin/bash
set -e

# Use environment variable for port, default to 27017
MONGO_PORT=${MONGO_PORT:-27017}

# Run the health check
echo "db.runCommand('ping')" | mongosh --port "$MONGO_PORT" --quiet
