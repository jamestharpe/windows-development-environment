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

#
# Visual Studio 2022
#
$Components = @(
"Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools",
"Microsoft.VisualStudio.Workload.MSBuildTools",
"Microsoft.VisualStudio.Workload.NodeBuildTools;includeOptional",
"Microsoft.VisualStudio.Workload.WebBuildTools",
"Microsoft.VisualStudio.Workload.Azure",
"Microsoft.VisualStudio.Workload.ManagedDesktop",
"Microsoft.VisualStudio.Workload.NativeDesktop",
"Microsoft.VisualStudio.Workload.NetCrossPlat",
"Microsoft.VisualStudio.Workload.NetWeb",
"Microsoft.VisualStudio.Workload.Node",
"Microsoft.VisualStudio.Workload.Python",
"Microsoft.VisualStudio.Workload.Universal"
)
$InstallerArgs = "--add " + ($Components -join " --add ")

choco install visualstudio2022community --yes
choco install visualstudio2022-workload-azure --yes
choco install visualstudio2022-workload-manageddesktop --yes
choco install visualstudio2022-workload-nativedesktop --yes
choco install visualstudio2022-workload-netweb --yes
choco install visualstudio2022-workload-node --includeOptional --yes
choco install visualstudio2022-workload-python --yes
choco install visualstudio2022-workload-universal --yes


#choco install visualstudio2022buildtools --yes --params $InstallerArgs
Update-Environment-Path

Write-Output "Finished! Run `choco upgrade all` to get the latest software"
