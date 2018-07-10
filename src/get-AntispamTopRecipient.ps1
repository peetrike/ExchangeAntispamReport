function Get-AntispamTopRecipient {
    <#
        .SYNOPSIS
        Gets the top N recipient e-mail addresses from blocked messages.

        .DESCRIPTION
        This cmdlet scans antispam agent logs for messages not accepted and reports back top N recipients.

        You must connect to Exchange server, before you can use cmdlet.  If you use Exchange Management Shell,
        you are already connected, otherwise you should run Connect-ExchangeServer cmdlet first, to establish connection.

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
        Get-AntispamTopRecipient -Top 5

        Get top 5 blocked e-mail recipients blocked by antispam agents on hub tranport service.

        .EXAMPLE
        Get-AntispamTopRecipient -TransportService FrontEnd

        Get top 10 blocked e-mail recipients from FrontEnd transport service.

        .EXAMPLE
        Get-AntispamTopRecipient -StartDate (Get-Date).AddDays(-14)

        Get top 10 blocked e-mail recipients blocked by antispam agents on hub tranport service.  Look only for last 2 weeks of logs.

        .NOTES
        This cmdlet was originally a script included in Exchange Server media.

        .LINK
        https://technet.microsoft.com/en-us/library/aa996044
        Get-AgentLog
        Connect-ExchangeServer
    #>

    [CmdLetBinding()]
    param (
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
    $null = $PassedParameters.Remove('top')

    ## Get all recipients, then group and sort them

    Get-AgentLog @PassedParameters |
        Where-Object { $_.Action -ne 'AcceptMessage' } |
        Select-Object -ExpandProperty Recipients |
        Where-Object { $_ -match '.+@.+\..+' } | 
        Get-TopN -Top $Top
}
