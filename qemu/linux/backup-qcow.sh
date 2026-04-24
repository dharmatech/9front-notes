#!/usr/bin/env bash

set -euo pipefail

SRC="9front.qcow2.img"
BACKUP_DIR="backups"

# Ensure source exists
if [[ ! -f "$SRC" ]]; then
    echo "Error: $SRC not found"
    exit 1
fi

# Create backup directory if needed
mkdir -p "$BACKUP_DIR"

# Timestamp (sortable)
TS=$(date +"%Y-%m-%d_%H-%M-%S")

# Destination filename
DST="$BACKUP_DIR/9front.qcow2-$TS.img"

echo "Creating backup:"
echo "  Source: $SRC"
echo "  Dest:   $DST"

# Copy (reflink if possible = fast on supported FS)
cp --reflink=auto --sparse=always "$SRC" "$DST"

echo "Backup complete."
