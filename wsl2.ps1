# WSL 2 Kernel Update
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi -UseBasicParsing
msiexec /i wsl_update_x64.msi /passive /norestart
rm wsl_update_x64.msi

# WSL 2 を標準にする
wsl --set-default-version 2

# Ubuntu 2004 をインストール
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile linux.appx -UseBasicParsing
Add-AppxPackage -Path linux.appx
rm linux.appx

# 再起動
Restart-Computer -Force
