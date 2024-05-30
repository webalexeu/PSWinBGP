function Set-PSWinBGPConfig {
    <#
    .SYNOPSIS
        Set PSWinBBGP module configuration.

    .DESCRIPTION
        Set PSWinBBGP module configuration, and $PSWinBBGP module variable.

    .PARAMETER ApiPort
        Api Port (Default: 8888)

    .PARAMETER ApiProtocol
        Api Protocol (Default: https)

    .PARAMETER ApiTimeout
        Api Timeout (Default: 10s)

    .PARAMETER LocalhostApiPort
        Localhost Api Port (Default: 8888)

    .PARAMETER LocalhostApiProtocol
        Localhost Api Protocol (Default: http)

    .PARAMETER LocalhostApiTimeout
        Localhost Api Timeout (Default: 5s)

    #>
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Int]$ApiPort,
        [string]$ApiProtocol,
        [Int]$ApiTimeout,
        [Int]$LocalhostApiPort,
        [string]$LocalhostApiProtocol,
        [Int]$LocalhostApiTimeout
    )

    if ($pscmdlet.ShouldProcess('$Script:PSWinBGP','Set config')) {
        Switch ($PSBoundParameters.Keys)
        {
            'ApiPort'               { $Script:PSWinBGP.ApiPort = $ApiPort }
            'ApiProtocol'           { $Script:PSWinBGP.ApiProtocol = $ApiProtocol }
            'ApiTimeout'            { $Script:PSWinBGP.ApiTimeout = $ApiTimeout }
            'LocalhostApiPort'      { $Script:PSWinBGP.LocalhostApiPort = $LocalhostApiPort }
            'LocalhostApiProtocol'  { $Script:PSWinBGP.LocalhostApiProtocol = $LocalhostApiProtocol }
            'LocalhostApiTimeout'   { $Script:PSWinBGP.LocalhostApiTimeout = $LocalhostApiTimeout }
        }
    }
}
