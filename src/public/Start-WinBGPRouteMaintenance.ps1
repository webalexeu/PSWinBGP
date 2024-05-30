function Start-WinBGPRouteMaintenance() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Start Route Maintenance
        .DESCRIPTION
            This function perform Start Route Maintenance
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER RouteName
            RouteName (Currently supporting only one route, IntelliSense availalble)
        .EXAMPLE
            Start-WinBGPRouteMaintenance -ComputerName machine1,machine2 -RouteName route1.contoso.com
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true)]
        [String]$RouteName
    )

    if ($pscmdlet.ShouldProcess($RouteName, 'Start route maintenance')) {
        Invoke-PSWinBGP -ComputerName $ComputerName -call 'startmaintenance' -routename $RouteName
    }
}
