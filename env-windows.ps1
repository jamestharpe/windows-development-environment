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
# Choco
#
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
# Docker
# 
choco install docker --yes
choco install docker-machine --yes
choco install docker-compose --yes
RefreshEnvPath
docker pull worpress
docker pull mysql
docker pull phpmyadmin

#
# Scripting Languages
#
choco install php --yes
choco install ruby --yes
choco install ruby2.devkit --yes
choco install nodejs.install --yes
RefreshEnvPath

# Node and ESLint w/ React plugin
npm i eslint babel-eslint eslint-config-airbnb eslint-plugin-react gulp-cli

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

# React suppor
code --install-extension vsmobile.vscode-react-native

# Docker support
code --install-extension PeterJausovec.vscode-docker

#
# MySQL
#
choco install mysql --yes
choco install mysql.workbench --yes

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