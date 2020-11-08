#!/bin/bash

ENV_VARS_FILE="/root/.env.sh"

echo "Writing env variables to ${ENV_VARS_FILE}"
printenv | sed 's/^\(.*\)$/export \1/g' > ${ENV_VARS_FILE}
chmod +x ${ENV_VARS_FILE}

echo "Applying crontab"
crontab /etc/cron.d/crontab

echo "Running crontab"
cron -f
