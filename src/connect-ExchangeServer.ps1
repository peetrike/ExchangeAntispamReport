#Requires -Modules NetTCPIP
function Connect-ExchangeServer {
    <#
            .SYNOPSIS
            Connects to remote Exchange server and imports management cmdlets.

            .DESCRIPTION
            This cmdlet establishes Powershell remoting session to Exchange server and imports all Exchange management cmdlets that are
            allowed to use by RBAC.

            You must connect to Exchange server, before you can use other antispam report cmdlets.  If you use Exchange Management Shell,
            you are already connected.

            .PARAMETER ComputerName
            Exchange Server computer name to be connected.

            .PARAMETER Credential
            User credential that will be used to connect.  By default locally logged on user will be used.
            If only username is provided, the credential prompt is provided.

            .PARAMETER PassThru
            Pass Exchange Server connection into user environment

            .EXAMPLE
            Connect-ExchangeServer -ComputerName myexchange
        
            Connects to exchange server named myexchange by using default credentials

            .EXAMPLE
            Connect-ExchangeServer -ComputerName myexchange -Credential 'domain\user'

            Connects to Exchange server by using provided username.  The authentication prompt requests a password for the user name.

            .NOTES


            .LINK
            https://technet.microsoft.com/en-us/library/dd335083
    #>

    [CmdLetBinding()]
    [OutputType([Management.Automation.Runspaces.PSSession])]
    Param(
            [parameter(
                Mandatory,
                HelpMessage='Exchange Server computer name'
            )]
            [string]
        $ComputerName,
            [System.Management.Automation.Credential()]
            [PSCredential]
        $Credential,
            [Switch]
        $PassThru
    )
    
    $ConfigurationName = 'Microsoft.Exchange'
    $ConnectionUri = "http://$ComputerName/PowerShell/"

    $session = Get-PSSession -Name $ConnectionUri -ErrorAction SilentlyContinue

    if ($session) {
        Write-Verbose -Message 'Connection already established'
        if ($PassThru) {
            return $session
        } else {
            return
        }
    } else {
        $result = Test-NetConnection -ComputerName $ComputerName -CommonTCPPort WINRM -ErrorAction Stop

        if ($result.TcpTestSucceeded) {
            $sessionParams= @{
                ConfigurationName = $ConfigurationName
                ConnectionUri = $ConnectionUri
                Authentication = 'Kerberos'
                Name = $ConnectionUri
            }

            if ($PSBoundParameters.ContainsKey('Credential')) {
                $sessionParams.Add('Credential',$Credential)
            }

            $session = New-PSSession @sessionParams
            $null = Import-PSSession -Session $session -CommandName Get-AgentLog
        
            if ($PassThru) {
                Get-PSSession -Name $ConnectionUri 
            }
        } else {
            Write-Error -Message "Cannot connect to server: $ComputerName"
        }
    }     
}
