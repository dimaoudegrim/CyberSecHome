$DoH_URL = "https://dns.quad9.net/dns-query"


$chromePath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
New-Item -Path $chromePath -Force | Out-Null
Set-ItemProperty -Path $chromePath -Name "DnsOverHttpsMode"      -Value "secure"  -Type String
Set-ItemProperty -Path $chromePath -Name "DnsOverHttpsTemplates" -Value $DoH_URL  -Type String


$edgePath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
New-Item -Path $edgePath -Force | Out-Null
# BuiltInDnsClientEnabled controls the built-in DNS client for general DNS
# resolution, not required for DoH enforcement but recommended for consistency
Set-ItemProperty -Path $edgePath -Name "BuiltInDnsClientEnabled" -Value 1        -Type DWord
Set-ItemProperty -Path $edgePath -Name "DnsOverHttpsMode"        -Value "secure"  -Type String
Set-ItemProperty -Path $edgePath -Name "DnsOverHttpsTemplates"   -Value $DoH_URL  -Type String

$bravePath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"
New-Item -Path $bravePath -Force | Out-Null
Set-ItemProperty -Path $bravePath -Name "DnsOverHttpsMode"      -Value "secure"  -Type String
Set-ItemProperty -Path $bravePath -Name "DnsOverHttpsTemplates" -Value $DoH_URL  -Type String

$firefoxPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox\DNSOverHTTPS"
New-Item -Path $firefoxPath -Force | Out-Null
Set-ItemProperty -Path $firefoxPath -Name "Enabled"     -Value 1        -Type DWord
Set-ItemProperty -Path $firefoxPath -Name "Locked"      -Value 1        -Type DWord
# Fallback 0 = disallow fallback to system DNS if DoH fails (strict enforcement)
Set-ItemProperty -Path $firefoxPath -Name "Fallback"    -Value 0        -Type DWord
Set-ItemProperty -Path $firefoxPath -Name "ProviderURL" -Value $DoH_URL -Type String

Write-Host "DoH policies applied successfully for Chrome, Edge, Brave, and Firefox." -ForegroundColor Green
