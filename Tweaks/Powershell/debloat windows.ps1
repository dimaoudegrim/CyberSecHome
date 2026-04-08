#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Windows 11 Debloat & Feature Removal Script
.DESCRIPTION
    Removes bloatware AppX packages, disables optional features/capabilities,
    and applies registry tweaks to kill Copilot, Cortana, and Steps Recorder.
	This is the list:
Clipchamp
Bing News
Bing Weather
Xbox Gaming App
Get Help
Get Started / Tips
Solitaire Collection
People
Power Automate Desktop
Alarms & Clock
Mail & Calendar
Feedback Hub
Maps
Xbox overlays (3x)
Phone Link
Groove Music
Movies & TV
Family Safety
Quick Assist
Microsoft Teams (both versions)
Cortana
Copilot (app + sidebar)
Outlook for Windows
Internet Explorer
Language Handwriting/OCR/Speech/TTS
Tablet PC Math
Steps Recorder
.NOTES
    Run as Administrator. A restart is required after execution.
#>

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference    = 'SilentlyContinue'

# ─────────────────────────────────────────────────────────────────
# HELPER: Remove AppX for current user, all users, and provisioned
# ─────────────────────────────────────────────────────────────────
function Remove-AppXFully {
    param ([string]$Name)
    Write-Host "  [-] Removing AppX: $Name" -ForegroundColor Yellow
    Get-AppxPackage          -Name $Name -AllUsers | Remove-AppxPackage -AllUsers
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "*$Name*" |
        Remove-AppxProvisionedPackage -Online
}

Write-Host "`n═══════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "   Windows Debloat Script — Running...     " -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════`n" -ForegroundColor Cyan


# ═══════════════════════════════════════════
# SECTION 1 — AppX / Store App Removal
# ═══════════════════════════════════════════
Write-Host "[1/5] Removing AppX packages..." -ForegroundColor Cyan

$appxList = @(
    # ── Clipchamp ──────────────────────────
    "Clipchamp.Clipchamp",

    # ── Bing apps ──────────────────────────
    "Microsoft.BingNews",
    "Microsoft.BingWeather",

    # ── Xbox ───────────────────────────────
    "Microsoft.GamingApp",
    "Microsoft.XboxApp",
    "Microsoft.XboxGameOverlay",     # Xbox overlay 1
    "Microsoft.XboxGamingOverlay",   # Xbox overlay 2
    "Microsoft.Xbox.TCUI",           # Xbox overlay 3

    # ── Help & Tips ────────────────────────
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",          # Tips

    # ── Games ──────────────────────────────
    "Microsoft.MicrosoftSolitaireCollection",

    # ── People ─────────────────────────────
    "Microsoft.People",

    # ── Power Automate ─────────────────────
    "Microsoft.PowerAutomateDesktop",

    # ── Alarms & Clock ─────────────────────
    "Microsoft.WindowsAlarms",

    # ── Mail & Calendar ────────────────────
    "microsoft.windowscommunicationsapps",

    # ── Feedback Hub ───────────────────────
    "Microsoft.WindowsFeedbackHub",

    # ── Maps ───────────────────────────────
    "Microsoft.WindowsMaps",

    # ── Phone Link ─────────────────────────
    "Microsoft.YourPhone",
    "MicrosoftCorporationII.PhoneLink",

    # ── Groove Music ───────────────────────
    "Microsoft.ZuneMusic",

    # ── Movies & TV ────────────────────────
    "Microsoft.ZuneVideo",

    # ── Family Safety ──────────────────────
    "MicrosoftCorporationII.MicrosoftFamily",
    "Microsoft.FamilySafety",

    # ── Quick Assist ───────────────────────
    "MicrosoftCorporationII.QuickAssist",

    # ── Microsoft Teams (both versions) ────
    "MicrosoftTeams",                # Classic Teams
    "MSTeams",                       # New Teams

    # ── Cortana ────────────────────────────
    "Microsoft.549981C3F5F10",

    # ── Copilot ────────────────────────────
    "Microsoft.Copilot",
    "Microsoft.Windows.Copilot",

    # ── Outlook for Windows ────────────────
    "Microsoft.OutlookForWindows",

    # ── Groove legacy alias ────────────────
    "Microsoft.Office.OneNote"       # optional: UWP OneNote often bundled
)

foreach ($app in $appxList) {
    Remove-AppXFully -Name $app
}


# ═══════════════════════════════════════════
# SECTION 2 — Registry Tweaks
# ═══════════════════════════════════════════
Write-Host "`n[2/5] Applying registry tweaks..." -ForegroundColor Cyan

function Set-Reg {
    param ([string]$Path, [string]$Name, $Value, [string]$Type = "DWord")
    If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}

# ── Copilot: Group Policy disable (HKLM) ──
Write-Host "  [-] Disabling Copilot via Group Policy registry key..." -ForegroundColor Yellow
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"          "TurnOffWindowsCopilot"  1
Set-Reg "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot"          "TurnOffWindowsCopilot"  1

# ── Copilot: Hide taskbar button ──
Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCopilotButton"      0
Set-Reg "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCopilotButton"      0

# ── Copilot: Edge sidebar ──
Write-Host "  [-] Disabling Copilot in Edge sidebar..." -ForegroundColor Yellow
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Edge"                            "HubsSidebarEnabled"     0
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Edge"                            "CopilotCDPPageContext"   0

# ── Cortana: Allow via Group Policy ──
Write-Host "  [-] Disabling Cortana via Group Policy..." -ForegroundColor Yellow
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"         "AllowCortana"            0
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"         "DisableWebSearch"        1
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"         "ConnectedSearchUseWeb"   0

# ── Steps Recorder: Disable via AppCompat policy ──
Write-Host "  [-] Disabling Steps Recorder..." -ForegroundColor Yellow
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"              "DisableUAR"              1

# ── Teams: Remove startup entries ──
Write-Host "  [-] Removing Teams from startup..." -ForegroundColor Yellow
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "MicrosoftTeams"         -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "TeamsMachineInstaller"  -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "TeamsMachineInstaller" -ErrorAction SilentlyContinue


# ═══════════════════════════════════════════
# SECTION 3 — Windows Optional Features (DISM)
# ═══════════════════════════════════════════
Write-Host "`n[3/5] Disabling Windows Optional Features..." -ForegroundColor Cyan

$optFeatures = @(
    "Internet-Explorer-Optional-amd64",   # Internet Explorer
    "MathRecognizer",                      # Tablet PC Math Input Panel
    "WorkFolders-Client"                   # optional cleanup
)

foreach ($feat in $optFeatures) {
    $state = (Get-WindowsOptionalFeature -Online -FeatureName $feat -ErrorAction SilentlyContinue).State
    if ($state -eq "Enabled") {
        Write-Host "  [-] Disabling: $feat" -ForegroundColor Yellow
        Disable-WindowsOptionalFeature -Online -FeatureName $feat -NoRestart
    } else {
        Write-Host "  [=] Already disabled or not found: $feat" -ForegroundColor DarkGray
    }
}


# ═══════════════════════════════════════════
# SECTION 4 — Windows Capabilities
# (Steps Recorder, Language: Handwriting / OCR / Speech / TTS)
# ═══════════════════════════════════════════
Write-Host "`n[4/5] Removing Windows Capabilities..." -ForegroundColor Cyan

# Remove Steps Recorder capability
$stepsCap = Get-WindowsCapability -Online | Where-Object { $_.Name -like "App.StepsRecorder*" -and $_.State -eq "Installed" }
if ($stepsCap) {
    Write-Host "  [-] Removing Steps Recorder capability..." -ForegroundColor Yellow
    $stepsCap | Remove-WindowsCapability -Online
}

# Remove ALL language-related capabilities for every installed language
$langCapPatterns = @(
    "Language.Handwriting*",
    "Language.OCR*",
    "Language.Speech*",
    "Language.TextToSpeech*",
    "Speech.Recognition*"
)

$allCaps = Get-WindowsCapability -Online

foreach ($pattern in $langCapPatterns) {
    $allCaps | Where-Object { $_.Name -like $pattern -and $_.State -eq "Installed" } | ForEach-Object {
        Write-Host "  [-] Removing capability: $($_.Name)" -ForegroundColor Yellow
        Remove-WindowsCapability -Online -Name $_.Name
    }
}


# ═══════════════════════════════════════════
# SECTION 5 — Block Reinstallation via Policy
# ═══════════════════════════════════════════
Write-Host "`n[5/5] Preventing reinstallation of removed apps..." -ForegroundColor Cyan

# Prevent Store from auto-restoring preinstalled apps
Set-Reg "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"   "DisableWindowsConsumerFeatures"  1
Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SilentInstalledAppsEnabled" 0
Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0
Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "OemPreInstalledAppsEnabled" 0
Set-Reg "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEnabled" 0

Write-Host "`n═══════════════════════════════════════════" -ForegroundColor Green
Write-Host "   Done! Please RESTART your PC now.       " -ForegroundColor Green
Write-Host "═══════════════════════════════════════════`n" -ForegroundColor Green