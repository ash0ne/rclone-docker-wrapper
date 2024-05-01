#!/bin/bash

# Define function to sync data
sync_data() {
    if [ "$DRY_RUN" = "true" ]; then
        echo "Performing a dry run..."
        echo "-----------------------"
        rclone sync /data "$REMOTE":/rclone-backup-test --dry-run
    else
        rclone sync /data "$REMOTE":/rclone-backup-test --verbose
    fi
}

# Check if another rclone sync process is already running
if pgrep -x "rclone" | grep -q "sync"; then
    echo "Another rclone sync in progress."
    exit 0
fi

# Validate sleep duration
if [[ "$INTERVAL" =~ ^[0-9]+$ ]]; then
    sleep_duration="$INTERVAL"
else
    echo "Invalid interval. Defaulting to 1 hour."
    sleep_duration=3600
fi

# Loop to sync data
while true
do
    sync_data
    sleep "$sleep_duration"
done
