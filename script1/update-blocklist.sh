#!/bin/bash

# FireHOL level 1 blocklist (low false positives)
BLOCKLIST_URL="https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset"
BLOCKLIST_PATH="/etc/pf.blocklist"

#checks if /etc/pf.blocklist exists, if not creates it
sudo touch /etc/pf.blocklist

# Fetch the list and filter for valid IPs (in case there are comments or garbage)
# and outputs the IPs to the blocklist file
curl -s "$BLOCKLIST_URL" -o "$BLOCKLIST_PATH"

# Replace pf table entries with new list
sudo pfctl -t bad_ips -T replace -f /etc/pf.blocklist

sudo touch /etc/updatepfblocklist.log
# Log the update
echo "$(date): Updated blocklist with $(wc -l < $BLOCKLIST_PATH) IPs" | sudo tee -a /etc/updatepfblocklist.log > /dev/null
