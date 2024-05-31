#
# Module manifest for module 'PSWinBGP'
#

@{
    # Script module or binary module file associated with this manifest.
    RootModule           = 'PSWinBGP.psm1'

    # Version number of this module.
    ModuleVersion        = '1.0.0'

    # Supported PSEditions
    CompatiblePSEditions = @(
        'PSEdition_Desktop',
        'PSEdition_Core',
        'Windows',
        'Linux',
        'MacOS'
    )

    # ID used to uniquely identify this module
    GUID                 = 'a7c4be44-95a4-45d3-bcb3-c9f3deb1d7d4'

    # Author of this module
    Author               = 'Alexandre JARDON'

    # Company or vendor of this module
    CompanyName          = 'Webalex System'

    # Copyright statement for this module
    # Copyright            = '(c) author. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'WinBGP Remote Management'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry,
    # use an empty array if there are no functions to export.
    FunctionsToExport    = @(
        'Get-WinBGPRoute',
        'Start-WinBGPRoute',
        'Stop-WinBGPRoute',
        'Start-WinBGPRouteMaintenance',
        'Stop-WinBGPRouteMaintenance'
    )

    # Private data to pass to the module specified in RootModule/ModuleToProcess.
    # This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags                     = @('winbgp', 'bgp')

            # A URL to the license for this module.
            LicenseUri               = 'https://github.com/webalexeu/pswinbgp/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri               = 'https://github.com/webalexeu/pswinbgp'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

            # Prerelease string of this module
            # Prerelease = ''

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable
    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}
