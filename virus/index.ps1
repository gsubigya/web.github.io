$Host.UI.RawUI.WindowTitle = "Windows PowerShell"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Gray"
Clear-Host

# ─────────────────────────────────────────────
# IMAGE URLs — replace with your GitHub raw links
# ─────────────────────────────────────────────
$skullImageUrl     = "https://raw.githubusercontent.com/gsubigya/web.github.io/refs/heads/main/virus/skull.png"
$awarenessImageUrl = "https://raw.githubusercontent.com/gsubigya/web.github.io/6bfcf395d5083872214447740410cdb962cf820f/virus/awareness.png"

# ─────────────────────────────────────────────
# HELPER FUNCTIONS
# ─────────────────────────────────────────────
function Fast-Type {
    param([string]$Text, [string]$Color = "White", [int]$Delay = 12)
    foreach ($char in $Text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds $Delay
    }
    Write-Host ""
}

function Fake-ProgressBar {
    param([string]$Label, [string]$BarColor = "Red", [int]$Speed = 25)
    Write-Host "  $Label [" -NoNewline -ForegroundColor DarkGray
    for ($i = 1; $i -le 30; $i++) {
        Write-Host "#" -NoNewline -ForegroundColor $BarColor
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "COMPLETE" -ForegroundColor Green
}

# ─────────────────────────────────────────────
# FULLSCREEN IMAGE DISPLAY
# Downloads PNG to Desktop, then spawns a hidden
# PowerShell process that opens a borderless
# WinForms window stretched over the entire screen.
# No reliance on Photos app — guaranteed fullscreen.
# Pass -AutoClose $true to auto-dismiss after $seconds.
# ─────────────────────────────────────────────
function Show-FullscreenImage {
    param(
        [string]$Url,
        [string]$FileName,
        [bool]$AutoClose = $false,
        [int]$CloseAfterSeconds = 6
    )

    $dest = Join-Path ([System.Environment]::GetFolderPath(
        [System.Environment+SpecialFolder]::Desktop)) $FileName

    try {
        Invoke-WebRequest -Uri $Url -OutFile $dest -UseBasicParsing -ErrorAction Stop
    } catch {
        return  # Silent fail — don't break script if image unreachable
    }

    # Inline script that WinForms renders in a child process
    $displayScript = @"
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

`$screen  = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
`$imgPath = '$dest'
`$autoClose = `$$AutoClose
`$closeMs = $($CloseAfterSeconds * 1000)

`$form = New-Object System.Windows.Forms.Form
`$form.FormBorderStyle = 'None'
`$form.WindowState     = 'Maximized'
`$form.TopMost         = `$true
`$form.BackColor       = [System.Drawing.Color]::Black
`$form.Cursor          = [System.Windows.Forms.Cursors]::None
`$form.ShowInTaskbar   = `$false

`$pb = New-Object System.Windows.Forms.PictureBox
`$pb.Dock      = 'Fill'
`$pb.SizeMode  = 'StretchImage'
`$pb.Image     = [System.Drawing.Image]::FromFile(`$imgPath)
`$form.Controls.Add(`$pb)

# Close on any key or click
`$form.Add_KeyDown({ `$form.Close() })
`$pb.Add_Click({ `$form.Close() })

# Auto-close timer if requested
if (`$autoClose) {
    `$timer          = New-Object System.Windows.Forms.Timer
    `$timer.Interval = `$closeMs
    `$timer.Add_Tick({ `$timer.Stop(); `$form.Close() })
    `$timer.Start()
}

[System.Windows.Forms.Application]::Run(`$form)
"@

    # Write inline script to a temp file and launch hidden
    $tmpScript = Join-Path $env:TEMP "imgview_$([System.IO.Path]::GetRandomFileName()).ps1"
    $displayScript | Out-File -FilePath $tmpScript -Encoding UTF8

    Start-Process powershell.exe -ArgumentList `
        "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$tmpScript`"" `
        -WindowStyle Hidden
}

# ─────────────────────────────────────────────
# PHASE 1: SILENT ENTRY
# ─────────────────────────────────────────────
Clear-Host
Write-Host ""
Start-Sleep -Milliseconds 1200
Fast-Type "  Checking internet connection..." "DarkGray" 10
Start-Sleep -Milliseconds 600
Fast-Type "  Connection OK." "DarkGray" 8
Write-Host ""
Start-Sleep -Milliseconds 800
Fast-Type "  [DOWNLOADER] Fetching resource from remote host..." "DarkGray" 8
Start-Sleep -Milliseconds 400
Fast-Type "  [DOWNLOADER] File received. Writing to Desktop..." "DarkGray" 8
Start-Sleep -Milliseconds 300
Fast-Type "  [DOWNLOADER] Attribute set: Hidden" "DarkGray" 8
Start-Sleep -Milliseconds 400
Write-Host ""
Fast-Type "  Opening image..." "DarkGray" 10
Start-Sleep -Milliseconds 600

# ─────────────────────────────────────────────
# PHASE 2: RED BANNER + SKULL FIRES HERE
# ─────────────────────────────────────────────
$Host.UI.RawUI.ForegroundColor = "Red"
Clear-Host

Write-Host ""
Write-Host "  ┌─────────────────────────────────────────────────────┐" -ForegroundColor Red
Write-Host "  │                                                     │" -ForegroundColor Red
Write-Host "  │     WHILE YOU WERE LOOKING AT THAT IMAGE...        │" -ForegroundColor Yellow
Write-Host "  │                                                     │" -ForegroundColor Red
Write-Host "  └─────────────────────────────────────────────────────┘" -ForegroundColor Red
Write-Host ""

# >>> IMAGE DROP 1: SKULL
# Fires at peak panic moment — red banner just printed.
# Opens as true fullscreen WinForms window, no app chrome.
# Auto-closes after 7 seconds so script can continue.
Show-FullscreenImage -Url $skullImageUrl -FileName "system_alert.png" `
                     -AutoClose $true -CloseAfterSeconds 7

Start-Sleep -Milliseconds 700
Fast-Type "  This is what ran in the background. Silently." "DarkGray" 10
Write-Host ""
Start-Sleep -Milliseconds 500

# ─────────────────────────────────────────────
# PHASE 2 CONTINUED: 6 CMD ATTACK CHAIN WINDOWS
# ─────────────────────────────────────────────
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 1] PAYLOAD DELIVERY & color 04 & echo. & echo  [*] nc.exe downloaded from attacker IP 192.168.0.117 & echo  [*] Saved to Desktop as hidden file & echo  [*] File attribute: HIDDEN - invisible in Explorer & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 200
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 2] DECOY LAUNCHED & color 04 & echo. & echo  [*] Image file downloaded from attacker CDN & echo  [*] Opened visibly to distract the victim & echo  [*] Payload already running behind it & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 200
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 3] REVERSE SHELL OPEN & color 04 & echo. & echo  [*] nc.exe executed with parameters & echo  [*] -d : Running hidden, no visible window & echo  [*] -e cmd.exe : Your terminal piped to attacker & echo  [*] Port 4444 OPEN - attacker has your shell & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 200
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 4] ATTACKER HAS CMD ACCESS & color 04 & echo. & echo  [*] Attacker running: whoami & echo  [*] Attacker running: ipconfig & echo  [*] Attacker running: dir C:\Users & echo  [*] Full filesystem visible to remote operator & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 200
Start-Process "cmd.exe" -ArgumentList '/c title [STEP 5] LATERAL MOVEMENT & color 04 & echo. & echo  [*] Scanning local network from your machine & echo  [*] Other devices on 192.168.x.x enumerated & echo  [*] Your device now used as pivot point & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 200
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
    Start-Sleep -Milliseconds 180
}

Write-Host ""
Start-Sleep -Milliseconds 600

# ─────────────────────────────────────────────
# PHASE 3: ATTACK CHAIN TIMELINE
# ─────────────────────────────────────────────
Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  FULL ATTACK CHAIN — what just happened in order:" "Yellow" 10
Write-Host ""

$chain = @(
    "You ran:  irm https://subigya.com/virus/index.ps1 | iex",
    "Script downloaded nc.exe from attacker machine",
    "nc.exe hidden with SetFileAttribute = Hidden",
    "Decoy image downloaded and opened (you saw this)",
    "nc.exe executed silently in background",
    "Your cmd.exe piped to attacker on port 4444",
    "Attacker now has full interactive shell on your machine",
    "From there: files, passwords, network all reachable"
)
for ($i = 0; $i -lt $chain.Length; $i++) {
    Write-Host ("    [{0}] " -f ($i + 1)) -NoNewline -ForegroundColor DarkGray
    Write-Host $chain[$i] -ForegroundColor $(if ($i -eq 0) { "Yellow" } elseif ($i -ge 5) { "Red" } else { "White" })
    Start-Sleep -Milliseconds 200
}

Write-Host ""
Start-Sleep -Milliseconds 500

# ─────────────────────────────────────────────
# PHASE 4: PROGRESS BARS
# ─────────────────────────────────────────────
Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  In a real attack, the next 60 seconds look like this:" "DarkYellow" 10
Write-Host ""
Fake-ProgressBar "Enumerating files on your system    " "Red" 20
Fake-ProgressBar "Reading browser saved passwords     " "DarkRed" 22
Fake-ProgressBar "Scanning devices on your WiFi       " "Red" 18
Fake-ProgressBar "Uploading collected data to attacker" "DarkRed" 22
Fake-ProgressBar "Installing startup persistence key  " "Red" 20
Write-Host ""
Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Milliseconds 500

# ─────────────────────────────────────────────
# PHASE 5: REVEAL
# ─────────────────────────────────────────────
Clear-Host
$Host.UI.RawUI.ForegroundColor = "White"
Start-Sleep -Milliseconds 400

Write-Host ""
Write-Host "  ┌─────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "  │                                                     │" -ForegroundColor Cyan
Write-Host "  │         YOUR COMPUTER IS COMPLETELY FINE.          │" -ForegroundColor Green
Write-Host "  │         THIS WAS A SECURITY AWARENESS DEMO.        │" -ForegroundColor Yellow
Write-Host "  │                                                     │" -ForegroundColor Cyan
Write-Host "  └─────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""
Start-Sleep -Milliseconds 600

Fast-Type "  Nothing above was real. No files touched. No connection made." "White" 11
Fast-Type "  Those CMD windows only printed text. nc.exe never ran." "White" 11
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "  But here is the uncomfortable part:" -ForegroundColor Yellow
Write-Host ""
Fast-Type "  The command that started this entire chain was ONE line:" "White" 10
Write-Host ""
Write-Host "     irm https://subigya.com/virus/index.ps1 | iex" -ForegroundColor Yellow
Write-Host ""
Fast-Type "  irm  = Invoke-WebRequest  -> downloads ANY script from that URL" "DarkGray" 9
Fast-Type "  iex  = Invoke-Expression  -> executes it INSTANTLY, no confirmation" "DarkGray" 9
Fast-Type "  You had zero seconds to review what you were running." "Red" 10
Write-Host ""
Start-Sleep -Milliseconds 600

# ─────────────────────────────────────────────
# PHASE 6: ATTACK VECTORS + TIPS
# ─────────────────────────────────────────────
Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  REAL ATTACK VECTORS THAT USE THIS EXACT PATTERN:" -ForegroundColor Cyan
Write-Host ""

$vectors = @(
    @{ title = "Fake software installs";  desc = "Discord Nitro, game cheats, cracked tools asking you to run a PS command" },
    @{ title = "Tech support scams";      desc = "Fake Microsoft support telling you to open PowerShell and paste a fix" },
    @{ title = "GitHub/Reddit scripts";   desc = "'Run this one-liner to fix your issue' from an unknown commenter" },
    @{ title = "WhatsApp/Discord links";  desc = "Friend's hacked account sends a script link with a photo as decoy" },
    @{ title = "Fake Windows errors";     desc = "Browser fullscreen popup showing error with a PowerShell command to fix it" }
)
foreach ($v in $vectors) {
    Write-Host ("   [!] ") -NoNewline -ForegroundColor Red
    Write-Host $v.title -ForegroundColor Yellow
    Write-Host ("       -> " + $v.desc) -ForegroundColor DarkGray
    Write-Host ""
    Start-Sleep -Milliseconds 200
}

Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  WHAT ACTUALLY PROTECTS YOU:" -ForegroundColor Cyan
Write-Host ""

$tips = @(
    "Before running any PowerShell command — read it word by word",
    "irm <url> | iex means blind execute. Always treat it as a red flag",
    "Legitimate software NEVER asks you to paste a terminal command",
    "A photo opening after a script runs is not proof nothing happened",
    "If someone online gives you a one-liner to run, treat it as an attack",
    "Check running processes after anything suspicious (Task Manager)"
)
foreach ($tip in $tips) {
    Write-Host "   [+] " -NoNewline -ForegroundColor Green
    Fast-Type $tip "White" 9
    Start-Sleep -Milliseconds 150
}

Write-Host ""
Write-Host "  ─────────────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  Share this. The person who needs it most won't think they do." "Cyan" 12
Write-Host ""
Start-Sleep -Milliseconds 1800

# >>> IMAGE DROP 2: AWARENESS CARD
# Fires after full script — stays open until user clicks or presses key.
# No auto-close — this is the lasting takeaway they should read.
Show-FullscreenImage -Url $awarenessImageUrl -FileName "security_tips.png" `
                     -AutoClose $false

Write-Host "  Press any key to close this terminal..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
