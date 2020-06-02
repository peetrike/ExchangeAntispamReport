---
external help file: ExchangeAntiSpamReport-help.xml
Module Name: ExchangeAntiSpamReport
online version:
schema: 2.0.0
---

# Get-AntispamTopBlockedSenderIP

## SYNOPSIS
Gets the top N blocked message senders by IP.

## SYNTAX

```
Get-AntispamTopBlockedSenderIP [[-Top] <Int32>] [[-TransportService] <String>] [[-Location] <String>]
 [[-StartDate] <DateTime>] [[-EndDate] <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet scans antispam agent logs for messages not accepted and reports back top N sender server IPs.

You must connect to Exchange server, before you can use cmdlet. 
If you use Exchange Management Shell,
you are already connected, otherwise you should run Connect-ExchangeServer cmdlet first, to establish connection.

## EXAMPLES

### EXAMPLE 1
```
Get-AntispamTopBlockedSenderIP -Top 5
```

Returns top 5 IP addresses that sent messages blocked by antispam agents.

### EXAMPLE 2
```
Get-AntispamTopBlockedSenderIP -TransportService FrontEnd
```

Returns top 10 IP addresses blocked. 
Use FrontEnd transport agent logs.

### EXAMPLE 3
```
Get-AntispamTopBlockedSenderIP -StartDate (Get-Date).AddDays(-14)
```

Get top 10 IP addresses blocked. 
Look only for last 2 weeks of logs.

## PARAMETERS

### -EndDate
End time period to look for in the agent log files.
If not specified, look at all the logs beginning from startDate.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Location of agent log files. 
By default Hub transport agent log files are used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Beginning time period to look for in the agent log files.
If not specified, look at all the logs till the endDate.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Display only top N RBL providers. 
By default top 10 are displayed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
Position: 1
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
