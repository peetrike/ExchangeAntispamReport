function Get-AntispamTopBlockedSender {
    # .EXTERNALHELP get-AntispamReport-help.xml

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
