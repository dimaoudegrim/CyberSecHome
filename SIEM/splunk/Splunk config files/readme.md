# splunk
Splunk config files for cluster home lab. The config files not including apps as ES or other splunk base apps that exist in the lab.
This repo made for demonstration only and not sure that will fit your production environment. Please check carefully what is fitting you here. Most of traffic here is NOT ENCRYPTED BY ENTERPRISE STANDARDS!, neither the Forwarders, sc4s, splunkd, except the web pages. As this is a home lab.
---
From my home lab with Splunk Enterprise clusters with ES, as a testing environment for my enterprise clients. Build on Vmware workstation pro as VM'S (15 VM'S) on three old computers that most of the time turned off for electricity saving. But can be turned on remotely.
This lab is Used for testing my clients specific configuration and requirements as needed.
---
•	14 VM's in clusters mode.
-	Cluster manager.
-	Deployer
-	3 Indexers in clusters mode and multi-site and 3 level indexes replications.
-	3 Search head with Enterprise security v8.3 in a cluster mode and multi-site
-	License manager with monitoring console
-	Deployment server
-	SC4S
-	Heavy forwarder
  ---
  Other
  ---
-	Linux VM for sending logs by UF, and also syslog by Rsyslog to SC4S.
-	Windows VM for sending logs by UF, and also Syslog to SC4S by solarwinds event forwarder -> Kiwi Syslog server -> SC4S -> Splunk (Mimic air-gapped environment).
-	misp with integration of splunk threat intelligence
---
•	Custom architecture for the implementation.
-	Using Raspberry pi on the same network for using wake on lan to turn on the computers (hosts).
-	Each VM gets a static IP by DHCP from check point firewall.
-	Using Twingate ztna connector on one of the VM for login to rest of the VM.
-	Custom DNS records on the DNS firewall for using local hostnames for the VM's.
-	Self-signed tls certificates.
-	Each Linux VM can't use ROOT login, and login done by CERT key.
-	The Checkpoint firewall has a always turned on switch button, in case of power drop.
