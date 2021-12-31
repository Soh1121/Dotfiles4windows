# WSL 2 Kernel Update
msiexec /i wsl_update_x64.msi /passive /norestart
rm wsl_update_x64.msi

# WSL 2 を標準にする
wsl --set-default-version 2

# Ubuntu 2004 をインストール
Add-AppxPackage -Path linux.appx
rm linux.appx

# 再起動
Restart-Computer -Force
