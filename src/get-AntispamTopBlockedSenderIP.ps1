function Get-AntispamTopBlockedSenderIP {
    <#
        .SYNOPSIS
        Gets the top N blocked message senders by IP.

        .DESCRIPTION
        This cmdlet scans antispam agent logs for messages not accepted and reports back top N sender server IPs.

        You must connect to Exchange server, before you can use cmdlet.  If you use Exchange Management Shell,
        you are already connected, otherwise you should run Connect-ExchangeServer cmdlet first, to establish connection.

        .PARAMETER Top
        Display only top N RBL providers.  By default top 10 are displayed.

        .PARAMETER Location
        Location of agent log files.  By default Hub transport agent log files are used.

        .PARAMETER TransportService
        Specify transport service, which agent logs should be used.  Default value is Hub

        .PARAMETER StartDate
        Beginning time period to look for in the agent log files. If not specified, look at all the logs till the endDate.

        .PARAMETER EndDate
        End time period to look for in the agent log files. If not specified, look at all the logs beginning from startDate.

        .EXAMPLE
        Get-AntispamTopBlockedSenderIP -Top 5

        Returns top 5 IP addresses that sent messages blocked by antispam agents.

        .EXAMPLE
        Get-AntispamTopBlockedSenderIP -TransportService FrontEnd

        Returns top 10 IP addresses blocked.  Use FrontEnd transport agent logs.

        .EXAMPLE
        Get-AntispamTopBlockedSenderIP -StartDate (Get-Date).AddDays(-14)

        Get top 10 IP addresses blocked.  Look only for last 2 weeks of logs.

        .NOTES
        This cmdlet was originally a script included in Exchange Server media.

        .LINK
        https://technet.microsoft.com/en-us/library/aa996044
        Get-AgentLog
        Connect-ExchangeServer
    #>

    [CmdLetBinding()]
    Param(
            [int]
        $Top = 10
        ,
            [ValidateSet('Hub', 'FrontEnd', 'Edge', 'MailboxSubmission', 'MailboxDelivery')]
            [string]
        $TransportService #= 'Hub'
        ,
            [string]
        $Location #= $null
        ,
            [datetime]
        $StartDate #= [datetime]::MinValue
        ,
            [datetime]
        $EndDate #= [datetime]::MaxValue        
    )

    $PassedParameters = $PSBoundParameters
    $null = $PassedParameters.Remove('top')

    Get-AgentLog @PassedParameters |
        Where-Object { $_.Action -ne "AcceptMessage" -and $_.IPAddress -ne $() } | 
        Select-Object -ExpandProperty IPAddress |
        get-TopN -top $top
}
