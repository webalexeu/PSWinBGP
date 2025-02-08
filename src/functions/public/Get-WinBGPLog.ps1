function Get-WinBGPLog() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Get WinBGP Log
        .DESCRIPTION
            This function retrieve WinBGP Logs
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER Last
            Number of last logs to retrieve (Default: 10)
        .EXAMPLE
            Get-WinBGPLog -ComputerName machine1,machine2
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String[]]$ComputerName = 'local'
    )
    process {
        Invoke-PSWinBGP -ComputerName $ComputerName -Call 'logs'

    }
}
