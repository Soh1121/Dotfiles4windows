# スタートアップにショートカットを作成する関数
function New-StartupApp{
    param(
        [switch]$CurrentUser,

        [parameter(mandatory)]
        [string]$LinkName,

        [parameter(mandatory)]
        [string]$ExeName,

        [parameter(mandatory)]
        [string]$IconName
    )

    # スタートアップ フォルダーを指定
    $Reg = "{0}:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
    if($CurrentUser -eq $true){
        $startupPath = $(Get-ItemProperty ($Reg -f "HKCU")).startup
    }
    else{
        $StartupPath = $(Get-ItemProperty ($Reg -f "HKLM")).'common startup'
    }

    # ショートカット先をチェック
    $ShortCutPath = "{0}\$linkName.lnk" -f $StartupPath

    if((Test-Path -Path $ShortCutPath) -eq $true){
        Write-Host "$LinkName.lnk Existed." -ForegroundColor Yellow
        return
    }

    # ショートカットを作る
    $WsShell = New-Object -ComObject WScript.Shell
    $ShortCut = $WsShell.CreateShortcut($shortCutPath)
    $ShortCut.TargetPath = $exeName
    $ShortCut.IconLocation = $iconName
    $ShortCut.Save()

    Write-Host "$linkName.lnk Created." -ForegroundColor Cyan
}

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

# スタートアップへのソートカットの作成
New-StartupApp `
    -CurrentUser `
    -LinkName "XLaunch" `
    -ExeName "$env:USERPROFILE\scoop\app\vcxsrv\current\xlaunch.exe -run .\wsl2\config.xlaunch" `
    -IconName "$env:USERPROFILE\scoop\app\vcxsrv\current\xlaunch.exe"

exit
