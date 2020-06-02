---
external help file: ExchangeAntiSpamReport-help.xml
Module Name: ExchangeAntiSpamReport
online version:
schema: 2.0.0
---

# Connect-ExchangeServer

## SYNOPSIS
Connects to remote Exchange server and imports management cmdlets.

## SYNTAX

```
Connect-ExchangeServer [-ComputerName] <String> [[-Credential] <PSCredential>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet establishes Powershell remoting session to Exchange server and imports all Exchange management cmdlets that are
allowed to use by RBAC.

You must connect to Exchange server, before you can use other antispam report cmdlets. 
If you use Exchange Management Shell,
you are already connected.

## EXAMPLES

### EXAMPLE 1
```
Connect-ExchangeServer -ComputerName myexchange
```

Connects to exchange server named myexchange by using default credentials

### EXAMPLE 2
```
Connect-ExchangeServer -ComputerName myexchange -Credential 'domain\user'
```

Connects to Exchange server by using provided username. 
The authentication prompt requests a password for the user name.

## PARAMETERS

### -ComputerName
Exchange Server computer name to be connected.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
User credential that will be used to connect. 
By default locally logged on user will be used.
If only username is provided, the credential prompt is provided.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Pass Exchange Server connection into user environment

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.Runspaces.PSSession

## NOTES

## RELATED LINKS

[Get-AgentLog](https://technet.microsoft.com/en-us/library/dd335083)
