#!/bin/bash
set -e

MONGO_PORT=${MONGO_PORT:-27017}
MONGO_REPLICA_SET=${MONGO_REPLICA_SET:-rs0}
MONGO_KEYFILE=${MONGO_KEYFILE:-/etc/mongo-keyfile}

echo "   Port: $MONGO_PORT"
echo "   Replica Set: $MONGO_REPLICA_SET"
echo "   Keyfile: $MONGO_KEYFILE"
echo "   Bind IP: $MONGO_BIND_IP"

# If we're running mongod, handle user creation on first run
if [ "$1" = 'mongod' ]; then
    # Check if this is first run (no data files)
    if [ ! -f /data/db/mongod.lock ]; then
        echo "🔧 First run - creating instance user..."
        
        # Start MongoDB temporarily without keyfile AND without replica set
        mongod --port "$MONGO_PORT" --bind_ip_all --fork --logpath /tmp/init.log
        
        # Wait for MongoDB to start
        until mongosh --port "$MONGO_PORT" --eval "db.runCommand('ping')" >/dev/null 2>&1; do
            sleep 1
        done
        
        # Create instance-specific user based on environment variables
        if [ -n "$MONGO_INITDB_ROOT_USERNAME" ] && [ -n "$MONGO_INITDB_ROOT_PASSWORD" ]; then
            mongosh --port "$MONGO_PORT" admin --eval "
            db.createUser({
                user: '$MONGO_INITDB_ROOT_USERNAME', 
                pwd: '$MONGO_INITDB_ROOT_PASSWORD', 
                roles:[{role: 'root', db: 'admin'}]
            });"
        fi
        
        # Stop temporary instance
        mongosh --port "$MONGO_PORT" admin --eval "db.shutdownServer()" >/dev/null 2>&1 || true
        sleep 2
    fi
    
    # Start MongoDB normally with keyfile
    exec mongod \
        --port "$MONGO_PORT" \
        --bind_ip_all \
        --replSet "$MONGO_REPLICA_SET" \
        --keyFile "$MONGO_KEYFILE"
else
    # Pass through any other commands
    exec "$@"
fi
