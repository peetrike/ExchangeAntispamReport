function Get-TopN {
    Param(
            [parameter(
                ValueFromPipeLine=$true
            )]
            [string]
        $InputObject
        ,
            [int]
        $Top = 10
    )

    Begin {
        $h = @{}
    }

    Process {
        $h[$InputObject]++
    }

    End {
        $h.GetEnumerator() |
            Sort-Object -Property Value -Descending |
            Select-Object -First $top
    }
}

#for testing only

<#
'neli', 'yks', 'kaks', 'yks', 'kolm', 'yks', 'kaks', 'yks' |
    get-topN -top 2
#>

<#
function Get-TopNOld {
    Param(
            [parameter(
                Mandatory=$true,
                Position=0
            )]
            [hashtable]
        $InputObject,
            [int]
        $top = 10
    )

#    $arr = New-Object  object[] $InputObject.keys.count 
#    $InputObject.CopyTo($arr,0)
#    $arr | 
    $InputObject.GetEnumerator() |
#        Select-Object -Property Name, Value |
        Sort-Object -Property Value -Descending |
        Select-Object -First $top

}

$h = @{}
'neli', 'yks', 'kaks', 'yks', 'kolm', 'yks', 'kaks', 'yks' |
    ForEach-Object { $h[$_]++ }

Get-TopNOld -InputObject $h -top 2
#>