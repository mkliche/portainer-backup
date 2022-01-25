# Bash scripts to interact with Portainer

# backup.sh
Backup Portainer installation via API

Requires:
* bash (or sh)
* jq
* curl

Usage:

* Set the following environmental variables or edit file and set the authentication details
```bash
P_USER="root"
P_PASS="password"
P_URL="http://example.com:9000"
BACKUP_EXPIRY_DAYS="365"
```

* run with
```bash
export P_USER="root"
export P_PASS="password"
export P_URL="http://example.com:9000"
export BACKUP_EXPIRY_DAYS="365"
./backup.sh
```
