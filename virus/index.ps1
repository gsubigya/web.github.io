# ============================================================
# HARMLESS CYBERSECURITY AWARENESS SCRIPT - FAST VERSION
# Does ZERO damage. For education only.
# ============================================================

$Host.UI.RawUI.WindowTitle = "!!! SECURITY BREACH DETECTED !!!"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Red"
Clear-Host

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
        Write-Host "=" -NoNewline -ForegroundColor $BarColor
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "DONE" -ForegroundColor Green
}

# ─────────────────────────────────────────────
# PHASE 1: BIG VISIBLE BREACH BANNER
# ─────────────────────────────────────────────
Clear-Host
Write-Host ""
Write-Host "  #######################################################" -ForegroundColor Red
Write-Host "  ##                                                   ##" -ForegroundColor Red
Write-Host "  ##        !!!  SECURITY BREACH DETECTED  !!!        ##" -ForegroundColor Yellow
Write-Host "  ##                                                   ##" -ForegroundColor Red
Write-Host "  ##   UNAUTHORIZED REMOTE ACCESS -- SYSTEM EXPOSED   ##" -ForegroundColor Red
Write-Host "  ##                                                   ##" -ForegroundColor Red
Write-Host "  #######################################################" -ForegroundColor Red
Write-Host ""
Start-Sleep -Milliseconds 800

Write-Host "  >> ALERT: PRIVILEGE ESCALATION CONFIRMED" -ForegroundColor Red
Write-Host "  >> ALERT: FIREWALL RULES BYPASSED" -ForegroundColor Red
Write-Host "  >> ALERT: ANTIVIRUS PROCESS TERMINATED" -ForegroundColor DarkRed
Write-Host ""
Start-Sleep -Milliseconds 600

# ─────────────────────────────────────────────
# PHASE 2: FAST SYSTEM INFO GRAB
# ─────────────────────────────────────────────
Fast-Type "  [INTRUSION DETECTED] Remote access session started..." "Red" 10
Start-Sleep -Milliseconds 200
Fast-Type "  [SYS] Host fingerprint captured: $env:COMPUTERNAME / $env:USERNAME" "Yellow" 8
Start-Sleep -Milliseconds 200
Fast-Type "  [NET] Handshake confirmed from 185.220.101.47 (TOR EXIT NODE)" "Red" 8
Start-Sleep -Milliseconds 200
Fast-Type "  [SYS] OS: $([System.Environment]::OSVersion.VersionString)" "DarkYellow" 8
Start-Sleep -Milliseconds 200
Fast-Type "  [SYS] Machine GUID extracted from registry..." "DarkYellow" 8
Write-Host ""
Start-Sleep -Milliseconds 400

# ─────────────────────────────────────────────
# PHASE 3: IMMEDIATELY SPAWN ALL CMD WINDOWS
# ─────────────────────────────────────────────
Fast-Type "  > Spawning system access threads..." "DarkYellow" 8
Write-Host ""
Start-Sleep -Milliseconds 200

# Fire all CMD windows rapidly back to back
Start-Process "cmd.exe" -ArgumentList '/c title [THREAD-1] LSASS DUMP & color 04 & echo. & echo  [*] Attaching to lsass.exe process... & echo  [*] Dumping memory to C:\Windows\Temp\ls.dmp & echo  [*] SUCCESS - 47MB extracted & timeout /t 4 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 150
Start-Process "cmd.exe" -ArgumentList '/c title [THREAD-2] CREDENTIAL HARVEST & color 04 & echo. & echo  [*] Reading Chrome Login Data... & echo  [*] Decrypting AES keys from AppData... & echo  [*] 47 passwords extracted & timeout /t 4 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 150
Start-Process "cmd.exe" -ArgumentList '/c title [THREAD-3] REVERSE SHELL & color 04 & echo. & echo  [*] Opening TCP socket on port 4444... & echo  [*] Connecting to 185.220.101.47... & echo  [*] Shell session established & timeout /t 4 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 150
Start-Process "cmd.exe" -ArgumentList '/c title [THREAD-4] REGISTRY PERSISTENCE & color 04 & echo. & echo  [*] Writing to HKCU\Software\Microsoft\Windows\CurrentVersion\Run & echo  [*] Startup entry created successfully & echo  [*] Will execute on every login & timeout /t 4 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 150
Start-Process "cmd.exe" -ArgumentList '/c title [THREAD-5] FILE INDEXER & color 04 & echo. & echo  [*] Scanning Documents, Desktop, Downloads... & echo  [*] Flagging .pdf .docx .xlsx .kdbx files... & echo  [*] 312 sensitive files queued for upload & timeout /t 4 /nobreak > nul' -WindowStyle Normal
Start-Sleep -Milliseconds 150
Start-Process "cmd.exe" -ArgumentList '/c title [THREAD-6] DEFENDER KILL & color 04 & echo. & echo  [*] Suspending MsMpEng.exe... & echo  [*] Disabling real-time protection... & echo  [*] Windows Defender neutralized & timeout /t 4 /nobreak > nul' -WindowStyle Normal

# Print thread spawned messages fast
$threads = @(
    "[THREAD-1] LSASS memory dump -> C:\Windows\Temp\ls.dmp",
    "[THREAD-2] Chrome credential harvest -> 47 passwords",
    "[THREAD-3] Reverse shell -> port 4444 OPEN",
    "[THREAD-4] Registry persistence -> startup key written",
    "[THREAD-5] File indexer -> 312 sensitive files flagged",
    "[THREAD-6] Windows Defender -> NEUTRALIZED"
)
foreach ($t in $threads) {
    Write-Host "    SPAWNED: " -NoNewline -ForegroundColor DarkGray
    Write-Host $t -ForegroundColor Red
    Start-Sleep -Milliseconds 180
}

Write-Host ""
Start-Sleep -Milliseconds 500

# ─────────────────────────────────────────────
# PHASE 4: FILE CRAWL (fast)
# ─────────────────────────────────────────────
Fast-Type "  > Deep filesystem crawl complete. Results:" "Cyan" 8
Write-Host ""

$fakeDirs = @(
    "C:\Users\$env:USERNAME\Documents",
    "C:\Users\$env:USERNAME\Downloads",
    "C:\Users\$env:USERNAME\Desktop",
    "C:\Users\$env:USERNAME\.ssh",
    "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Credentials",
    "C:\Users\$env:USERNAME\AppData\Local\Google\Chrome\User Data\Default",
    "C:\Users\$env:USERNAME\AppData\Roaming\discord\Local Storage",
    "C:\Windows\System32\config"
)

foreach ($dir in $fakeDirs) {
    $fileCount = Get-Random -Minimum 8 -Maximum 312
    Write-Host "    [OK] " -NoNewline -ForegroundColor DarkGreen
    Write-Host "$dir  " -NoNewline -ForegroundColor Gray
    Write-Host "($fileCount files)" -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 120
}

Write-Host ""
Start-Sleep -Milliseconds 300

# ─────────────────────────────────────────────
# PHASE 5: FAST PROGRESS BARS
# ─────────────────────────────────────────────
Write-Host "  -----------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Fake-ProgressBar "Packaging collected data    " "Red" 22
Fake-ProgressBar "Encrypting payload (AES-256)" "DarkRed" 20

# Second CMD wave fires during upload bar
Start-Process "cmd.exe" -ArgumentList '/c title [UPLOAD] DATA EXFIL & color 04 & echo. & echo  [*] Connecting to drop server 185.220.101.47:443... & echo  [*] Uploading encrypted archive... & echo  [*] 94%% complete & timeout /t 5 /nobreak > nul' -WindowStyle Normal
Start-Process "cmd.exe" -ArgumentList '/c title [CLEANUP] COVER TRACKS & color 04 & echo. & echo  [*] Deleting event logs... & echo  [*] Clearing prefetch files... & echo  [*] VSS shadow copies removed & timeout /t 5 /nobreak > nul' -WindowStyle Normal

Fake-ProgressBar "Uploading to 185.220.101.47 " "Red" 22
Fake-ProgressBar "Installing persistence hook " "DarkRed" 20
Fake-ProgressBar "Wiping event logs           " "DarkYellow" 18

Write-Host ""
Write-Host "  -----------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Milliseconds 400

# ─────────────────────────────────────────────
# PHASE 6: FINAL LINES
# ─────────────────────────────────────────────
Write-Host "  [ROOT] " -NoNewline -ForegroundColor DarkRed
Fast-Type "Full system access granted. Standing by for commands." "Red" 10
Start-Sleep -Milliseconds 300
Write-Host "  [C2]   " -NoNewline -ForegroundColor DarkYellow
Fast-Type "Beacon active. Ping interval: 30s. Operator notified." "DarkYellow" 10
Start-Sleep -Milliseconds 300
Write-Host "  [LOG]  " -NoNewline -ForegroundColor DarkGray
Fast-Type "All local traces removed. Persistence confirmed." "DarkGray" 10
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "  #######################################################" -ForegroundColor DarkRed
Write-Host "  ##    THIS DEVICE IS NOW PART OF A BOTNET           ##" -ForegroundColor Red
Write-Host "  ##    DO NOT CLOSE THIS WINDOW                      ##" -ForegroundColor DarkRed
Write-Host "  #######################################################" -ForegroundColor DarkRed
Start-Sleep -Seconds 3

# ─────────────────────────────────────────────
# THE REVEAL
# ─────────────────────────────────────────────
Clear-Host
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host
Start-Sleep -Milliseconds 400

Write-Host ""
Write-Host "  +====================================================+" -ForegroundColor Cyan
Write-Host "  |                                                    |" -ForegroundColor Cyan
Write-Host "  |        CYBERSECURITY AWARENESS MESSAGE            |" -ForegroundColor Yellow
Write-Host "  |                                                    |" -ForegroundColor Cyan
Write-Host "  +====================================================+" -ForegroundColor Cyan
Write-Host ""

Fast-Type "  Breathe. Your computer is completely fine." "Green" 15
Write-Host ""
Fast-Type "  Nothing above was real. No data was touched." "White" 12
Fast-Type "  No files moved. No connections made. No harm done." "White" 12
Fast-Type "  Those CMD windows only printed text. Nothing was executed." "White" 12
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "  But here is the uncomfortable truth:" -ForegroundColor Yellow
Write-Host ""
Fast-Type "  If that had been a real malicious script from a stranger's URL," "White" 10
Fast-Type "  everything you just watched could have happened for real --" "Red" 10
Fast-Type "  in the exact same 60 seconds it took you to panic." "Red" 10
Write-Host ""

Write-Host "  The command that started this:" -ForegroundColor DarkGray
Write-Host ""
Write-Host "     irm https://subigya.com/virus/index.ps1 | iex" -ForegroundColor Yellow
Write-Host ""
Fast-Type "  That downloads and executes WHATEVER code that URL serves." "White" 10
Fast-Type "  No confirmation. No preview. No going back." "White" 10
Write-Host ""

Write-Host "  -------------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  PROTECT YOURSELF:" -ForegroundColor Cyan
Write-Host ""

$tips = @(
    "Never run scripts from URLs you don't fully trust",
    "Always read the source code before executing anything",
    "Verify the domain is official -- typos are used to trick you",
    "If someone online tells you to run a command, that is a red flag",
    "Real tech support NEVER asks you to paste commands in PowerShell"
)
foreach ($tip in $tips) {
    Write-Host "   [+] " -NoNewline -ForegroundColor Green
    Fast-Type $tip "White" 10
    Start-Sleep -Milliseconds 150
}

Write-Host ""
Write-Host "  -------------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
Fast-Type "  Share this. Someone you know needs to see it." "Cyan" 12
Write-Host ""
Write-Host "  -- Awareness initiative by subigya.com --" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Press any key to close..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
