function Stop-WinBGPRoute() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Stop Route
        .DESCRIPTION
            This function perform Stop Route
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER RouteName
            RouteName (Currently supporting only one route, IntelliSense availalble)
        .EXAMPLE
            Stop-WinBGPRoute -ComputerName machine1,machine2 -RouteName route1.contoso.com
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $false)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true)]
        [String]$RouteName
    )
    if ($pscmdlet.ShouldProcess($RouteName, 'Stop route')) {
        Invoke-PSWinBGP -ComputerName $ComputerName -call 'stoproute' -routename $RouteName
    }
}
