function Get-WinBGPRoute() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Get WinBGP Route
        .DESCRIPTION
            This function retrieve WinBGP Routes
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .EXAMPLE
            Get-WinBGPRoute -ComputerName machine1,machine2
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local'
    )

    Invoke-PSWinBGP -ComputerName $ComputerName -Call 'routes'
}
