#!/bin/bash
systemctl stop wazuh-indexer
systemctl stop wazuh-manager
systemctl stop wazuh-dashboard
systemctl stop filebeat
/var/ossec/bin/wazuh-control stop
systemctl start wazuh-indexer
systemctl start wazuh-manager
systemctl start wazuh-dashboard
systemctl start filebeat
/var/ossec/bin/wazuh-control restart
