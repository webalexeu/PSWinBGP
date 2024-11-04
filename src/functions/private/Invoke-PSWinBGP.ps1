function Invoke-PSWinBGP() {
    <#
        .SYNOPSIS
            Inkoke WinBGP
        .DESCRIPTION
            Inkoke WinBGP using local method or API
        .PARAMETER ComputerName
            Single or multiple ComputerName (Default: localhost)
        .EXAMPLE
            Invoke-PSWinBGP -ComputerName machine1,machine2 -Call routes
            # Get WinBGP status (Display WinBGP routes status)
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [String[]]$ComputerName,
        [Parameter(ParameterSetName = 'call', Mandatory = $true)]
        [String]$Call, # Call to perform
        [Parameter(Mandatory = $false)]
        [String]$RouteName     # Select route to control
    )

    if ($ComputerName -eq 'local') {
        switch ($call) {
            'routes' { Invoke-Command { WinBGP } }
            'startroute' { Send-WinBGPRouteControl -RouteName $RouteName -Control 'start' }
            'stoproute' { Send-WinBGPRouteControl -RouteName $RouteName -Control 'stop' }
            'startmaintenance' { Send-WinBGPRouteControl -RouteName $RouteName -Control 'start' -Action 'maintenance' }
            'stopmaintenance' { Send-WinBGPRouteControl -RouteName $RouteName -Control 'stop' -Action 'maintenance' }
        }
    } else {
        if ($ComputerName -eq 'localhost') {
            [Int]$Port = $Script:PSWinBGP.LocalhostApiPort
            [String]$Protocol = $Script:PSWinBGP.LocalhostApiProtocol
            [Int]$Timeout = $Script:PSWinBGP.LocalhostApiTimeout
            [String]$AuthenticationMethod = $Script:PSWinBGP.LocalhostAuthenticationMethod
        } else {
            [Int]$Port = $Script:PSWinBGP.ApiPort
            [String]$Protocol = $Script:PSWinBGP.ApiProtocol
            [Int]$Timeout = $Script:PSWinBGP.ApiTimeout
            [String]$AuthenticationMethod = $Script:PSWinBGP.AuthenticationMethod
        }

        # Initialize output variable
        $Output = @()
        $ErrorOutput = @()
        # Initialize error variable
        $ErrorCount = 0

        foreach ($Computer in $ComputerName) {
            # Initialize output variable
            $ApiOutput = [PSCustomObject]@{}
            $ErrorOut = [PSCustomObject]@{}
            $ApiDefaultRequestURL = "$($Protocol)://$($Computer):$($Port)/api"
            $params = @{}
            $params.add('UseBasicParsing', $true)
            $params.add('TimeoutSec', $Timeout)
            $params.add('ContentType', 'application/json')
            # Only authentication method managed currently is 'Negotiate' (To be improved)
            if (($AuthenticationMethod -eq 'IntegratedWindowsAuthentication') -or ($AuthenticationMethod -eq 'Negotiate')) {
                $params.add('UseDefaultCredentials', $true)
            }

            # Get
            if ($call -eq 'routes') {
                $ApiRequestURL = "$ApiDefaultRequestURL/routes"
            }
            # Post
            if (($call -eq 'startmaintenance') -or ($call -eq 'stopmaintenance') -or ($call -eq 'startroute') -or ($call -eq 'stoproute')) {
                $ApiRequestMethod = 'Post'
                if ($call -eq 'startmaintenance') {
                    $ApiRequestURL = "$ApiDefaultRequestURL/startmaintenance?routename=$RouteName"
                }
                if ($call -eq 'stopmaintenance') {
                    $ApiRequestURL = "$ApiDefaultRequestURL/stopmaintenance?routename=$RouteName"
                }
                if ($call -eq 'startroute') {
                    $ApiRequestURL = "$ApiDefaultRequestURL/startroute?routename=$RouteName"
                }
                if ($call -eq 'stoproute') {
                    $ApiRequestURL = "$ApiDefaultRequestURL/stoproute?routename=$RouteName"
                }
            }
            # Test if target is reachable
            if ($PSVersionTable.PSVersion.Major -ge 7) {
                $ConnectivityTest = (Test-Connection -TcpPort $Port -TimeoutSeconds $Timeout -TargetName $Computer -Quiet)
                $params.add('SkipHttpErrorCheck', $true)
                $params.add('StatusCodeVariable', 'StatusCode')
            } else {
                if ($ComputerName -eq 'localhost') {
                    # Bypass connectivity test when localhost (For speed performance)
                    $ConnectivityTest = $true
                } else {
                    $ConnectivityTest = (Test-NetConnection -ComputerName $computer -Port $port).TcpTestSucceeded
                }
            }
            if ($ConnectivityTest) {
                $params.add('uri', $ApiRequestURL)
                if ($ApiRequestMethod) {
                    $params.add('Method', $ApiRequestMethod)
                }
                # Perform Rest API Call
                if ($PSVersionTable.PSVersion.Major -ge 7) {
                    $RestApiCall = Invoke-RestMethod @params
                } else {
                    # Try/catch because PS5 don't support status code and skip http error check
                    try {
                        $RestApiCall = Invoke-RestMethod @params
                    } catch {
                        $ErrorOut | Add-member -MemberType NoteProperty -Name 'Result' -Value "API call error: $($_)"
                        $ErrorCount++
                    }
                }

                if ($RestApiCall) {
                    $ApiOutput = $RestApiCall
                    $ErrorOut | Add-member -MemberType NoteProperty -Name 'Result' -Value 'API connection OK'
                } else {
                    if ($StatusCode) {
                        $Value = "API return code: $([System.Net.HttpStatusCode]$StatusCode) ($StatusCode)"
                        $ErrorOut | Add-Member -MemberType NoteProperty -Name 'Result' -Value $Value
                        $ErrorCount++
                    } else {
                        if ($PSVersionTable.PSVersion.Major -ge 7) {
                            $ErrorOut | Add-member -MemberType NoteProperty -Name 'Result' -Value 'API call timeout'
                            $ErrorCount++
                        }
                    }
                }
            } else {
                $ErrorOut | Add-member -MemberType NoteProperty -Name 'Result' -Value 'API connection timeout'
                $ErrorCount++
            }
            # Add ComputerName variable to output (except for localhost)
            if ($Computer -ne 'localhost') {
                $ApiOutput | Add-member -MemberType NoteProperty -Name 'ComputerName' -Value "$Computer"
            }
            $Output += $ApiOutput
            # Add ComputerName variable to output (except for localhost)
            if ($Computer -ne 'localhost') {
                $ErrorOut | Add-member -MemberType NoteProperty -Name 'ComputerName' -Value "$Computer"
            }
            $ErrorOutput += $ErrorOut
        }

        # If there is connection error, just return connection table
        if ($ErrorCount -eq 0) {
            # Return result
            return [PSCustomObject]$Output
        } else {
            return [PSCustomObject]$ErrorOutput
        }
    }
}
