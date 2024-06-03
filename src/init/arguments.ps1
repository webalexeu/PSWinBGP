# Route Argument Completer
$ArgumentCompleterBlock = {
    param(
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )

    # Dynamically generate routes array
    if ($FakeBoundParameters.ComputerName) {
        [Array] $routes = (Get-WinBGPRoute -ComputerName $FakeBoundParameters.ComputerName)
    } else {
        [Array] $routes = (Get-WinBGPRoute)
    }
    # Return routes as arguments (IntelliSense)
    $routes | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList
        $_.Name,
        #"$($_.ComputerName)_$($_.Name)",
        "$(if ($_.ComputerName){"ComputerName: '$($_.ComputerName)' - RouteName: '$($_.Name)'"}else{$_.Name})",
        "ParameterValue",
        "$(if ($_.ComputerName){"ComputerName: '$($_.ComputerName)' - "})Network: '$($_.Network)' - Status: '$($_.Status)'"
    }
    # To review (to avoid syntax error)
    $null = $commandName
    $null = $parameterName
    $null = $wordToComplete
    $null = $commandAst
}
Register-ArgumentCompleter `
    -CommandName Start-WinBGPRoute, Stop-WinBGPRoute, Start-WinBGPRouteMaintenance, Stop-WinBGPRouteMaintenance `
    -ParameterName RouteName `
    -ScriptBlock $ArgumentCompleterBlock
