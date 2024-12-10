#!/bin/bash

# This script updates the device IDs used by the Cursor editor.
# If you've been locked out due to frequently switching accounts,
# this script can help by resetting the device IDs.

# Configuration file path
STORAGE_FILE="$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"

# Function: Generate a random ID (hex format)
generate_random_id() {
    openssl rand -hex 32
}

# Function: Generate a random UUID (lowercase)
generate_random_uuid() {
    uuidgen | tr '[:upper:]' '[:lower:]'
}

# New IDs to be used.
# If a custom machine ID is passed as the first argument, use it;
# otherwise, generate a random one.
NEW_MACHINE_ID=${1:-$(generate_random_id)}
NEW_MAC_MACHINE_ID=$(generate_random_id)
NEW_DEV_DEVICE_ID=$(generate_random_uuid)

# Create a backup of the existing storage file
backup_file() {
    if [ -f "$STORAGE_FILE" ]; then
        cp "$STORAGE_FILE" "${STORAGE_FILE}.backup_$(date +%Y%m%d_%H%M%S)"
        echo "Backup file created successfully."
    fi
}

# Ensure the parent directory exists
mkdir -p "$(dirname "$STORAGE_FILE")"

# Create a backup of the original file (if it exists)
backup_file

# If the storage file doesn't exist, create a new JSON file
if [ ! -f "$STORAGE_FILE" ]; then
    echo "{}" > "$STORAGE_FILE"
fi

# Update all telemetry IDs using Perl (we assume Perl is available on the system)
perl -i -pe 's/"telemetry\.machineId":\s*"[^"]*"/"telemetry.machineId": "'$NEW_MACHINE_ID'"/' "$STORAGE_FILE"
perl -i -pe 's/"telemetry\.macMachineId":\s*"[^"]*"/"telemetry.macMachineId": "'$NEW_MAC_MACHINE_ID'"/' "$STORAGE_FILE"
perl -i -pe 's/"telemetry\.devDeviceId":\s*"[^"]*"/"telemetry.devDeviceId": "'$NEW_DEV_DEVICE_ID'"/' "$STORAGE_FILE"

echo "Device IDs updated successfully:"
echo "machineId: $NEW_MACHINE_ID"
echo "macMachineId: $NEW_MAC_MACHINE_ID"
echo "devDeviceId: $NEW_DEV_DEVICE_ID"
