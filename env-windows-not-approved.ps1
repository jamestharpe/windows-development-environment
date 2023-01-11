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


# # PowerShell Tooling for Git
# Install-Module posh-git -Force -Scope CurrentUser
# Install-Module oh-my-posh -Force -Scope CurrentUser
# Set-Prompt
# Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
# Add-Content $PROFILE "`nImport-Module posh-git`nImport-Module oh-my-posh`nSet-PoshPrompt Paradox"


# # Font to support PowerShell Tooling:
# git clone https://github.com/ryanoasis/nerd-fonts.git  --depth 1
# cd nerd-fonts
# .\install.ps1
# cd ..\
# Write-Output 'Be sure to configure Windows Terminal fonts! Suggest using "fontFace": "MesloLGM NF"'

#
# AWS awscli
#
choco install awscli --yes
Update-Environment-Path

# Node
# choco install nodejs.install --yes
# Update-Environment-Path
# npm install --global --production npm-windows-upgrade
# npm-windows-upgrade --npm-version latest

#
# Kubernetes
#

# choco install minikube --yes
# choco install kubernetes-cli --yes

# Note: VirtualBox sucks, see instructions here to run minikube: https://medium.com/@JockDaRock/minikube-on-windows-10-with-hyper-v-6ef0f4dc158c
# TLDR: run with `minikube start --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch"`

# Windows Terminal
choco install microsoft-windows-terminal --yes

# File Management
choco install beyondcompare --yes
choco install s3browser --yes
choco install grepwin --yes


# Media Viewers
#choco install irfanview --yes
#choco install vlc --yes

# Misc
choco install sysinternals --yes
#choco install firacode --yes # See https://www.youtube.com/watch?v=KI6m_B1f8jc
choco install everything --yes
choco install wiztree --yes

Update-Environment-Path

# Windows Subsystem for Linux
# wsl --install

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
