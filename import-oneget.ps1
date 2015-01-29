param( [Switch]$runTest ) 

$env:PSModulePath="$PSScriptRoot;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\"

# erase old nuget binaries
erase $PSScriptRoot\oneget\*nuget*

# copy latest nuget binaries
copy "$PSScriptRoot\..\NuGetProvider\output\Debug\bin\*" $PSScriptRoot\OneGet
ipmo "$PSScriptRoot\oneget-edge"

# just force the loading of the providers now
get-packageprovider

# sometimes useful: watch as it loads the providers
# get-packageprovider -verbose -debug

# sometimes useful: check to see which modules are really loaded.
# (get-module -all).Path

# run the pester test suite
if( $runTest ) {
    & "$PSScriptRoot\..\cmdlet-testsuite\test-oneget.ps1" -moduleLocation (resolve-path $PSScriptRoot\OneGet-Edge\OneGet-Edge.psd1)
}