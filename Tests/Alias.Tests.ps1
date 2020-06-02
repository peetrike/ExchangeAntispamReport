#Requires -Modules BuildHelpers, Pester

[System.Diagnostics.CodeAnalysis.SuppressMessage(
    'PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule'
)]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

$RequiredVersion = (Get-Module $ModuleName).Version

if ($ExportedAliases = (Get-Module $ModuleName).ExportedAliases.Values.Name) {
    foreach ($ExportedAlias in $ExportedAliases) {
        $AliasInSession = Get-Alias $ExportedAlias -ErrorAction SilentlyContinue

        Describe "Testing exported alias $ExportedAlias" -Tags @('MetaTest') {
            It "Get-Alias should not error out" -TestCases @{
                ExportedAlias  = $ExportedAlias
                AliasinSession = $AliasInSession
            } {
                $AliasInSession | Should -Not -BeNullOrEmpty
            }

            It "Get-Alias should find alias in session" -TestCases @{
                ExportedAlias  = $ExportedAlias
                AliasinSession = $AliasInSession
            } {
                $AliasInSession.Name | Should -Be $ExportedAlias
            }

            It "Get-Alias should find value" -TestCases @{
                ExportedAlias  = $ExportedAlias
                AliasinSession = $AliasInSession
            } {
                $AliasInSession.ResolvedCommandName -or $AliasInSession.Definition | Should -Be $True
            }
        }
    }
} else {
    Write-Host "Aliases.Tests.ps1:  $ModuleName ($RequiredVersion) does not export any aliases."
}
