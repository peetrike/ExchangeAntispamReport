function Get-SenderDomain {
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
                $InputObject.P1FromAddress.split('@')[1]
            }
            'p2' {
                $InputObject.P2FromAddresses |
                    ForEach-Object {
                        $_.split('@')[1]
                    } |
                    Select-Object -Unique
            }
        }
    }
}
