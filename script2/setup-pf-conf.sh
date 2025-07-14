#The following script is used to add the following lines to the /etc/pf.conf file
#!/bin/bash

echo 'anchor "blockips"' | sudo tee -a /etc/pf.conf > /dev/null
echo 'load anchor "blockips" from "/etc/pf.anchors/blockips"' | sudo tee -a /etc/pf.conf > /dev/null

