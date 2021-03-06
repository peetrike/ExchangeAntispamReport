# Module manifest for module 'ExchangeAntiSpamReports'
# Generated on: 14.09.2016

@{
    RootModule = 'ExchangeAntiSpamReport.psm1'
    ModuleVersion = '1.2.6'

    GUID = '59a64206-b882-406b-8e64-976091800251'
    Author = 'Peter Wawa'
    CompanyName = '!ZUM!'
    Copyright = '(c) 2016 Peter Wawa, licensed to the public under a MIT  license.'
    Description = 'Module for creating antispam reports from Exchange Server (2013 and newer) agent logs'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '3.0'

    # Supported PSEditions
    # CompatiblePSEditions = @('Desktop','Core')

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Connect-ExchangeServer',
        'Get-AntispamReport',
        'Get-AntispamTopBlockedSender',
        'Get-AntispamTopBlockedSenderDomain',
        'Get-AntispamTopBlockedSenderIP',
        'Get-AntispamTopRblPovider',
        'Get-AntispamTopRecipient'
    )

    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
        PSData = @{
            Tags = @('exchange', 'e-mail', 'antispam', 'report')

            ExternalModuleDependencies = @(
                'NetTCPIP'
            )

            LicenseUri = 'https://github.com/peetrike/ExchangeAntispamReport/blob/master/LICENSE'
            ProjectUri = 'https://github.com/peetrike/ExchangeAntispamReport'
            # IconUri = ''

            ReleaseNotes = https://github.com/peetrike/ExchangeAntispamReport/blob/master/CHANGELOG.md
        }
    }

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}
