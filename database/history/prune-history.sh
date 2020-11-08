#!/bin/bash

# Set working directory to the location of this script
cd "$(dirname "$0")";

for oldBackup in $(ls -d -1tr *.tgz | head -n -$BACKUPS_LIMIT); do
	chmod 744 $oldBackup
	rm -f $oldBackup
done
