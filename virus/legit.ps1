# Force UTF-8 output — fixes box-drawing character corruption on all Windows versions
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$Host.UI.RawUI.WindowTitle = "Windows PowerShell"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
Clear-Host

# ─────────────────────────────────────────────
# IMAGE URLs — replace with your GitHub raw links
# ─────────────────────────────────────────────
$skullImageUrl     = "https://raw.githubusercontent.com/gsubigya/web.github.io/refs/heads/main/virus/skull.png"
$awarenessImageUrl = "https://raw.githubusercontent.com/gsubigya/web.github.io/6bfcf395d5083872214447740410cdb962cf820f/virus/awareness.png"

$desktop = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$skullDest     = Join-Path $desktop "system_alert.png"
$awarenessDest = Join-Path $desktop "security_tips.png"

# ─────────────────────────────────────────────
# HELPER FUNCTIONS
# ─────────────────────────────────────────────
function Fast-Type {
    param([string]$Text, [string]$Color = "White", [int]$Delay = 6)
    foreach ($char in $Text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds $Delay
    }
    Write-Host ""
}

function Fake-ProgressBar {
    param([string]$Label, [string]$BarColor = "Red", [int]$Speed = 14)
    Write-Host "  $Label [" -NoNewline -ForegroundColor DarkGray
    for ($i = 1; $i -le 30; $i++) {
        Write-Host "#" -NoNewline -ForegroundColor $BarColor
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "COMPLETE" -ForegroundColor Green
}

# ─────────────────────────────────────────────
# DOWNLOAD IMAGE (background, non-blocking)
# ─────────────────────────────────────────────
function Download-Image {
    param([string]$Url, [string]$Dest)
    $job = Start-Job -ScriptBlock {
        param($u, $d)
        try { Invoke-WebRequest -Uri $u -OutFile $d -UseBasicParsing -ErrorAction Stop } catch {}
    } -ArgumentList $Url, $Dest
    return $job
}

# ─────────────────────────────────────────────
# FULLSCREEN IMAGE — SKULL VERSION
# ESC, clicks, keypresses ALL blocked.
# Only the timer closes it after $seconds.
# ─────────────────────────────────────────────
function Show-SkullFullscreen {
    param([string]$ImagePath, [int]$Seconds = 20)

    $script = @"
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

`$form = New-Object System.Windows.Forms.Form
`$form.FormBorderStyle  = 'None'
`$form.WindowState      = 'Maximized'
`$form.TopMost          = `$true
`$form.BackColor        = [System.Drawing.Color]::Black
`$form.Cursor           = [System.Windows.Forms.Cursors]::None
`$form.ShowInTaskbar    = `$false
`$form.KeyPreview       = `$true

`$pb = New-Object System.Windows.Forms.PictureBox
`$pb.Dock     = 'Fill'
`$pb.SizeMode = 'StretchImage'
`$pb.Image    = [System.Drawing.Image]::FromFile('$ImagePath')
`$form.Controls.Add(`$pb)

# Block ALL keyboard input including ESC, Alt+F4, everything
`$form.Add_KeyDown({
    `$_.SuppressKeyPress = `$true
    `$_.Handled = `$true
})
`$form.Add_KeyUp({
    `$_.SuppressKeyPress = `$true
    `$_.Handled = `$true
})
# Block mouse clicks — do nothing
`$pb.Add_Click({})
`$form.Add_Click({})

# Only the timer can close it
`$timer = New-Object System.Windows.Forms.Timer
`$timer.Interval = $($Seconds * 1000)
`$timer.Add_Tick({ `$timer.Stop(); `$form.Close() })
`$timer.Start()

[System.Windows.Forms.Application]::Run(`$form)
"@

    $tmp = Join-Path $env:TEMP "skull_$([System.IO.Path]::GetRandomFileName()).ps1"
    $script | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell.exe `
        -ArgumentList "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$tmp`"" `
        -WindowStyle Hidden
}

# ─────────────────────────────────────────────
# FULLSCREEN IMAGE — AWARENESS CARD VERSION
# Closes on any key or click (user reads at own pace)
# ─────────────────────────────────────────────
function Show-AwarenessFullscreen {
    param([string]$ImagePath)

    $script = @"
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

`$form = New-Object System.Windows.Forms.Form
`$form.FormBorderStyle = 'None'
`$form.WindowState     = 'Maximized'
`$form.TopMost         = `$true
`$form.BackColor       = [System.Drawing.Color]::Black
`$form.Cursor          = [System.Windows.Forms.Cursors]::Default
`$form.ShowInTaskbar   = `$false
`$form.KeyPreview      = `$true

`$pb = New-Object System.Windows.Forms.PictureBox
`$pb.Dock     = 'Fill'
`$pb.SizeMode = 'StretchImage'
`$pb.Image    = [System.Drawing.Image]::FromFile('$ImagePath')
`$form.Controls.Add(`$pb)

`$form.Add_KeyDown({ `$form.Close() })
`$pb.Add_Click({ `$form.Close() })

[System.Windows.Forms.Application]::Run(`$form)
"@

    $tmp = Join-Path $env:TEMP "aware_$([System.IO.Path]::GetRandomFileName()).ps1"
    $script | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell.exe `
        -ArgumentList "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$tmp`"" `
        -WindowStyle Hidden
}

# =============================================
# PHASE 1 — SILENT ENTRY
# =============================================
Clear-Host
Write-Host ""
Start-Sleep -Milliseconds 800
Fast-Type "  Checking internet connection..." "DarkGray" 8
Start-Sleep -Milliseconds 400
Fast-Type "  Connection OK." "DarkGray" 6
Write-Host ""
Start-Sleep -Milliseconds 500

Fast-Type "  [DOWNLOADER] Fetching resource from remote host..." "DarkGray" 6
Start-Sleep -Milliseconds 300

# Download skull now (fast path — needed in seconds)
$skullJob = Download-Image -Url $skullImageUrl -Dest $skullDest

Fast-Type "  [DOWNLOADER] File received. Writing to Desktop..." "DarkGray" 6
Start-Sleep -Milliseconds 200
Fast-Type "  [DOWNLOADER] Attribute set: Hidden" "DarkGray" 6
Start-Sleep -Milliseconds 300
Write-Host ""
Fast-Type "  Opening image..." "DarkGray" 8
Start-Sleep -Milliseconds 400

# Wait for skull download to finish (max 8s)
Wait-Job $skullJob -Timeout 8 | Out-Null
Remove-Job $skullJob -Force

# =============================================
# PHASE 2 — RED BANNER + SKULL FIRES
# =============================================
$Host.UI.RawUI.ForegroundColor = "Red"
Clear-Host
Write-Host ""
Write-Host "  #####################################################" -ForegroundColor Red
Write-Host "  ##                                                 ##" -ForegroundColor Red
Write-Host "  ##     WHILE YOU WERE LOOKING AT THAT IMAGE...    ##" -ForegroundColor Yellow
Write-Host "  ##                                                 ##" -ForegroundColor Red
Write-Host "  #####################################################" -ForegroundColor Red
Write-Host ""

# SKULL fires here — 15 seconds, all input blocked
Show-SkullFullscreen -ImagePath $skullDest -Seconds 15

# Download awareness image IN BACKGROUND while skull is showing
# By the time skull closes (15s), awareness image will be ready
$awarenessJob = Download-Image -Url $awarenessImageUrl -Dest $awarenessDest

Start-Sleep -Milliseconds 400
Fast-Type "  This is what ran in the background. Silently." "DarkGray" 7
Write-Host ""
Start-Sleep -Milliseconds 300

# ─── 6 CMD windows — attack chain ───────────────────────────────────
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 1] PAYLOAD DELIVERY & color 04 & echo. & echo  [*] nc.exe downloaded from attacker IP 192.168.0.117 & echo  [*] Saved to Desktop as hidden file & echo  [*] File attribute: HIDDEN - invisible in Explorer & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 120
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 2] DECOY LAUNCHED & color 04 & echo. & echo  [*] Image file downloaded from attacker CDN & echo  [*] Opened visibly to distract the victim & echo  [*] Payload already running behind it & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 120
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 3] REVERSE SHELL OPEN & color 04 & echo. & echo  [*] nc.exe executed with parameters & echo  [*] -d : Running hidden, no visible window & echo  [*] -e cmd.exe : Your terminal piped to attacker & echo  [*] Port 4444 OPEN - attacker has your shell & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 120
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 4] ATTACKER HAS CMD ACCESS & color 04 & echo. & echo  [*] Attacker running: whoami & echo  [*] Attacker running: ipconfig & echo  [*] Attacker running: dir C:\Users & echo  [*] Full filesystem visible to remote operator & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 120
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 5] LATERAL MOVEMENT & color 04 & echo. & echo  [*] Scanning local network from your machine & echo  [*] Other devices on 192.168.x.x enumerated & echo  [*] Your device now used as pivot point & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 120
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 6] SESSION ALIVE & color 04 & echo. & echo  [*] Shell session persists until reboot & echo  [*] Attacker is live and interactive & echo  [*] All of this started from ONE command & timeout /t 5 /nobreak > nul' -WindowStyle Normal

$steps = @(
    "[STEP 1] nc.exe downloaded silently -> Desktop (hidden)",
    "[STEP 2] Decoy image opened -> your eyes were busy",
    "[STEP 3] Reverse shell spawned -> your cmd.exe sent to attacker",
    "[STEP 4] Attacker browsing your files -> live, interactive",
    "[STEP 5] Your machine scanning your home network",
    "[STEP 6] Session stays open -> attacker is still in"
)
foreach ($s in $steps) {
    Write-Host "    >> " -NoNewline -ForegroundColor DarkRed
    Write-Host $s -ForegroundColor Red
    Start-Sleep -Milliseconds 100
}

Write-Host ""
Start-Sleep -Milliseconds 400

# =============================================
# PHASE 3 — ATTACK CHAIN TIMELINE
# =============================================
Write-Host "  ----------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  FULL ATTACK CHAIN - what just happened in order:" "Yellow" 7
Write-Host ""

$chain = @(
    "You ran:  irm https://subigya.com/virus/index.ps1 | iex",
    "Script downloaded nc.exe from attacker machine",
    "nc.exe hidden with SetFileAttribute = Hidden",
    "Decoy image downloaded and opened (you saw this)",
    "nc.exe executed silently in background",
    "Your cmd.exe piped to attacker on port 4444",
    "Attacker now has full interactive shell on your machine",
    "From there: files, passwords, network - all reachable"
)
for ($i = 0; $i -lt $chain.Length; $i++) {
    Write-Host ("    [{0}] " -f ($i + 1)) -NoNewline -ForegroundColor DarkGray
    $col = if ($i -eq 0) { "Yellow" } elseif ($i -ge 5) { "Red" } else { "White" }
    Write-Host $chain[$i] -ForegroundColor $col
    Start-Sleep -Milliseconds 120
}

Write-Host ""
Start-Sleep -Milliseconds 300

# =============================================
# PHASE 4 — PROGRESS BARS
# =============================================
Write-Host "  ----------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  In a real attack, the next 60 seconds look like this:" "DarkYellow" 7
Write-Host ""
Fake-ProgressBar "Enumerating files on your system    " "Red" 14
Fake-ProgressBar "Reading browser saved passwords     " "DarkRed" 14
Fake-ProgressBar "Scanning devices on your WiFi       " "Red" 14
Fake-ProgressBar "Uploading collected data to attacker" "DarkRed" 14
Fake-ProgressBar "Installing startup persistence key  " "Red" 14
Write-Host ""
Write-Host "  ----------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Milliseconds 300

# =============================================
# PHASE 5 — REVEAL
# =============================================
Clear-Host
$Host.UI.RawUI.ForegroundColor = "White"
Start-Sleep -Milliseconds 300

Write-Host ""
Write-Host "  +===================================================+" -ForegroundColor Cyan
Write-Host "  |                                                   |" -ForegroundColor Cyan
Write-Host "  |       YOUR COMPUTER IS COMPLETELY FINE.          |" -ForegroundColor Green
Write-Host "  |       THIS WAS A SECURITY AWARENESS DEMO.        |" -ForegroundColor Yellow
Write-Host "  |                                                   |" -ForegroundColor Cyan
Write-Host "  +===================================================+" -ForegroundColor Cyan
Write-Host ""
Start-Sleep -Milliseconds 400

Fast-Type "  Nothing above was real. No files touched. No connection made." "White" 8
Fast-Type "  Those CMD windows only printed text. nc.exe never ran." "White" 8
Write-Host ""
Start-Sleep -Milliseconds 300

Write-Host "  But here is the uncomfortable part:" -ForegroundColor Yellow
Write-Host ""
Fast-Type "  The command that started this entire chain was ONE line:" "White" 7
Write-Host ""
Write-Host "     irm https://subigya.com/virus/index.ps1 | iex" -ForegroundColor Yellow
Write-Host ""
Fast-Type "  irm  = Invoke-WebRequest  -> downloads ANY script from that URL" "DarkGray" 7
Fast-Type "  iex  = Invoke-Expression  -> executes it INSTANTLY, no confirmation" "DarkGray" 7
Fast-Type "  You had zero seconds to review what you were running." "Red" 7
Write-Host ""
Start-Sleep -Milliseconds 400

# =============================================
# PHASE 6 — ATTACK VECTORS + TIPS
# =============================================
Write-Host "  ----------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  REAL ATTACK VECTORS THAT USE THIS EXACT PATTERN:" -ForegroundColor Cyan
Write-Host ""

$vectors = @(
    @{ title = "Fake software installs";  desc = "Discord Nitro, game cheats, cracked tools asking you to run a PS command" },
    @{ title = "Tech support scams";      desc = "Fake Microsoft support telling you to open PowerShell and paste a fix" },
    @{ title = "GitHub/Reddit scripts";   desc = "Run this one-liner to fix your issue - from an unknown commenter" },
    @{ title = "WhatsApp/Discord links";  desc = "Friend's hacked account sends a script link with a photo as decoy" },
    @{ title = "Fake Windows errors";     desc = "Browser fullscreen popup with error and a PowerShell command to fix it" }
)
foreach ($v in $vectors) {
    Write-Host ("   [!] ") -NoNewline -ForegroundColor Red
    Write-Host $v.title -ForegroundColor Yellow
    Write-Host ("       -> " + $v.desc) -ForegroundColor DarkGray
    Write-Host ""
    Start-Sleep -Milliseconds 120
}

Write-Host "  ----------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  WHAT ACTUALLY PROTECTS YOU:" -ForegroundColor Cyan
Write-Host ""

$tips = @(
    "Before running any PowerShell command - read it word by word",
    "irm <url> | iex means blind execute. Always treat it as a red flag",
    "Legitimate software NEVER asks you to paste a terminal command",
    "A photo opening after a script runs is NOT proof nothing happened",
    "If someone online gives you a one-liner to run, treat it as an attack",
    "Check running processes after anything suspicious (Task Manager)"
)
foreach ($tip in $tips) {
    Write-Host "   [+] " -NoNewline -ForegroundColor Green
    Fast-Type $tip "White" 7
    Start-Sleep -Milliseconds 80
}

Write-Host ""
Write-Host "  ----------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  Share this. The person who needs it most won't think they do." "Cyan" 8
Write-Host ""
Start-Sleep -Milliseconds 1000

# =============================================
# FINAL — AWARENESS CARD
# Wait for background download to finish then show
# =============================================
Wait-Job $awarenessJob -Timeout 10 | Out-Null
Remove-Job $awarenessJob -Force

Show-AwarenessFullscreen -ImagePath $awarenessDest

Write-Host "  Press any key to close this terminal..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
