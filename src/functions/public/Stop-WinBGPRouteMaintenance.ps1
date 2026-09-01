function Stop-WinBGPRouteMaintenance() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Stop Route Maintenance
        .DESCRIPTION
            This function perform Stop Route Maintenance
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER Name
            Single or multiple Route Name (IntelliSense available)
        .EXAMPLE
            Stop-WinBGPRouteMaintenance -ComputerName machine1,machine2 -Name route1.contoso.com
        .LINK
            https://psmodule.io/PSWinBGP/Functions/Stop-WinBGPRouteMaintenance/
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('RouteName')]
        [String[]]$Name
    )
    process {
        # Parsing all routes provided
        foreach ($Route in $Name) {
            # If action is confirmed
            if (
                $PSCmdlet.ShouldProcess(
                    "$($Route)$(
                        if ($ComputerName -ne 'local') {
                            " [ComputerName: $($ComputerName)]"
                        }
                    )",
                    'Stop WinBGP route maintenance'
                )
            ) {
                Invoke-PSWinBGP -ComputerName $ComputerName -call 'stopmaintenance' -RouteName $Route
            }
        }
    }
}
