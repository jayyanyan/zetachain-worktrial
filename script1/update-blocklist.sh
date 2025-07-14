#!/bin/bash

# FireHOL level 1 blocklist (low false positives)
BLOCKLIST_URL="https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset"
BLOCKLIST_PATH="/etc/pf.blocklist"
LOG_FILE="/etc/updatepfblocklist.log"

# Create /etc/pf.blocklist if it doesn't exist
if [[ ! -f "$BLOCKLIST_PATH" ]]; then
  sudo touch "$BLOCKLIST_PATH"
fi

# Fetch the list and filter for valid IPs (in case there are comments or garbage)
# and outputs the IPs to the blocklist file
sudo curl -s $BLOCKLIST_URL \
  | grep -Eo '^([0-9]{1,3}\.){3}[0-9]{1,3}$' \
  | sort -u \
  | sudo tee $BLOCKLIST_PATH > /dev/null


# Replace pf table entries with new list
sudo pfctl -t bad_ips -T replace -f "$BLOCKLIST_PATH"

# Create log file if missing
if [[ ! -f "$LOG_FILE" ]]; then
  sudo touch "$LOG_FILE"
  sudo chmod 644 "$LOG_FILE"
fi

# Log the update
echo "$(date): Updated blocklist with $(wc -l < $BLOCKLIST_PATH) IPs" | sudo tee -a "$LOG_FILE" > /dev/null
