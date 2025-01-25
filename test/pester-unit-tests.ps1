BeforeALl{
    Import-module .\
}
Describe 'nupsforge' {
    It 'Function exists' {
        Get-Command New-ChocoNuspecFile | Should -Not -BeNullOrEmpty
    }
    It 'Function exists' {
        Get-Command New-NuspecPackageFile | Should -Not -BeNullOrEmpty
    }
    It 'Function exists' {
        Get-Command New-ChocoPackage | Should -Not -BeNullOrEmpty
    }
    It 'Function exists' {
        Get-Command New-NupkgPackage | Should -Not -BeNullOrEmpty
    }
    It 'New-ChocoNuspecFile creates a .nuspec file' {
        # Arrange
        $moduleName = 'TestModulechoco'
        $moduleVersion = '1.0.0'
        $path = '.\test\testmodulechoco'
        $author = 'Test Author'
        $description = 'Test Description'
        $projectUrl = 'http://example.com'
        $tags = 'Test,Module'
        $company = 'TestCompany'
        $dependencies = @(@{id="logtastic";version='3.2.1'})
        $licenseAcceptance = $false
        $licenseurL = 'http://example.com/license'
        $releasenotes = 'First release'
        $expectedFile = Join-Path -Path $path -ChildPath "$moduleName.nuspec"

        # Act
        New-ChocoNuspecFile -ModuleName $moduleName `
                            -ModuleVersion $moduleVersion `
                            -path $path `
                            -owners "owner1" `
                            -Author $author `
                            -Description $description `
                            -ProjectUrl $projectUrl `
                            -LicenseUrl $licenseurL `
                            -Tags $tags `
                            -iconUrl "http://example.com/png" `
                            -company $company `
                            -dependencies $dependencies `
                            -LicenseAcceptance:$licenseAcceptance `
                            -releasenotes $releasenotes `
                            -bugTrackerUrl 'http://example.com/bugtracker' `
                            -docsUrl 'http://example.com/docs' `
                            -mailingListUrl 'http://example.com/mailinglist' `
                            -projectSourceurl 'http://example.com/packagesource'

        # Assert
        $expectedFile | Should -Exist
    }
    It 'New-NuspecPackageFile creates a .nuspec file' {
        # Arrange
        $moduleName = 'TestModule'
        $moduleVersion = '1.0.0'
        $path = '.\test\TestModule'
        $author = 'Test Author'
        $description = 'Test Description'
        $projectUrl = 'http://example.com'
        $license = 'MIT'
        $tags = 'Test,Module'
        $company = 'TestCompany'
        $dependencies = @(@{id = "logtastic"; version = '3.2.1' })
        $licenseAcceptance = $false
        $releasenotes = 'First release'
        $expectedFile = Join-Path -Path $path -ChildPath "$moduleName.nuspec"

        # Act
        New-NuspecPackageFile -ModuleName $moduleName `
                              -ModuleVersion $moduleVersion `
                              -path $path `
                              -Author $author `
                              -Description $description `
                              -ProjectUrl $projectUrl `
                              -License $license `
                              -Tags $tags `
                              -company $company `
                              -dependencies $dependencies `
                              -LicenseAcceptance:$licenseAcceptance `
                              -releasenotes $releasenotes

        # Assert
        $expectedFile | Should -Exist
    }
    It 'New-ChocoPackage Creates a .nupkg package' {
        # Arrange
        $path = '.\test\testmodulechoco'
        $outPath = '.\test'
        $expectedFile = Join-Path -Path $outPath -ChildPath 'TestCompany.TestModule.1.0.0.nupkg'

        # Act
        New-ChocoPackage -Path $path -OutPath $outPath

        # Assert
        $expectedFile | Should -Exist
    }
    It 'New-NupkgPackage Creates a .nupkg package' {
        # Arrange
        $path = '.\test\testmodule'
        $outPath = '.\test'
        $expectedFile = Join-Path -Path $outPath -ChildPath 'TestCompany.TestModule.1.0.0.nupkg'

        # Act
        New-NupkgPackage -Path $path -OutPath $outPath

        # Assert
        $expectedFile | Should -Exist
    }
}