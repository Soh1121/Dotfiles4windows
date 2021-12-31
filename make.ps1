# DO NOT RUN ON ISE
# Set-ExecutionPolicy -Scope Process Unrestricted

Start-Process powershell.exe -ArgumentList "-NoExit -file ./app/app.ps1" -Verb RunAs -Wait
Start-Process powershell.exe -ArgumentList "-NoExit -file ./wsl2/init.ps1" -Verb RunAs -Wait
Start-Process powershell.exe -ArgumentList "-NoExit -file ./wsl2/download.ps1" -Verb RunAs -Wait
Start-Process powershell.exe -ArgumentList "-NoExit -file ./wsl2/setup.ps1" -Verb RunAs -Wait
