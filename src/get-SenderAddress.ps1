function Get-SenderAddress {
    # .EXTERNALHELP get-AntispamReport-help.xml
    param(
            [parameter(
                ValueFromPipeLine=$true
            )]
            [PSObject]
        $InputObject,
            [parameter(Mandatory=$true)]
            [ValidateSet('p1','p2')]
            [string]
        $SenderFrom
    )

    Process {
        switch ($SenderFrom) {
            'p1' {
                $InputObject.P1FromAddress |
                    Where-Object { $_ -match '.+@.+\..+' }
            }
            'p2' {
                $InputObject.P2FromAddresses |
                    Where-Object { $_ -match '.+@.+\..+' } |
                    Select-Object -Unique
            }
        } # switch
    }
}
