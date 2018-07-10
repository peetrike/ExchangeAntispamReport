function Get-AntispamReport {
    <#
        .EXTERNALHELP get-AntispamReport-help.xml
    #>
    
    # Copyright (c) Microsoft Corporation. All rights reserved.  
    # Modified by Peter Wawa

    [CmdLetBinding()]
    param (
            [parameter( Mandatory = $true, Position=0 )]
            [ValidateSet('connections', 'commands', 'messagesrejected', 'messagesdeleted', 'messagesquarantined')]
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
        $Location
        ,
            [datetime]
        $StartDate
        ,
            [datetime]
        $EndDate
    )
    
    
    ## Get the log entries based on action, sort by agent, and output
    
    $filter = {}
    switch ($Report) {
        'commands' {
            $filter = {$_.Action -eq 'RejectCommand' }
        }
        
        'connections' {
            $filter = {$_.Action -eq 'Disconnect' -or $_.Action -eq 'RejectConnection' }
        }
        
        'messagesdeleted' {
            $filter = {$_.Action -eq 'DeleteMessage' -or $_.Action -eq 'DeleteRecipients' }
        }
        
        'messagesquarantined' {
            $filter = {$_.Action -eq 'QuarantineRecipients' -or $_.Action -eq 'QuarantineMessage' }
        }
        
        'messagesrejected' {
            $filter = {$_.Action -eq 'RejectMessage' -or $_.Action -eq 'RejectRecipients' }
        }
    }
 
    $PassedParameters = $PSBoundParameters
    $null = $PassedParameters.Remove('Report')
    $null = $PassedParameters.Remove('Top')
    
    Get-AgentLog @PassedParameters |
        Where-Object $filter |
        Select-Object -ExpandProperty Agent |
        Get-TopN -top $Top
}
