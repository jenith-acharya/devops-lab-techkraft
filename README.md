DevOps Lab
A Techkraft Ubuntu DevOps lab using Docker, Nginx, Flask, PostgreSQL, Prometheus, and Node Exporter.

Stack
Ubuntu Server

Docker and Docker Compose

Nginx

Flask

PostgreSQL

Prometheus

Node Exporter

UFW

Bash scripts and cron

Git

Project Structure
devops-lab/
├── app/
├── nginx/
├── prometheus/
├── scripts/
├── screenshots/
├── docker-compose.yml
├── .env
├── .env.example
└── .gitignore
Setup
Created the project and environment file:

chmod 600 .env
Edited .env with the PostgreSQL settings.

Started the containers:

docker compose up -d
Checked the containers:

docker ps
Access
Web application:

http://VM_IP/
Prometheus:

http://VM_IP:9090/
Prometheus showed the node-exporter target as UP.

A basic Prometheus query:

node_cpu_seconds_total
SSH and Firewall
SSH was configured on port 2222 with key authentication and root login disabled.

Checked UFW:

sudo ufw status verbose
Required ports:

2222 - SSH

80 - Nginx

443 - HTTPS

9090 - Prometheus

9100 - Node Exporter

Health Check
Ran the health check manually:

sudo /opt/scripts/infra_health_check.sh
The script checks CPU, RAM, disk usage, Docker, and the application container.

Viewed the log:

cat /var/log/infra_health.log
The script was scheduled with cron every 15 minutes.

Database Backup
Ran a backup:

sudo /opt/scripts/db_backup.sh
Checked the backup:

ls -lh /var/backups/db/
Restored a backup:

gunzip -c /var/backups/db/db_backup_YYYYMMDD.sql.gz \
  | docker exec -i db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"
Loaded the .env file before running the restore command if the variables are not already available.

Git
Initialized the repository:

git init
git checkout -b main
The .env file is not committed.

Check tracked environment files:

git ls-files | grep .env


Security
Didn't not commit .env.

Kept .env permissions at 600.

Used SSH keys instead of password authentication.

Root SSH login is disabled.

Kept database passwords out of scripts and Docker Compose files.
