function Stop-WinBGPRouteMaintenance() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Route
        .DESCRIPTION
            WinBGP Remote Management
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .EXAMPLE
            Get-WinBGPRoute -ComputerName machine1,machine2
            # Get WinBGP route
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true)]
        [String]$RouteName
    )
    if ($pscmdlet.ShouldProcess($RouteName, 'Stop route maintenance')) {
        Invoke-PSWinBGP -ComputerName $ComputerName -call 'stopmaintenance' -routename $RouteName
    }
}
