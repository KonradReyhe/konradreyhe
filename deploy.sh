#!/bin/bash
# deploy.sh - Deploy slebstaendig to production server
# Usage: ./deploy.sh

set -e  # Exit on error

# Configuration
SERVER="deploy@91.99.104.132"
REMOTE_APP_DIR="/home/deploy/apps/konradreyhe"
REMOTE_WEB_DIR="/var/www/konradreyhe"

echo "=== Deploying konradreyhe.de ==="

# Step 1: Build locally
echo "[1/4] Building locally..."
npm run build

# Step 2: Sync dist to server
echo "[2/4] Syncing files to server..."
rsync -avz --delete \
    --exclude '.git' \
    --exclude 'node_modules' \
    ./dist/ \
    "${SERVER}:${REMOTE_WEB_DIR}/"

# Step 3: Set correct permissions
echo "[3/4] Setting permissions..."
ssh "${SERVER}" "sudo chown -R www-data:www-data ${REMOTE_WEB_DIR}"

# Step 4: Test nginx config and reload
echo "[4/4] Reloading nginx..."
ssh "${SERVER}" "sudo nginx -t && sudo systemctl reload nginx"

echo ""
echo "=== Deployment complete ==="
echo "Site: https://konradreyhe.de"
