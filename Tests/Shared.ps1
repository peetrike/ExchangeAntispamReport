#Requires -Modules BuildHelpers, Pester

# Dot source this script in any Pester test script that requires the module to be imported.

$projectRoot = Split-Path -Path $PSScriptRoot -Parent
$buildEnvironment = Get-BuildEnvironment -Path $projectRoot -BuildOutput "$projectRoot\Release"
$moduleName = $buildEnvironment.ProjectName
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$manifestPath = ("{0}\{1}\{1}.psd1" -f $buildEnvironment.BuildOutput, $moduleName)

if (!$SuppressImportModule) {
    # Remove all versions of the module from the session. Pester can't handle multiple versions.
    Get-Module $moduleName | Remove-Module -Force

    # -Scope Global is needed when running tests from inside of psake, otherwise
    # the module's functions cannot be found in the <%=$PLASTER_PARAM_ModuleName%>\ namespace
    Import-Module $ManifestPath -Scope Global -Force -Verbose:$false -ErrorAction Stop
}
