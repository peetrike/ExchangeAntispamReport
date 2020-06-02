function Get-AntispamTopRecipient {
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
