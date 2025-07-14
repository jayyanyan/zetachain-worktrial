#The following script is used to add the following lines to the /etc/pf.conf file
#!/bin/bash

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

check_rule 'anchor "blockips"'
check_rule 'load anchor "blockips" from "/etc/pf.anchors/blockips"'

