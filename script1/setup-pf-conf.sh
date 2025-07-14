#The following script is used to add the following lines to the /etc/pf.conf file

#!/bin/bash

PF_CONF="/etc/pf.conf"

#check_rule checks if the rule exists in the pf.conf file and adds it if not
check_rule() {
    local rule="$1"
    if sudo grep -Fqx "$rule" "$PF_CONF"; then
        #used for debugging
        #echo "Found: $rule"
        return 0
    else
        echo "$rule" | sudo tee -a $PF_CONF > /dev/null
        return 1
    fi
}

check_rule 'table <bad_ips> persist file "/etc/pf.blocklist"'
check_rule 'block log out quick from any to <bad_ips>'
check_rule 'block log in quick from <bad_ips> to any'


# Anchor block
#echo 'table <bad_ips> persist file "/etc/pf.blocklist"' | sudo tee -a /etc/pf.conf > /dev/null

#blocks and logs traffic from and to the bad_ips table
#echo 'block log out quick from any to <bad_ips>' | sudo tee -a /etc/pf.conf > /dev/null
#echo 'block log in quick from <bad_ips> to any' | sudo tee -a /etc/pf.conf > /dev/null
