function Set-PSWinBGPConfig {
    <#
    .SYNOPSIS
        Set PSWinBBGP module configuration.

    .DESCRIPTION
        Set PSWinBBGP module configuration, and $PSWinBBGP module variable.

    .PARAMETER ApiPort
        API Port (Default: 8888)

    .PARAMETER ApiProtocol
        API Protocol (Default: HTTPS)

    .PARAMETER ApiTimeout
        API Timeout (Default: 10s)

    .PARAMETER LocalhostApiPort
        Localhost API Port (Default: 8888)

    .PARAMETER LocalhostApiProtocol
        Localhost API Protocol (Default: HTTP)

    .PARAMETER LocalhostApiTimeout
        Localhost API Timeout (Default: 5s)
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Int]$ApiPort,
        [string]$ApiProtocol,
        [Int]$ApiTimeout,
        [Int]$LocalhostApiPort,
        [string]$LocalhostApiProtocol,
        [Int]$LocalhostApiTimeout
    )

    if ($pscmdlet.ShouldProcess('$Script:PSWinBGP', 'Set config')) {
        switch ($PSBoundParameters.Keys) {
            'ApiPort' { $Script:PSWinBGP.ApiPort = $ApiPort }
            'ApiProtocol' { $Script:PSWinBGP.ApiProtocol = $ApiProtocol }
            'ApiTimeout' { $Script:PSWinBGP.ApiTimeout = $ApiTimeout }
            'LocalhostApiPort' { $Script:PSWinBGP.LocalhostApiPort = $LocalhostApiPort }
            'LocalhostApiProtocol' { $Script:PSWinBGP.LocalhostApiProtocol = $LocalhostApiProtocol }
            'LocalhostApiTimeout' { $Script:PSWinBGP.LocalhostApiTimeout = $LocalhostApiTimeout }
        }
    }
}
