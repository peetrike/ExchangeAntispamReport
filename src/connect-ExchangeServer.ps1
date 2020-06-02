#Requires -Modules NetTCPIP
function Connect-ExchangeServer {
    # .EXTERNALHELP get-AntispamReport-help.xml

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
