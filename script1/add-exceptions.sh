#The following script is used to add the following lines to the /etc/pf.conf file

#!/bin/bash

# Create variables for file paths
PF_CONF="/etc/pf.conf"

# add_exception checks if the rule exists in the pf.conf file and adds it if not
add_exception() {
    local ip="$1"
    if (sudo grep -Fqx "pass quick from $ip to any" "$PF_CONF") && (sudo grep -Fqx "pass quick to $ip to any" "$PF_CONF") ; then
        #used for debugging
        #echo "Found: $rule"
        return 0
    else
        # adds the exception rules to the pf.conf file
        echo "pass quick from $ip to any" | sudo tee -a "$PF_CONF" > /dev/null
        echo "pass quick to $ip to any" | sudo tee -a "$PF_CONF" > /dev/null

        return 1
    fi
}

# test case
#add_exception '1.1.1.1'