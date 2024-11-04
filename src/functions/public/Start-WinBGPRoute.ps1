function Start-WinBGPRoute() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Start Route
        .DESCRIPTION
            This function perform Start Route
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER RouteName
            RouteName (Currently supporting only one route, IntelliSense availalble)
        .EXAMPLE
            Start-WinBGPRoute -ComputerName machine1,machine2 -RouteName route1.contoso.com
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true)]
        [String]$RouteName
    )
    # If action is confirmed
    if ($pscmdlet.ShouldProcess($RouteName, 'Start route')) {
        Invoke-PSWinBGP -ComputerName $ComputerName -call 'startroute' -RouteName $RouteName
    }
}
