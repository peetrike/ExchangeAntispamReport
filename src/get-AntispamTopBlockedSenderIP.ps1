function Get-AntispamTopBlockedSenderIP {
    <#
        .EXTERNALHELP get-AntispamReport-help.xml
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
