function Send-WinBGPRouteControl() {
    <#
        .SYNOPSIS
            Send-WinBGPRouteControl
        .DESCRIPTION
            Send-WinBGPRouteControl
        .PARAMETER RouteName
            RouteName
        .PARAMETER Control
            Control
        .PARAMETER Action
            Action
        .EXAMPLE
            Send-WinBGPRouteControl -RouteName $RouteName -Control 'start' -Action 'maintenance'
    #>
    param (
        [Parameter(Mandatory = $false)]
        [String]$Action = 'route',
        [Parameter(Mandatory = $true)]
        [String]$RouteName,
        [Parameter(Mandatory = $true)]
        [String]$Control
    )
    $PipeStatus = $null
    # Performing Action
    try {
        # Temporary
        $pipeName = 'Service_WinBGP'
        $Message = "$($Action) $($RouteName) $($Control)"
        Send-WinBGPPipeMessage -PipeName $pipeName -Message $Message
    } catch {
        $PipeStatus = ($_).ToString()
    }
    if ($PipeStatus -like "*Pipe hasn't been connected yet*") {
        return "WinBGP not ready"
    } else {
        # TO BE IMPROVED to get status
        return "Success"
    }
}
