#used to set up pf configuration for blocking IPs
#!/bin/bash

echo 'anchor "blockips"' | sudo tee -a /etc/pf.conf > /dev/null
echo 'load anchor "blockips" from "/etc/pf.anchors/blockips"' | sudo tee -a /etc/pf.conf > /dev/null