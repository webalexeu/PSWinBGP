# Dot source init/public/private functions
$init = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Init/*.ps1') -Recurse -ErrorAction Stop)
$public = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1') -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
foreach ($import in @($init + $public + $private)) {
    try {
        . $import.FullName
    } catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename

# Declare a module-level variable (TO REVIEW, it's now part of data folder)
$PSWinBGP = [ordered]@{
    LocalhostApiPort     = 8888
    LocalhostApiProtocol = 'http'
    LocalhostApiTimeout  = 5
    ApiPort              = 8888
    ApiProtocol          = 'https'
    ApiTimeout           = 10
}
New-Variable -Name PSWinBGP -Value $PSWinBGP -Scope Script -Force

