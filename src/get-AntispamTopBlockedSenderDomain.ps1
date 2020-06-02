function Get-AntispamTopBlockedSenderDomain {
    <#
        .EXTERNALHELP get-AntispamReport-help.xml
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
