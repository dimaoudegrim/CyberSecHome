# CyberSecHome
Some Family cyber security project for fun as a hobby 😉.
----------------
Network (My own):
<img width="2918" height="1600" alt="Network" src="https://github.com/user-attachments/assets/051ae8c9-e311-49a3-9080-5ea325d068d2" />
----------------
Endpoints:
<img width="2906" height="1602" alt="endpoint" src="https://github.com/user-attachments/assets/f3fe11db-69c6-4410-99c2-18221376f7e5" />
----------------
SIEM:
<img width="2878" height="1588" alt="siem" src="https://github.com/user-attachments/assets/317f275b-2921-4503-931a-9819f0e97014" />
----------------
Website:
<img width="2656" height="1460" alt="website" src="https://github.com/user-attachments/assets/c339cfa1-0734-4fb9-b405-f1550232e99a" />
----------------
Splunk Home LAB - mainly testing for clients:
<img width="2662" height="1488" alt="splunk" src="https://github.com/user-attachments/assets/f7046967-b869-4ee7-870a-4ae29c48020b" />
----------------
Local AI Pipeline:
<img width="1300" height="719" alt="Local AI Pipeline " src="https://github.com/user-attachments/assets/49eecb17-394e-4629-9dcf-7bac9fd8b5c9" />
------------------
Others:
<img width="2634" height="1450" alt="other" src="https://github.com/user-attachments/assets/541ae538-c8a8-4a48-95a1-85c6e7b47033" />
------------------


Tools used:
- Checkpoint Firewall SMB
- 2x Sophos Firewalls (1 over Proxmox as VM on mini pc and additional 1 original appliance)
- Checkpoint harmony Endpoint EDR
- Checkpoint harmony browse
- Checkpoint Harmony Mobile MTD
- Checkpoint harmony email protection 
- WAZUH SIEM server over AWS EC2
- DNS Blackhole (Adguard home) over EC2 AWS, which connected to DNS Firewall.
- DNS fIrewall (nextdns)
- patch management :
Manageengine - Patch manager plus ,
0patch - virtual patching 0-days and more before the vendor have a patch.
Opswat it-ot access metadefnder endpoint
- MDM - Manageengine
- FIM (File integrity monitoring)
- CDR - (build in checkpoint harmony endpoint)
- virustotal integration by using the FIM hash file generating (not uploading file)
- YARA integration scanning that trigger by file changes,
- Bunny CDN, WAF and DNS for personal website.
- 2 aws ec2 servers, cloudtrail, guardduty.
- Dark web monitoring for breached credentials, data broker removal, osint intel – pentester[.]com (temporary disabled)
Zoho assist.
 and more….

Other tools that aren't not managed:
- Splunk Enterprise (with ES) Cluster home Lab (14 VM servers).
- Password managers.
- Multiple commercial VPN.
- cloud backup.
- scout suite - AWS misconfiguration checks

The files here are :

- Cyber security topology and architecture.

- My SIEM Rules Names (582 custom rules. 436 Alerts directly to my phone).

- Security and CIS Benchamrk registry tweaks. (168 registry settings).

- Privacy, Performance, remove telemetry and other Registry tweaks. (176 registry settings).

- Firefox custom settings (155 custom settings, mainly in about:config).

- Wazuh Decoders - Mostly My own. 11 files.

- Scripts:
  * Debloat windows (27 components or apps).
  * Download IOC list for CDB on WAZUH.
  * Set dns settings gloabally on all interfaces.
  * other.
- Web browsers:
  * Firefox custom settings (150 custom settings, mainly in about:config).
  * Set dns over https settings per each browser (Firefox, Brave, Chrome, Edge)
  * Allowlist of addons: Firefox(ps1), Edge(reg), Chrome(reg), Brave(reg)
  * 
- Local AI Pipeline with private and secure connection between Desktop to remote phones and laptop. Integration with firefox build-in chatboot on desktop.
