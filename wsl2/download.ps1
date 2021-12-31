Invoke-RestMethod https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi
Invoke-RestMethod https://aka.ms/wslubuntu2004 -OutFile linux.appx

exit
