#!/bin/bash

# Name of your launch agent file
PLIST_NAME="com.local.pfblocklist.plist"
SOURCE_PATH="$(pwd)/$PLIST_NAME"
TARGET_DIR="$HOME/Library/LaunchAgents"
TARGET_PATH="$TARGET_DIR/$PLIST_NAME"

echo "testing"
# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Move the .plist into place
echo "🔧 Moving $PLIST_NAME to $TARGET_DIR..."
mv "$SOURCE_PATH" "$TARGET_PATH" || {
    echo "❌ Failed to move $PLIST_NAME."
    exit 1
}

# Set correct permissions
chmod 644 "$TARGET_PATH"

# Load the LaunchAgent
echo "📡 Loading $PLIST_NAME into launchd..."
launchctl load -w "$TARGET_PATH" || {
    echo "❌ Failed to load $PLIST_NAME with launchctl."
    exit 1
}

echo "✅ LaunchAgent installed and loaded successfully."
