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

## 利用準備
scoop install git
scoop install aria2
scoop update
scoop bucket add extras
scoop bucket add versions

## パッケージのインストール
$SCOOP_PACKAGES = @(
	"googlechrome"
	"vscode"
	"slack"
	"zoom"
	"rapidee"
	"licecap"
	"openssh"
	"sudo"
	"tar"
	"neovim"
	"windows-terminal"
	"xmind8"
)
scoop update *
scoop install $SCOOP_PACKAGES
scoop cache rm *

# Chocolatey
## インストール
try {
  Get-Command -Name choco -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

## パッケージのインストール
$CHOCO_PACKAGES = @(
	"docker-desktop"
	"adobereader"
	"cica"
	"cascadiacodepl"
	"font-hackgen-nerd"
)
choco update
choco install -y $CHOCO_PACKAGES
