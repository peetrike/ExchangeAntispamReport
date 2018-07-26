# ExchangeAntispamReport

This Powershell module contains Exchange Server antispam report scripts that come included in Exchange Server media.  But they don't work unmodified.

I took those scripts, modified them to make them work and then added them into module.  As a bonus, the module has function to establish remote Exchagne serve connection to be able to get access to antispam agent logs.  Through that established connection it is possible to bring Exchange management commands to local computer

## Installation

Get this module from [PowerShell Gallery](https://www.powershellgallery.com)

1. Ensure that you have PowershellGet module.  IF you have PowerShell 5 or newer, you already have that module.  For Powershell 3 and 4, you can follow the instructions to install it using [PackageManagement MSI](https://docs.microsoft.com/en-us/powershell/gallery/installing-psget).
2. Now get the module:

```powershell
Install-Module ExchangeAntiSpamReport
```

3. If you want to inspect module instead of installing it:

```powershell
Save-Module ExchangeAntiSpamReport
```
