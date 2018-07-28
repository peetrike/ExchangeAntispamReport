$ModuleName = 'ExchangeAntispamReport'
$manifestPath = "$PSScriptRoot/../Release/$moduleName/$moduleName.psd1"
# Remove all versions of the module from the session. Pester can't handle multiple versions.
Get-Module $moduleName | Remove-Module -Force

Import-Module -Name $manifestPath -Force -Verbose:$false -ErrorAction Stop


# Requires -Module @{ModuleName = 'Pester'; ModuleVersion = '3.4.0'}

$RequiredVersion = (Get-Module $ModuleName).Version

if ($ExportedAliases = (Get-Module -ListAvailable -FullyQualifiedName @{ ModuleName = $ModuleName; RequiredVersion = $RequiredVersion }).ExportedAliases.Values.Name)
{
	# Remove all versions of the module from the session. Pester can't handle multiple versions.
	Get-Module $ModuleName | Remove-Module

	# Import the required version
	Import-Module $ModuleName -RequiredVersion $RequiredVersion -ErrorAction Stop

	foreach ($ExportedAlias in $ExportedAliases)
	{
		Describe "Testing exported aliases" {

			$script:AliasInSession = $null

			It "Get-Alias should not error out: $ExportedAlias" {
				{ $script:AliasInSession = Get-Alias $ExportedAlias -ErrorAction Stop } | Should Not Throw
			}

			It "Get-Alias should find alias in session: $ExportedAlias" {

				$script:AliasInSession.Name | Should Be $ExportedAlias
			}

			It "Get-Alias should find value: $ExportedAlias" {

				$script:AliasInSession.ResolvedCommandName -or $script:AliasInSession.Definition | Should Be $True
			}
		}
	}
}
else
{
	Write-Host "Module.TestAliases.Tests.ps1:  $ModuleName ($RequiredVersion) does not export any aliases."
}
