﻿using module ..\Packages.psm1
using module ..\..\AutoDownloader


$config = Get-Content $PSScriptRoot\..\PackagesConfig.json | ConvertFrom-Json

$config.NugetPackages | ForEach-Object {

    [NuGetPackage]$Package = $_ 

    $Package.UpdateRecentVersion()

    if ([version]$Package.RecentVersion -gt [version]$Package.CurrentVersion) {
        
        try {
            $Package.download([DownloadType]::Recent)
            $Package.UpdateCurrentVersion()
        }
        catch {
            Write-Error "Failed to download."
        }

    }


    



}




