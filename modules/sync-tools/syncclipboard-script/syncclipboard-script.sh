#!/bin/bash

# endpoint
ENDPOINT="{{ ENDPOINT_PLACEHOLDER }}"
CLIPBOARD_ENDPOINT="$ENDPOINT/SyncClipboard.json"

# credentials
USER="{{ USER_PLACEHOLDER }}"
PASS="{{ PASS_PLACEHOLDER }}"

# Temporary file to store the JSON response
TEMP_FILE=$(mktemp)

# Function to fetch and synchronize clipboard content
sync_clipboard() {
    # Fetch the JSON file from the endpoint with authentication
    curl -Ls -u "$USER:$PASS" -o "$TEMP_FILE" "$CLIPBOARD_ENDPOINT"

    # Extract the Type field
    TYPE=$(jq -r '.Type' "$TEMP_FILE")

    if [[ "$TYPE" == "Text" ]]; then
        # Extract the Clipboard content using jq
        CLIPBOARD_CONTENT=$(jq -r '.Clipboard' "$TEMP_FILE")

        # Get the current clipboard content
        CURRENT_CLIPBOARD=$(wl-paste)

        # Check if the fetched content is different from the current clipboard content
        if [[ "$CLIPBOARD_CONTENT" != "$CURRENT_CLIPBOARD" ]]; then
            # Copy the content to the system clipboard using wl-copy
            echo -n "$CLIPBOARD_CONTENT" | wl-copy
        fi
    fi
}

# Function to upload the current clipboard content
upload_clipboard() {
    # Get the current clipboard content type using wl-paste -l
    CLIPBOARD_TYPE=$(wl-paste -l)

    # Only proceed if the clipboard type is TEXT
    if echo "$CLIPBOARD_TYPE" | grep -q "text/plain"; then
        # Get the current clipboard content
        CURRENT_CLIPBOARD=$(wl-paste)

        # Construct the JSON content with minimized output
        JSON_CONTENT=$(jq -c -n --arg clipboard "$CURRENT_CLIPBOARD" \
            '{File: "", Clipboard: $clipboard, Type: "Text"}')

        # Save the JSON content to the temporary file
        echo "$JSON_CONTENT" >"$TEMP_FILE"

        # Upload the JSON file to the WebDAV endpoint with authentication
        curl -s -u "$USER:$PASS" -T "$TEMP_FILE" "$CLIPBOARD_ENDPOINT"
    fi
}

# Ensure cleanup of background processes on script exit
cleanup() {
    pkill -P $$
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT

# Function to run in daemon mode
daemon_mode() {
    # Monitor clipboard changes and upload in a subshell
    wl-paste -w bash "$(dirname $(readlink -f $0))/$(basename $0)" upload &

    while true; do
        # Synchronize clipboard every 5 seconds
        sync_clipboard
        sleep 5
    done
}

# Check script arguments
if [[ "$1" == "sync" ]]; then
    sync_clipboard
    exit 0
elif [[ "$1" == "upload" ]]; then
    upload_clipboard
    exit 0
elif [[ "$1" == "daemon" ]]; then
    daemon_mode
    exit 0
else
    echo "Usage: $0 {sync|upload|daemon}"
    exit 1
fi
