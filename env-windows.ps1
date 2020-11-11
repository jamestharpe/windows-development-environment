#-------------------------------------------------------------------------------#
#                                                                               #
# This script installs all the stuff I need to develop the things I develop.    #
# Run PowerShell with admin priveleges, type `env-windows`, and go make coffee. #
#                                                                               #
#                                                                        -James #
#                                                                               #
#-------------------------------------------------------------------------------#

#
# Functions
#

function Update-Environment-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
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
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
Update-Environment-Path

# Utils
Get-Command -Module Microsoft.PowerShell.Archive

#
# Git
#

choco install git --yes --params '/GitAndUnixToolsOnPath'
choco install tortoisegit --yes
Update-Environment-Path
git config --global alias.pom 'pull origin master'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short"
git config --global alias.ammend "commit -a --amend"
git config --global alias.standup "log --since yesterday --author $(git config user.email) --pretty=short"
git config --global alias.everything "! git pull && git submodule update --init --recursive"
git config --global alias.aliases "config --get-regexp alias"

# PowerShell Tooling for Git
Install-Module posh-git -Force -Scope CurrentUser
Install-Module oh-my-posh -Force -Scope CurrentUser
Set-Prompt
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
Add-Content $PROFILE "`nImport-Module posh-git`nImport-Module oh-my-posh`nSet-Theme Paradox"


# Font to support PowerShell Tooling:
choco install cascadiacode --yes
choco install cascadiamono --yes
choco install cascadiacodepl --yes
choco install cascadiamonopl --yes

Write-Output 'Be sure to configure Windows Terminal fonts! Suggest using "fontFace": "Cascadia Code PL"'

#
# AWS awscli
#
choco install awscli --yes
Update-Environment-Path

#
# MinGW
# 

choco install mingw --yes
Update-Environment-Path

# Get-Command mingw32-make

# todo: Alias `make` to `mingw32-make` in Git Bash
# todo: Write `mingw32-make %*` to make.bat in MinGW install directory

#
# Caddy HTTP Server
#

choco install caddy --yes
Update-Environment-Path

#
# Languages
#
choco install php --yes
choco install ruby --yes
choco install ruby2.devkit --yes
choco install jdk8 --yes
Update-Environment-Path


git clone https://github.com/pyenv-win/pyenv-win.git $env:USERPROFILE\.pyenv
[Environment]::SetEnvironmentVariable("PYENV", "$env:USERPROFILE\.pyenv\pyenv-win", 'User')
Push-User-Path "%PYENV%\bin"
Push-User-Path "%PYENV%\shims"
pyenv rehash
pyenv install 2.7.9
pyenv install 3.8.3
pyenv global 3.8.3 # default to latest
pyenv rehash
python -m pip install -U pip
pip install virtualenv
Update-Environment-Path
Write-Output "Python, Pyenv, and virtualenv installed! Use 'python3 -m venv <dir>' to create an environment"

# Node
choco install nodejs.install --yes
Update-Environment-Path
npm install --global --production npm-windows-upgrade
npm-windows-upgrade --npm-version latest
npm install -g gulp-cli 
npm install -g yo
npm install -g mocha
npm install -g install-peerdeps
npm install -g typescript

#
# Docker
# 

# Hyper-V required for docker and other things
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All -NoRestart

choco install docker --yes
choco install docker-machine --yes
choco install docker-compose --yes
choco install docker-for-windows --yes

Update-Environment-Path

docker pull worpress
docker pull mysql
docker pull phpmyadmin

Update-Environment-Path

#
# Kubernetes
#

choco install minikube --yes
choco install kubernetes-cli --yes

# Note: VirtualBox sucks, see instructions here to run minikube: https://medium.com/@JockDaRock/minikube-on-windows-10-with-hyper-v-6ef0f4dc158c
# TLDR: run with `minikube start --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch"`


# Yarn
# ?? choco install yarn --yes

# Bower
npm install -g bower

# Grunt
npm install -g grunt-cli

#
# VS Code
#

choco install visualstudiocode --yes # includes dotnet
Update-Environment-Path

code --install-extension robertohuertasm.vscode-icons
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension eamodio.gitlens
code --install-extension oderwat.indent-rainbow
code --install-extension sdras.night-owl
Start-Process https://github.com/sdras/night-owl-vscode-theme

# PowerShell support
code --install-extension ms-vscode.PowerShell

# CSharp support
code --install-extension ms-vscode.csharp

# PHP support
code --install-extension felixfbecker.php-debug
code --install-extension HvyIndustries.crane

# Ruby support
code --install-extension rebornix.Ruby

# HTML, CSS, JavaScript support
code --install-extension Zignd.html-css-class-completion
code --install-extension robinbentley.sass-indented
code --install-extension dbaeumer.vscode-eslint
code --install-extension flowtype.flow-for-vscode
code --install-extension dzannotti.vscode-babel-coloring
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag

# NPM support
code --install-extension eg2.vscode-npm-script
code --install-extension christian-kohler.npm-intellisense

# Mocha support
code --install-extension spoonscen.es6-mocha-snippets
code --install-extension maty.vscode-mocha-sidebar

# Jasmin Support
code --install-extension hbenl.vscode-jasmine-test-adapter

# Jest support
code --install-extension Orta.vscode-jest

# React Native support
code --install-extension vsmobile.vscode-react-native
npm install -g create-react-native-app
npm install -g react-native-cli

# Docker support
code --install-extension PeterJausovec.vscode-docker

# PlantUML support
code --install-extension jebbs.plantuml

# Markdown Support 
code --install-extension yzhang.markdown-all-in-one
code --install-extension mdickin.markdown-shortcuts

# WSL Support
code --install-extension ms-vscode-remote.remote-wsl

#
# MySQL
#

choco install mysql --yes
choco install mysql.workbench --yes


#
# Android Studio
# 

choco install androidstudio --yes

#
# Static Site Generators
#

# Hugo
choco install hugo --yes

#
# Basic Utilities
#

# choco install slack --yes
# choco install xenulinksleuth --yes

# Windows Terminal
choco install microsoft-windows-terminal --yes

# File Management
choco install beyondcompare --yes
choco install 7zip --yes
choco install filezilla --yes
choco install dropbox --yes

# Media Viewers
choco install irfanview --yes
choco install vlc --yes

# Browsers
choco install googlechrome --yes
choco install firefox --yes

# Misc
choco install sysinternals --yes
choco install procexp --yes
choco install awscli --yes
choco install firacode --yes # See https://www.youtube.com/watch?v=KI6m_B1f8jc
choco install everything --yes

Update-Environment-Path

# Windows Subsystem for Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
Update-Environment-Path
wsl --set-default-version 2
Start-Process https://aka.ms/wslstore

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
