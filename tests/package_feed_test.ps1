﻿using module ..\Packages.psm1
using module ..\..\AutoDownloader

$doc = Get-Item $PSScriptRoot\..\PackagesConfig.json

$PackageList = [PackagesList]::new($doc)

$PackageList.Packages | ForEach-Object { 

    [NuGetPackage]$Package = $_ 

    $Package.UpdateRecentVersion()

    if ($Package.IsOutdated()) {
        try {
            $Package.download([DownloadType]::Recent)
            $Package.UpdateVersion()
        }
        catch {
            Write-Error "Failed to download."
        }
    }
}

$PackageList.Save()
