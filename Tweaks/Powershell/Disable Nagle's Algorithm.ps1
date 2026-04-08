$ipv4Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
$ipv6Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\Interfaces" 
$successCount = 0
$failCount    = 0

Write-Host "`nDisabling Nagle's Algorithm on active network interfaces...`n" -ForegroundColor Cyan

$activeAdapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }

foreach ($adapter in $activeAdapters) {
    $guid    = $adapter.InterfaceGuid
    $adapterFailed = $false

    foreach ($basePath in @($ipv4Path, $ipv6Path)) {
        $regPath = "$basePath\$guid"
        
        if (-not (Test-Path -Path $regPath)) {
            try {
                New-Item -Path $regPath -Force -ErrorAction Stop | Out-Null
            } catch {
                $adapterFailed = $true
                continue 
            }
        }

        try { Set-ItemProperty -Path $regPath -Name "TcpAckFrequency" -Value 1 -Type DWord -ErrorAction Stop } catch { $adapterFailed = $true }
        try { Set-ItemProperty -Path $regPath -Name "TCPNoDelay"      -Value 1 -Type DWord -ErrorAction Stop } catch { $adapterFailed = $true }
        try { Set-ItemProperty -Path $regPath -Name "TcpDelAckTicks"  -Value 0 -Type DWord -ErrorAction Stop } catch { $adapterFailed = $true }
    }

    if ($adapterFailed) {
        Write-Host "  [WARN] Partial or complete failure on $($adapter.Name)" -ForegroundColor Red
        $failCount++
    } else {
        Write-Host "  [OK]   $($adapter.Name) ($guid)" -ForegroundColor Green
        $successCount++
    }
}

Write-Host "`n----------------------------------------"
Write-Host "  Success : $successCount interface(s)" -ForegroundColor Green
if ($failCount -gt 0) {
    Write-Host "  Failed  : $failCount interface(s)" -ForegroundColor Red
}
