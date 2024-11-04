Describe 'PSWinBGP' {
    It 'Function: Get-WinBGPRoute' {
        Get-WinBGPRoute -ComputerName localhost | Should -Be "@{Result=API connection timeout}"
    }
    It 'Function: Start-WinBGPRoute' {
        Start-WinBGPRoute -ComputerName localhost -RouteName 'winbgp.contoso.com' | Should -Be "@{Result=API connection timeout}"
    }
    It 'Function: Stop-WinBGPRoute' {
        Stop-WinBGPRoute -ComputerName localhost -RouteName 'winbgp.contoso.com' | Should -Be "@{Result=API connection timeout}"
    }
    It 'Function: Start-WinBGPRouteMaintenance' {
        Start-WinBGPRouteMaintenance -ComputerName localhost -RouteName 'winbgp.contoso.com' | Should -Be "@{Result=API connection timeout}"
    }
    It 'Function: Stop-WinBGPRouteMaintenance' {
        Stop-WinBGPRouteMaintenance -ComputerName localhost -RouteName 'winbgp.contoso.com' | Should -Be "@{Result=API connection timeout}"
    }
}
