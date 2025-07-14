#The following script is used to add the following lines to the /etc/pf.conf file

# Anchor block
echo 'table <bad_ips> persist file "/etc/pf.blocklist"' | sudo tee -a /etc/pf.anchors/blockips > /dev/null

#blocks and logs traffic from and to the bad_ips table
echo 'block log out quick from any to <bad_ips>' | sudo tee -a /etc/pf.anchors/blockips > /dev/null
echo 'block log in quick from <bad_ips> to any' | sudo tee -a /etc/pf.anchors/blockips > /dev/null
