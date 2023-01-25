#
# Functions
#

function Update-Environment-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Push-User-Path($userPath) {
    $path = [Environment]::GetEnvironmentVariable('Path', 'User')
    $newpath = "$userPath;$path"
    [Environment]::SetEnvironmentVariable("Path", $newpath, 'User')
    Update-Environment-Path
}

#
# Package Managers
#

# Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Update-Environment-Path

# Utils
Get-Command -Module Microsoft.PowerShell.Archive

#
# Git
#

choco install git --yes --params '/GitAndUnixToolsOnPath'
choco install tortoisegit --yes
Update-Environment-Path

git config --global core.editor "code --wait"
git config --global init.defaultBranch main

# Aliases
git config --global alias.pom 'pull origin main'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short --graph"
git config --global alias.standup "log --since yesterday --author $(git config user.email) --pretty=short"
git config --global alias.ammend "commit -a --amend"
git config --global alias.everything "! git pull && git submodule update --init --recursive"
git config --global alias.aliases "config --get-regexp alias"

#
# Docker Desktop
# 

# Hyper-V required for docker and other things
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All -NoRestart

choco install docker-desktop --yes

Update-Environment-Path

#
# VS Code
#

choco install visualstudiocode --yes # includes dotnet
Update-Environment-Path

bash.exe vscode-extensions.sh

# File Management
choco install beyondcompare --yes
choco install 7zip --yes
choco install notepadplusplus --yes
choco install filezilla --yes
choco install winscp --yes
#choco install kdiff3 --yes

# Browsers
choco install googlechrome --yes
choco install firefox --yes

# Misc
choco install procexp --yes
choco install putty --yes
choco install openssh --yes
choco install mremoteng --yes


Update-Environment-Path

# Windows Subsystem for Linux
# wsl --install

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
