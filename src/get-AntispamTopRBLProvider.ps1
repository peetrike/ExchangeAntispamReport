function Get-AntispamTopRblPovider {
    <#
        .SYNOPSIS
        Gets the top N RBL providers that were used to block spam.

        .DESCRIPTION
        This cmdlet scans antispam agent logs for messages not accepted and reports back top N RBL providers.

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
        Get-AntispamTopRblPovider -Top 5

        Returns top 5 RBL providers used to reject connections.

        .EXAMPLE
        Get-AntispamTopRblPovider -TransportService Edge

        Returns top 10 RBL providers used to reject connections.  Use Edge transport agent logs.

        .EXAMPLE
        Get-AntispamTopRblPovider -StartDate (Get-Date).AddDays(-14)

        Get top 10 RBL providers used to reject connections.  Look only for last 2 weeks of logs.

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
        $TransportService #= 'FrontEnd'
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

#    Write-Verbose -Message "Get-AntispamTopRblPovider: Using $TransportService transport service for log files"
    
    Get-AgentLog @PassedParameters |
        Where-Object {$_.Reason -eq 'BlockListProvider'} |
        Select-Object -ExpandProperty ReasonData |
        Get-TopN -top $Top
}
