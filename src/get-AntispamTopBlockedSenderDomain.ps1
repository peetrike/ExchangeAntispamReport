function Get-AntispamTopBlockedSenderDomain {
    <#
        .SYNOPSIS
        Gets the top N sender domains that were blocked by antispam agents.

        .DESCRIPTION
        This cmdlet scans antispam agent logs for messages not accepted and reports back top N sneder domains.

        Sender e-mail addresses can be taken from SMTP protocol Mail From: command (P1) or from message headers (P2).

        You must connect to Exchange server, before you can use cmdlet.  If you use Exchange Management Shell,
        you are already connected, otherwise you should run Connect-ExchangeServer cmdlet first, to establish connection.

        .PARAMETER Report
        Get sender domain name from P1 (mail from: command) or P2 (e-mail header) addresses.

        .PARAMETER Top
        Display only top N sender domains.  By default top 10 are displayed.

        .PARAMETER Location
        Location of agent log files.  By default Hub transport agent log files are used.

        .PARAMETER TransportService
        Specify transport service, which agent logs should be used.  Default value is Hub.

        .PARAMETER StartDate
        Beginning time period to look for in the agent log files. If not specified, look at all the logs till the endDate.

        .PARAMETER EndDate
        End time period to look for in the agent log files. If not specified, look at all the logs beginning from startDate.

        .EXAMPLE
        Get-AntispamTopBlockedSenderDomain -Report P1

        Get top 10 blocked e-mail senders domains from SMTP protocol Mail From: command.

        .EXAMPLE
        Get-AntispamTopBlockedSenderDomain -Report P2 -TransportService Edge

        Get top 10 blocked e-mail senders domains taken from messge headers.  Use agent logs from Edge transport service.

        .EXAMPLE
        Get-AntispamTopBlockedSenderDomain -Report P1 -EndDate (Get-Date).AddDays(-14)

        Get top 10 blocked e-mail senders domains taken from SMTP protocol Mail From: command.  Use agent logs older than 2 weeks.

        .NOTES
        This cmdlet was originally a script included in Exchange Server media.

        .LINK
        https://technet.microsoft.com/en-us/library/aa996044
        Get-AgentLog
        Connect-ExchangeServer
    #>

    [CmdLetBinding()]
    param (
            [parameter(
                Mandatory = $true,
                HelpMessage='P1 - Mail From: command, P2 - message headers',
                Position=0 )]
            [ValidateSet('p1', 'p2')]
            [string]
        $Report
        ,
            [int]
        $Top = 10
        ,
            [ValidateSet('Hub', 'FrontEnd', 'Edge', 'MailboxSubmission', 'MailboxDelivery')]
            [string]
        $TransportService
        ,
            [string]
        $location
        ,
            [DateTime]
        $startDate
        ,
            [DateTime]
        $endDate
    )

    $PassedParameters = $PSBoundParameters
    $null = $PassedParameters.Remove('report')
    $null = $PassedParameters.Remove('top')

    Get-AgentLog @PassedParameters |
        Where-Object { $_.Action -ne 'AcceptMessage' } |
        Get-SenderDomain -SenderFrom $Report |
        get-TopN -Top $top
}
