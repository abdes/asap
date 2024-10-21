#!/usr/bin/env pwsh

# Based on: https://github.com/dotnet/Nerdbank.GitVersioning/blob/main/init.ps1
<#
.SYNOPSIS
    Installs dependencies required to build and test the projects in this
    repository.
.DESCRIPTION
    This does not require elevation, as the SDK and runtimes are installed to a
    per-user location.
.PARAMETER NoPreCommitHooks
    Skips the installation of pre-commit (https://pre-commit.com/) and its
    hooks.
#>
[CmdletBinding(SupportsShouldProcess = $true)]
Param (
    [Parameter()]
    [switch]$NoPreCommitHooks,
    [Parameter()]
    [switch]$Help
)

if ($Help) {
    Get-Help $MyInvocation.MyCommand.Definition
    exit
}

# Environment variables and Path that can be propagated via a temp file to a
# caller script.
#
# For example: $EnvVars['KEY'] = "VALUE"
#
$EnvVars = @{}
$PrependPath = @()
$HeaderColor = 'Green'
$ToolsDirectory = "$PSScriptRoot\tools"

# Check if the pre-commit hooks were already installed in the repo.
$lockFile = ".pre-commit.installed.lock";
$preCommitInstalled = Test-Path -Path $lockFile
if (!$NoPreCommitHooks -and !$preCommitInstalled -and $PSCmdlet.ShouldProcess("pip install", "pre-commit")) {
    Write-Host "Installing pre-commit and its hooks" -ForegroundColor $HeaderColor
    New-Item $lockFile

    pip install pre-commit
    if ($LASTEXITCODE -ne 0) {
        Exit $LASTEXITCODE
    }

    pre-commit install
    if ($LASTEXITCODE -ne 0) {
        Exit $LASTEXITCODE
    }

    Write-Host ""
}

Push-Location $PSScriptRoot
try {
    & "$ToolsDirectory/Set-EnvVars.ps1" -Variables $EnvVars -PrependPath $PrependPath | Out-Null
}
catch {
    Write-Error $error[0]
    exit $lastexitcode
}
finally {
    Pop-Location
}
