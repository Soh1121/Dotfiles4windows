# DO NOT RUN ON ISE
# Set-ExecutionPolicy -Scope Process Unrestricted

# バーチャルホストの有効
# Linux 用 Windows サブシステム
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# 仮想マシン プラットフォーム
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

pause
