function Get-AntispamTopBlockedSender {
    <#
        .SYNOPSIS
        Gets the top N sender e-mail addresses that were blocked by antispam agents.

        .DESCRIPTION
        This cmdlet scans antispam agent logs for messages not accepted and reports back top N sender e-mail addresses.

        Sender e-mail addresses can be taken from SMTP protocol Mail From: command (P1) or from message headers (P2).

        You must connect to Exchange server, before you can use cmdlet.  If you use Exchange Management Shell,
        you are already connected, otherwise you should run Connect-ExchangeServer cmdlet first, to establish connection.


        .PARAMETER Report
        Get sender e-mail address from P1 (mail from: command) or P2 (e-mail header) addresses

        .PARAMETER Top
        Display only top N sender e-mail addresses.  By default top 10 are displayed.

        .PARAMETER Location
        Location of agent log files.  By default Hub transport agent log files are used.

        .PARAMETER TransportService
        Specify transport service, which agent logs should be used.  Default value is Hub

        .PARAMETER StartDate
        Beginning time period to look for in the agent log files. If not specified, look at all the logs till the endDate.

        .PARAMETER EndDate
        End time period to look for in the agent log files. If not specified, look at all the logs beginning from startDate.

        .EXAMPLE
        Get-AntispamTopBlockedSender -Report p1

        Get top 10 blocked e-mail senders e-mail addresses from SMTP protocol Mail From: command.

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

    $filter = {}
    switch ($Report) {
        'p1' {
            $filter = { $_.Action -ne 'AcceptMessage' -and $_.P1FromAddress -ne $() }
        }
        'p2' {
            $filter = { $_.Action -ne 'AcceptMessage' -and $_.P2FromAddresses -ne $() }
        }
    }

    $PassedParameters = $PSBoundParameters
    $null = $PassedParameters.Remove('Report')
    $null = $PassedParameters.Remove('Top')

    Get-AgentLog @PassedParameters |
        Where-Object $filter |
        get-SenderAddress -SenderFrom $Report |
        get-TopN -top $top
}
