#The following script is used to add the following lines to the /etc/pf.conf file

#!/bin/bash

PF_CONF="/etc/pf.conf"

# checks if /etc/pf.conf exists, if not creates it
if [[ ! -f "$PF_CONF" ]]; then
  sudo touch "$PF_CONF"
fi

#check_rule checks if the rule exists in the pf.conf file and adds it if not
check_rule() {
    local rule="$1"
    if sudo grep -Fqx "$rule" "$PF_CONF"; then
        #used for debugging
        #echo "Found: $rule"
        return 0
    else
        echo "$rule" | sudo tee -a "$PF_CONF" > /dev/null
        return 1
    fi
}

check_rule 'table <bad_ips> persist file "/etc/blocklist"'
check_rule 'block out quick from any to <bad_ips>'
check_rule 'block in quick from <bad_ips> to any'

# reloads the pf configuration
sudo pfctl -f /etc/pf.conf
sudo pfctl -e



# Anchor block
#echo 'table <bad_ips> persist file "/etc/pf.blocklist"' | sudo tee -a /etc/pf.conf > /dev/null

#blocks and logs traffic from and to the bad_ips table
#echo 'block log out quick from any to <bad_ips>' | sudo tee -a /etc/pf.conf > /dev/null
#echo 'block log in quick from <bad_ips> to any' | sudo tee -a /etc/pf.conf > /dev/null
