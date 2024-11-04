function Stop-WinBGPRouteMaintenance() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Stop Route Maintenance
        .DESCRIPTION
            This function perform Stop Route Maintenance
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER RouteName
            RouteName (Currently supporting only one route, IntelliSense availalble)
        .EXAMPLE
            Stop-WinBGPRouteMaintenance -ComputerName machine1,machine2 -RouteName route1.contoso.com
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true)]
        [String]$RouteName
    )
    if ($pscmdlet.ShouldProcess($RouteName, 'Stop route maintenance')) {
        Invoke-PSWinBGP -ComputerName $ComputerName -call 'stopmaintenance' -routename $RouteName
    }
}
