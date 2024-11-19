function Start-WinBGPRoute() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Start Route
        .DESCRIPTION
            This function perform Start Route
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER Name
            Name (Currently supporting only one route, IntelliSense availalble)
        .EXAMPLE
            Start-WinBGPRoute -ComputerName machine1,machine2 -Name route1.contoso.com
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('RouteName')]
        [String[]]$Name
    )
    Process {
        # Parsing all routes provided
        foreach ($Route in $Name) {
            # If action is confirmed
            if ($PSCmdlet.ShouldProcess("$($Route)$(if ($ComputerName -ne 'local'){" [ComputerName: $($ComputerName)]"})", 'Start WinBGP route')) {
                Invoke-PSWinBGP -ComputerName $ComputerName -call 'startroute' -RouteName $Route
            }
        }
    }
}
