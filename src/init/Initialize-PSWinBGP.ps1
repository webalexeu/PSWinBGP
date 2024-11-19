# Initializing PSWinBGP (Command completer is used by some public functions)
Register-ArgumentCompleter `
    -CommandName Start-WinBGPRoute, Stop-WinBGPRoute, Start-WinBGPRouteMaintenance, Stop-WinBGPRouteMaintenance `
    -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    # Define paramaters to $null to avoid syntax errors
    $null = $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters

    # Dynamically generate routes array
    if ($FakeBoundParameters.ComputerName) {
        [Array] $routes = (Get-WinBGPRoute -ComputerName $FakeBoundParameters.ComputerName)
    }
    else {
        [Array] $routes = (Get-WinBGPRoute)
    }
    # Return routes as arguments (IntelliSense)
    $routes | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList `
            $_.Name, `
            "$(if ($_.ComputerName){"ComputerName: '$($_.ComputerName)' - RouteName: '$($_.Name)'"}else{$_.Name})", `
            "ParameterValue", `
            "$(if ($_.ComputerName){"ComputerName: '$($_.ComputerName)' - "})Network: '$($_.Network)' - Status: '$($_.Status)'"
    }
}
