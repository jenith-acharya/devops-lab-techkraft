#!/bin/bash

LOG=/var/log/infra_health.log
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)
RAM=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "CPU: ${CPU}% | RAM: ${RAM}% | DISK: ${DISK}%"

if [ "$DISK" -gt 85 ]; then
    echo "[WARNING] Disk usage is ${DISK}%"
    echo "$TIMESTAMP [WARNING] Disk usage ${DISK}%" >> $LOG
fi

if ! systemctl is-active --quiet docker; then
    echo "[WARNING] Docker is not running"
    echo "$TIMESTAMP [WARNING] Docker not running" >> $LOG
fi

APP_STATUS=$(docker ps --filter "name=app" --filter "status=running" -q)
if [ -z "$APP_STATUS" ]; then
    echo "[WARNING] App container is not running"
    echo "$TIMESTAMP [WARNING] App container down" >> $LOG
fi
