# DO NOT RUN ON ISE

# バーチャルホストの有効
# Linux 用 Windows サブシステム
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# 仮想マシン プラットフォーム
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 再起動
Restart-Computer -Force
