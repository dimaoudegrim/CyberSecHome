$path = 'HKLM:\SOFTWARE\Policies\Mozilla\Firefox'

if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

$settings = [ordered]@{
    "*" = @{
        installation_mode       = "blocked"
        blocked_install_message = "Blocked by Nir"
        allowed_types           = @("theme","dictionary","locale","langpack")
        install_sources         = @(
            "https://addons.mozilla.org/*",
            "about:addons",
            "https://sc1.checkpoint.com/*"
        )
    }
    "sba4b_firefox_quantum@checkpoint.com" = @{
        installation_mode = "force_installed"
        install_url       = "https://sc1.checkpoint.com/sba/ga/check_point_sandblast_agent_for_browsers.xpi"
    }
    "trafficlight@bitdefender.com" = @{
        installation_mode = "allowed"
    }
    "uBlock0@raymondhill.net" = @{
        installation_mode = "allowed"
    }
    "@contain-facebook" = @{
        installation_mode = "allowed"
    }
    "keepassxc-browser@keepassxc.org" = @{
        installation_mode = "allowed"
    }
    "rf-firefox@siber.com" = @{
        installation_mode = "allowed"
    }
    "{20fc2e06-e3e4-4b2b-812b-ab431220cada}" = @{
        installation_mode = "allowed"
    }
}

$json = $settings | ConvertTo-Json -Depth 10 -Compress

New-ItemProperty -Path $path `
  -Name 'ExtensionSettings' `
  -PropertyType MultiString `
  -Value @($json) `
  -Force | Out-Null

Write-Host "Policy applied successfully. Check about:policies and about:policies#errors."