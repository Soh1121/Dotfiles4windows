# DO NOT RUN ON ISE
# Set-ExecutionPolicy -Scope Process Unrestricted

# Scoop
## インストール
try {
  Get-Command -Name scoop -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

scoop install git

pause
