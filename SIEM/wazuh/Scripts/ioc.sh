#!/bin/bash

curl -o /var/ossec/etc/lists/ClearSky-indicators https://aaaaa/ClearSky-indicators 

curl -o /var/ossec/etc/lists/Hashes-and-domains https://aaaaa/Hashes-and-domains 

curl -o /var/ossec/etc/lists/hostfile https://urlhaus.abuse.ch/downloads/hostfile 

curl -o /var/ossec/etc/lists/ipblocklist.txt https://feodotracker.abuse.ch/downloads/ipblocklist.txt 

chmod 660 /var/ossec/etc/lists/ClearSky-indicators

chmod 660 /var/ossec/etc/lists/Hashes-and-domains

chown wazuh:wazuh /var/ossec/etc/lists/ClearSky-indicators

chown wazuh:wazuh /var/ossec/etc/lists/Hashes-and-domains


sed -i '1,8d' /var/ossec/etc/lists/hostfile

sed -i '$d' /var/ossec/etc/lists/hostfile

sed -i 's/127\.0\.0\.1//g' /var/ossec/etc/lists/hostfile

sed -i 's/ //g' /var/ossec/etc/lists/hostfile

tr -d '\r' < /var/ossec/etc/lists/hostfile > /var/ossec/etc/lists/hostfile2



date=$(date +%F)



while read -r line; do



echo "$line:urlhaus-abusech $date"

done < /var/ossec/etc/lists/hostfile2 > /var/ossec/etc/lists/hostfile3 

mv /var/ossec/etc/lists/hostfile3 /var/ossec/etc/lists/urlhaus 

sed -i '$d' /var/ossec/etc/lists/urlhaus

chown wazuh:wazuh /var/ossec/etc/lists/urlhaus

chmod 660 /var/ossec/etc/lists/urlhaus

rm /var/ossec/etc/lists/hostfile2

rm /var/ossec/etc/lists/hostfile

mv /var/ossec/etc/lists/ipblocklist.txt /var/ossec/etc/lists/ipblocklist 

sed -i '1,9d' /var/ossec/etc/lists/ipblocklist

sed -i '$d' /var/ossec/etc/lists/ipblocklist

sed -i 's/ //g' /var/ossec/etc/lists/ipblocklist

tr -d '\r' < /var/ossec/etc/lists/ipblocklist > /var/ossec/etc/lists/ipblocklist2



date=$(date +%F)



while read -r line; do



echo "$line:urlhaus-abusech $date"

done < /var/ossec/etc/lists/ipblocklist2 > /var/ossec/etc/lists/ipblocklist3 

mv /var/ossec/etc/lists/ipblocklist3 /var/ossec/etc/lists/cc_abusech 

sed -i '$d' /var/ossec/etc/lists/cc_abusech

chown wazuh:wazuh /var/ossec/etc/lists/cc_abusech

chmod 660 /var/ossec/etc/lists/cc_abusech

rm /var/ossec/etc/lists/ipblocklist2

rm /var/ossec/etc/lists/ipblocklist

systemctl restart wazuh-manager
