function Get-WinBGPRoute() {
    <#
        .SYNOPSIS
            WinBGP Remote Management - Get WinBGP Route
        .DESCRIPTION
            This function retrieve WinBGP Routes
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .PARAMETER Name
            Single or multiple Route Name
        .EXAMPLE
            Get-WinBGPRoute -ComputerName machine1,machine2
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String[]]$ComputerName = 'local',
        [Parameter(Mandatory = $false)]
        [Alias('RouteName')]
        [String[]]$Name
    )
    Process {
        $Routes = Invoke-PSWinBGP -ComputerName $ComputerName -Call 'routes'
        # Filter if Name is provided
        if ($Name) {
            $Routes | Where-Object { $_.Name -in $Name }
        } else {
            $Routes
        }
    }
}
