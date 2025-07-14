# zetachain-worktrial

macOS Malicious IP Blocker with PF & Threat Feed

Files Included

| File | Purpose |
|------|---------|
| `update-blocklist.sh` | Fetches and updates the IP blocklist |
| `setup-pf-conf.sh` | Adds PF rules to `/etc/pf.conf` if missing |
| `README.md` | This setup guide |
| `add-exceptions.sh` | Adds whitelisted ip as PF rules to `/etc/pf.conf` | 

Prerequisites

- macOS Ventura or later
- Administrator (sudo) access
- Command line tools (`curl`, `pfctl`, `grep`, etc.)

Setup Instructions

1. Setup PF Rules
Running the following script will configure the PF rules

sudo ./setup-pf-conf.sh

if script does not run, run the following then rerun the script

chmod +x setup-pf-conf.sh

2. Run the update-blocklist.sh script
Running the script will fetch a new list of malicious IPs from FireHOL
Updates the PF table
Restarts the PF process

sudo ./update-blocklist.sh

if script does not run, run the following then rerun the script

chmod +x update-blocklist.sh

3. Running the update-blocklist.sh script on an interval
If you have an MDM in place that can regularly schedule the script to run,
you can upload the script and run it via a reoccuring policy.

Example: JAMF
-upload the script to jamf
-create a policy and add the script to the policy
-set frequency to on check in

If you do not have an MDM you can set the script to run regularly on your Mac

chmod 644 ~/Library/LaunchAgents/com.local.pfblocklist.plist
launchctl load ~/Library/LaunchAgents/com.local.pfblocklist.plist
