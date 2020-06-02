function Get-AntispamTopRblPovider {
    <#
        .EXTERNALHELP get-AntispamReport-help.xml
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
