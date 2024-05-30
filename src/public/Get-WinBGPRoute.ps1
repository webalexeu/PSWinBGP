function Get-WinBGPRoute() {
    <#
        .SYNOPSIS
            Get WinBGP Route
        .DESCRIPTION
            This function retrieve WinBGP Routes
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .EXAMPLE
            Get-WinBGPRoute -ComputerName machine1,machine2
    #>

    Param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local'
    )

    Invoke-PSWinBGP -ComputerName $ComputerName -Call 'routes'
}
