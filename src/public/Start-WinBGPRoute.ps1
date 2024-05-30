function Start-WinBGPRoute() {
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

    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='Medium')]
    Param(
        [Parameter(Mandatory=$false)]
        [String[]]$ComputerName='local',
        [Parameter(Mandatory=$true)]
        [String]$RouteName
    )
    # If action is confirmed
    if ($pscmdlet.ShouldProcess($RouteName,'Start route')) {
        Invoke-PSWinBGP -ComputerName $ComputerName -call 'startroute' -RouteName $RouteName
    }
}
