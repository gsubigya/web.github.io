# Clear the screen first (optional)
Clear-Host

# Print a simple message
Write-Host "Starting the script..."

# Print a separator
Write-Host "----------------------"

# Print a colored message
Write-Host "Pookie Pie!" -ForegroundColor Cyan

# Print a message that could be piped to a file
Write-Output "Log entry: Script finished at $(Get-Date)"
