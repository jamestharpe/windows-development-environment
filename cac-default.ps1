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

# File Management
choco install 7zip --yes
choco install notepadplusplus --yes
choco install wiztree --yes

# Browsers
choco install googlechrome --yes --ignore-checksums
choco install firefox --yes

# Misc
choco install crystaldiskinfo --yes
choco install slack --yes
choco install zoom --yes
choco install adobereader --yes
choco install office365business --yes

Update-Environment-Path

# Windows Subsystem for Linux
# wsl --install

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
