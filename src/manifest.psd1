#
# Module manifest for module 'PSWinBGP' (override any of the framework defaults and generated values)
#

@{
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

    # Description of the functionality provided by this module
    Description          = 'WinBGP Remote Management'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '5.1'

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

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            RequireLicenseAcceptance = $false
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}
