
# Define file locations
BLOCKLIST_URL="https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset"
ANCHOR_FILE="/etc/pf.anchors/blocklist"
TMP_FILE="/tmp/firehol_blocklist.txt"

# initiate download of IP addresses from FireHOL
echo "Downloading malicious IP list from FireHOL..."
curl -s "$BLOCKLIST_URL" -o "$TMP_FILE"

if [[ ! -s "$TMP_FILE" ]]; then
    echo "[!] Failed to download or list is empty."
    exit 1
fi

# initiate writing to anchor file
echo "Generating pf rules..."
echo "# Auto-generated blocklist" | sudo tee "$ANCHOR_FILE" > /dev/null

# writing the commands to block ips to the anchor file
while IFS= read -r ip; do
    echo "block drop log from $ip to any" | sudo tee -a "$ANCHOR_FILE" > /dev/null
done < "$TMP_FILE"

# initiate reloading of the firewall rules
echo "[+] Reloading pf firewall rules..."
sudo pfctl -f /etc/pf.conf
sudo pfctl -e

# done
echo "Malicious IPs blocked via pf."