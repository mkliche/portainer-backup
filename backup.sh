#!/usr/bin/env bash
P_USER=${P_USER:-"root"}
P_PASS=${P_PASS:-"password"}
P_URL=${P_URL:-"http://localhost:9000"}
BACKUP_EXPIRY_DAYS=${BACKUP_EXPIRY_DAYS:-"365"}

echo "Logging in..."
P_TOKEN=$(curl -s -X POST -H "Content-Type: application/json;charset=UTF-8" -d "{\"username\":\"$P_USER\",\"password\":\"$P_PASS\"}" "$P_URL/api/auth")
if [[ $P_TOKEN = *"jwt"* ]]; then
  echo " ... success"
else
  echo "Result: failed to login"
  exit 1
fi
T=$(echo $P_TOKEN | awk -F '"' '{print $4}')
echo "Token: $T"

INFO=$(curl -s -H "Authorization: Bearer $T" "$P_URL/api/endpoints/1/docker/info")
CID=$(echo "$INFO" | awk -F '"ID":"' '{print $2}' | awk -F '"' '{print $1}')
echo "Cluster ID: $CID"

echo "Downloading backup..."
curl -O -J --output-dir /backup -X POST -H "Authorization: Bearer $T" -d "{}" "$P_URL/api/backup" && \
echo "Deleting old backups..." && \
find /backup -mmin +$BACKUP_EXPIRY_DAYS -type f -delete
