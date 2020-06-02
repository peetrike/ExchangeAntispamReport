---
external help file: ExchangeAntiSpamReport-help.xml
Module Name: ExchangeAntiSpamReport
online version:
schema: 2.0.0
---

# Get-AntispamReport

## SYNOPSIS

## SYNTAX

```
Get-AntispamReport [-Report] <String> [-Top <Int32>] [-TransportService <String>] [-Location <String>]
 [-StartDate <DateTime>] [-EndDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -EndDate
{{ Fill EndDate Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
{{ Fill Location Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Report
{{ Fill Report Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: connections, commands, messagesrejected, messagesdeleted, messagesquarantined

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
{{ Fill StartDate Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
{{ Fill Top Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransportService
{{ Fill TransportService Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Hub, FrontEnd, Edge, MailboxSubmission, MailboxDelivery

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-ExchangeServer](Connect-ExchangeServer.md)

[Get-AgentLog](https://docs.microsoft.com/en-us/powershell/module/exchange/get-agentlog)
