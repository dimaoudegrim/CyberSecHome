#!/bin/bash
systemctl stop wazuh-indexer
systemctl stop wazuh-manager
systemctl stop wazuh-dashboard
systemctl stop filebeat
/var/ossec/bin/wazuh-control stop
