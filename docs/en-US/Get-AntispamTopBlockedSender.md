---
external help file: ExchangeAntiSpamReport-help.xml
Module Name: ExchangeAntiSpamReport
online version: https://technet.microsoft.com/en-us/library/aa996044
schema: 2.0.0
---

# Get-AntispamTopBlockedSender

## SYNOPSIS
Gets the top N sender e-mail addresses that were blocked by antispam agents.

## SYNTAX

```
Get-AntispamTopBlockedSender [-Report] <String> [-Top <Int32>] [-TransportService <String>]
 [-location <String>] [-startDate <DateTime>] [-endDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet scans antispam agent logs for messages not accepted and reports back top N sender e-mail addresses.

Sender e-mail addresses can be taken from SMTP protocol Mail From: command (P1) or from message headers (P2).

You must connect to Exchange server, before you can use cmdlet. 
If you use Exchange Management Shell,
you are already connected, otherwise you should run Connect-ExchangeServer cmdlet first, to establish connection.

## EXAMPLES

### EXAMPLE 1
```
Get-AntispamTopBlockedSender -Report p1
```

Get top 10 blocked e-mail senders e-mail addresses from SMTP protocol Mail From: command.

## PARAMETERS

### -Report
Get sender e-mail address from P1 (mail from: command) or P2 (e-mail header) addresses

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: p1, p2

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Display only top N sender e-mail addresses. 
By default top 10 are displayed.

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
Specify transport service, which agent logs should be used. 
Default value is Hub

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

### -endDate
End time period to look for in the agent log files.
If not specified, look at all the logs beginning from startDate.

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

### -location
Location of agent log files. 
By default Hub transport agent log files are used.

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

### -startDate
Beginning time period to look for in the agent log files.
If not specified, look at all the logs till the endDate.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

This cmdlet was originally a script included in Exchange Server media.

## RELATED LINKS

[Connect-ExchangeServer](Connect-ExchangeServer.md)

[Get-AgentLog](https://docs.microsoft.com/en-us/powershell/module/exchange/get-agentlog)
