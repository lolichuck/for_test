function CopyTo-DirWithStruct{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$From,
        [Parameter(Mandatory)][string]$To,
        [Parameter(Mandatory)]$File
    )

    $dir_to = ($File.Directory).ToString().Replace("$From", "$To")
    if (!(Test-Path $dir_to)){ New-Item -Path $dir_to -ItemType Directory } 
    Copy-Item -Path $File.FullName -Destination ($_.FullName).Replace("$From", "$To") -Recurse
}

if (!(Test-Path ".\for_test")) { git clone git@github.com:lolichuck/for_test.git }
msbuild .\for_test\c_sharp_two\c_sharp_two.csproj -property:Configuration=release

if (!(Test-Path ".\product.json")) {
    New-Item -Path ".\product.json"
}

if (!(Test-Path .\archive)){ New-Item -ItemType Directory -Path .\archive }

$items = Get-ChildItem -Recurse -Include "*.dll", "*.exe"
$manifests = Get-ChildItem -Recurse -Include "*.manifest"
$pbds = Get-ChildItem -Recurse -Include "*.dll", "*.pdb"

$items | ForEach-Object {
    $file = @{
            File = Get-FileHash -Algorithm SHA1 -Path $_.FullName
        }
   ConvertTo-Json $file | Out-File .\product.json -NoClobber -Append
  
   CopyTo-DirWithStruct -From "for_test" -To "archive" -File $_
}

$manifests | ForEach-Object {
    CopyTo-DirWithStruct -From "for_test" -To "archive" -File $_
}

Compress-Archive -Path .\archive\* -DestinationPath .\release.zip
Expand-Archive  -Path .\release.zip  -DestinationPath .\release -Force


$pbds | ForEach-Object {
    CopyTo-DirWithStruct -From "for_test" -To "release\Symbols" -File $_
}
