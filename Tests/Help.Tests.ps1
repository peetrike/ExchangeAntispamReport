#Requires -Modules BuildHelpers, Pester

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

# Taken with love from @juneb_get_help (https://www.github.com/juneb/PesterTDD/master/Module.Help.Tests.ps1)

# Get module commands
$commands = Get-Command -Module $moduleName -CommandType Cmdlet, Function # Workflow not supported on PS7

## When testing help, remember that help is cached at the beginning of each session.
## To test, restart session.

foreach ($command in $commands) {
    $commandName = $command.Name

    # The module-qualified command fails on Microsoft.PowerShell.Archive cmdlets
    $help = Get-Help $commandName -ErrorAction SilentlyContinue

    Describe "Test help for $commandName" -Tags @('MetaTest') {

        # If help is not found, synopsis in auto-generated help is the syntax diagram
        It 'should not be auto-generated' -TestCases @{ Help = $Help } {
            $help.Synopsis | Should -Not -BeLike '*`[`<CommonParameters`>`]*'
        }

        # Should be a description for every function
        It "gets description for $commandName" -TestCases @{ Help = $Help } {
            $help.Description | Should -Not -BeNullOrEmpty
        }

        # Should be at least one example
        It "gets example code from $commandName" -TestCases @{ Help = $Help } {
            ($help.Examples.Example | Select-Object -First 1).Code | Should -Not -BeNullOrEmpty
        }

        # Should be at least one example description
        It "gets example help from $commandName" -TestCases @{ Help = $Help } {
            ($help.Examples.Example.Remarks | Select-Object -First 1).Text | Should -Not -BeNullOrEmpty
        }

        Context "Test parameter help for $commandName" {

            $common = 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable',
                'OutBuffer', 'OutVariable', 'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable',
                'Confirm', 'Whatif'

            $parameters = $command.ParameterSets.Parameters |
                Sort-Object -Property Name -Unique |
                Where-Object { $_.Name -notin $common }
            $parameterNames = $parameters.Name

            ## Without the filter, WhatIf and Confirm parameters are still flagged in "finds help parameter in code" test
            $helpParameters = $help.Parameters.Parameter |
                Where-Object { $_.Name -notin $common } |
                Sort-Object -Property Name -Unique
            $helpParameterNames = $helpParameters.Name

            foreach ($parameter in $parameters) {
                $parameterName = $parameter.Name
                $parameterHelp = $help.parameters.parameter | Where-Object Name -EQ $parameterName

                # Should be a description for every parameter
                It "gets help for parameter: $parameterName : in $commandName" -TestCases @{
                    parameterHelp = $parameterHelp
                } {
                    $parameterHelp.Description.Text | Should -Not -BeNullOrEmpty
                }

                $codeMandatory = $parameter.IsMandatory.toString()

                # Required value in Help should match IsMandatory property of parameter
                It "help for $parameterName parameter in $commandName has correct Mandatory value" -TestCases @{
                    parameterHelp = $parameterHelp
                    codeMandatory = $codeMandatory
                } {
                    $parameterHelp.Required | Should -Be $codeMandatory
                }

                $codeType = $parameter.ParameterType.Name

                # To avoid calling Trim method on a null object.
                $helpType = if ($parameterHelp.parameterValue) { $parameterHelp.parameterValue.Trim() }

                # Parameter type in Help should match code
                It "help for $commandName has correct parameter type for $parameterName" -TestCases @{
                    helpType = $helpType
                    codeType = $codeType
                } {
                    $helpType | Should -Be $codeType
                }
            }

            foreach ($helpParm in $HelpParameterNames) {
                # Shouldn't find extra parameters in help.
                It "finds help parameter in code: $helpParm" -TestCases @{
                    helpParm = $helpParm
                    parameterNames = $parameterNames
                } {
                    $helpParm -in $parameterNames | Should -Be $true
                }
            }
        }

        Context "Help Links should be Valid for $commandName" {
            $link = $help.relatedLinks.navigationLink.uri

            foreach ($link in $links) {
                if ($link) {
                    # Should have a valid uri if one is provided.
                    It "[$link] should have 200 Status Code for $commandName" {
                        $Results = Invoke-WebRequest -Uri $link -UseBasicParsing
                        $Results.StatusCode | Should -Be '200'
                    }
                }
            }
        }
    }
}
