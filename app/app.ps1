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
	"licecap"
	"neovim"
	"openssh"
	"rapidee"
	"slack"
	"sourcetree"
	"sudo"
	"tar"
	"vcxsrv"
	"vscode"
	"windows-terminal"
	"xmind8"
	"zoom"
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
	"adobereader"
	"cascadiacodepl"
	"cica"
	"font-hackgen-nerd"
)
choco update
choco install -y $CHOCO_PACKAGES

# パスの登録
$newPath = @(
	"$env:USERPROFILE\scoop\shims"
	"$env:USERPROFILE\scoop\apps\git\current\user\bin"
	"$env:USERPROFILE\scoop\apps\git\current\mingw64\bin"
	"$env:USERPROFILE\scoop\apps\git\current\mingw64\libexec\git-core"
	"$env:USERPROFILE\scoop\apps\googlechrome\current"
	"$env:USERPROFILE\scoop\apps\licecap\current"
	"$env:USERPROFILE\scoop\apps\neovim\current\bin"
	"$env:USERPROFILE\scoop\apps\openssh\current"
	"$env:USERPROFILE\scoop\apps\rapidee\current"
	"$env:USERPROFILE\scoop\apps\slack\current"
	"$env:USERPROFILE\scoop\apps\sudo\current"
	"$env:USERPROFILE\scoop\apps\tar\current\bin"
	"$env:USERPROFILE\scoop\apps\vscode\current\bin"
	"$env:USERPROFILE\scoop\apps\windows-terminal\current"
	"$env:USERPROFILE\scoop\apps\xmind8\current"
	"$env:USERPROFILE\scoop\apps\zoom\current"
) -join ";"

$oldPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
if ($oldPath -ne $newPath) {
	[System.Environment]::SetEnvironmentVariable("_PATH_" + (Get-Date -UFormat "%Y%m%d"), $oldPath, "User")
}
[System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
$ErrorActionPreference = "Stop"

# ファイルの拡張子を表示する
Set-ItemProperty "HKCU:¥Software¥Microsoft¥Windows¥CurrentVersion¥Explorer¥Advanced" -name "HideFileExt" -value "0";

# Explorerの停止(すぐに再起動する)
Stop-Process -Name Explorer -Force;

exit
