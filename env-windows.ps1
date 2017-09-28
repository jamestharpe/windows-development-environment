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

function RefreshEnvPath
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#
# Package Managers
#

# Choco
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | iex
RefreshEnvPath

#
# Git
#

choco install git --yes
choco install tortoisegit --yes
RefreshEnvPath

#
# MinGW
# 

choco install mingw --yes
RefreshEnvPath

# Get-Command mingw32-make

# todo: Alias `make` to `mingw32-make` in Git Bash
# todo: Write `mingw32-make %*` to make.bat in MinGW install directory

#
# Caddy HTTP Server
#

choco install caddy --yes
RefreshEnvPath

#
# Languages
#
choco install php --yes
choco install ruby --yes
choco install ruby2.devkit --yes
choco install python2 --yes
choco install jdk8 --yes
RefreshEnvPath

# Node
choco install nodejs.install --yes
RefreshEnvPath
npm install --global --production npm-windows-upgrade
npm-windows-upgrade --npm-version latest
npm install -g gulp-cli 
npm install -g yo
npm install -g generator-docker

#
# Docker
# 
choco install docker --yes
choco install docker-machine --yes
choco install docker-compose --yes
RefreshEnvPath
docker pull worpress
docker pull mysql
docker pull phpmyadmin


# Yarn
# ?? choco install yarn --yes

# Bower
npm install -g bower

# Grunt
npm install -g grunt-cli

# ESLint
npm install -g eslint
npm install -g babel-eslint
npm install -g eslint-plugin-react
npm install -g install-peerdeps
install-peerdeps --dev eslint-config-airbnb

#
# VS Code
#

choco install visualstudiocode --yes # includes dotnet
RefreshEnvPath
code --install-extension robertohuertasm.vscode-icons

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
code --install-extension lonefy.vscode-JS-CSS-HTML-formatter
code --install-extension robinbentley.sass-indented
code --install-extension dbaeumer.vscode-eslint
code --install-extension RobinMalfait.prettier-eslint-vscode
code --install-extension flowtype.flow-for-vscode
code --install-extension dzannotti.vscode-babel-coloring

# React Native support
code --install-extension vsmobile.vscode-react-native
npm install -g create-react-native-app
npm install -g react-native-cli

# Docker support
code --install-extension PeterJausovec.vscode-docker

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

RefreshEnvPath

Write-Output "Finished! Run `choco upgrade all` to get the latest software"