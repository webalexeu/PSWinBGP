# Dot source public/private functions
$public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
foreach ($import in @($public + $private)) {
    try {
        . $import.FullName
    } catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename

# Route Argument Completer
$ArgumentCompleterBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    # Dynamically generate routes array
    if ($FakeBoundParameters.ComputerName) {
        [Array] $routes = (Get-WinBGPRoute -ComputerName $FakeBoundParameters.ComputerName)
    } else {
        [Array] $routes = (Get-WinBGPRoute)
    }
    # Return routes as arguments (Intellisense)
    $routes | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList $_.Name,
            #"$($_.ComputerName)_$($_.Name)",
            "$(if ($_.ComputerName){"ComputerName: '$($_.ComputerName)' - RouteName: '$($_.Name)'"}else{$_.Name})",
            "ParameterValue",
            "$(if ($_.ComputerName){"ComputerName: '$($_.ComputerName)' - "})Network: '$($_.Network)' - Status: '$($_.Status)'"
    }
}
Register-ArgumentCompleter -CommandName Start-WinBGPRoute,Stop-WinBGPRoute,Start-WinBGPRouteMaintenance,Stop-WinBGPRouteMaintenance -ParameterName RouteName -ScriptBlock $ArgumentCompleterBlock

# Declare a module-level variable
$PSWinBGP = [ordered]@{
    LocalhostApiPort     = 8888
    LocalhostApiProtocol = 'http'
    LocalhostApiTimeout  = 5
    ApiPort              = 8888
    ApiProtocol          = 'https'
    ApiTimeout           = 10
}
New-Variable -Name PSWinBGP -Value $PSWinBGP -Scope Script -Force

