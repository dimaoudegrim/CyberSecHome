# CyberSecHome
Some Family cyber security project for fun as a hobby 😉.
Tools used:
Checkpoint Firewall SMB
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

