#!/bin/bash
set -euo pipefail

ENV_FILE=/home/trainee/devops-lab/.env
BACKUP_DIR=/var/backups/db
DATE=$(date +%Y%m%d)

# Load credentials from .env
set -a
source "$ENV_FILE"
set +a

mkdir -p "$BACKUP_DIR"

docker exec db pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB" \
  | gzip > "$BACKUP_DIR/db_backup_$DATE.sql.gz"

echo "Backup created: $BACKUP_DIR/db_backup_$DATE.sql.gz"
