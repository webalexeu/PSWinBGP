function Set-PSWinBGPConfig {
    <#
    .SYNOPSIS
        Set PSWinBBGP module configuration.

    .DESCRIPTION
        Set PSWinBBGP module configuration, and $PSWinBBGP module variable.

    .PARAMETER ApiAuthenticationMethod
        API Authentication Method (Default: IntegratedWindowsAuthentication)

    .PARAMETER ApiPort
        API Port (Default: 8888)

    .PARAMETER ApiProtocol
        API Protocol (Default: HTTPS)

    .PARAMETER ApiTimeout
        API Timeout (Default: 10s)

    .PARAMETER LocalhostApiAuthenticationMethod
        Localhost API Authentication Method (Default: Anonymous)

    .PARAMETER LocalhostApiPort
        Localhost API Port (Default: 8888)

    .PARAMETER LocalhostApiProtocol
        Localhost API Protocol (Default: HTTP)

    .PARAMETER LocalhostApiTimeout
        Localhost API Timeout (Default: 5s)
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [string]$ApiAuthenticationMethod,
        [Int]$ApiPort,
        [string]$ApiProtocol,
        [Int]$ApiTimeout,
        [string]$LocalhostApiAuthenticationMethod,
        [Int]$LocalhostApiPort,
        [string]$LocalhostApiProtocol,
        [Int]$LocalhostApiTimeout
    )

    if ($pscmdlet.ShouldProcess('$Script:PSWinBGP', 'Set config')) {
        switch ($PSBoundParameters.Keys) {
            'ApiAuthenticationMethod' { $Script:PSWinBGP.ApiAuthenticationMethod = $ApiAuthenticationMethod }
            'ApiPort' { $Script:PSWinBGP.ApiPort = $ApiPort }
            'ApiProtocol' { $Script:PSWinBGP.ApiProtocol = $ApiProtocol }
            'ApiTimeout' { $Script:PSWinBGP.ApiTimeout = $ApiTimeout }
            'LocalhostApiAuthenticationMethod' { $Script:PSWinBGP.LocalhostApiAuthenticationMethod = $LocalhostApiAuthenticationMethod }
            'LocalhostApiPort' { $Script:PSWinBGP.LocalhostApiPort = $LocalhostApiPort }
            'LocalhostApiProtocol' { $Script:PSWinBGP.LocalhostApiProtocol = $LocalhostApiProtocol }
            'LocalhostApiTimeout' { $Script:PSWinBGP.LocalhostApiTimeout = $LocalhostApiTimeout }
        }
    }
}
