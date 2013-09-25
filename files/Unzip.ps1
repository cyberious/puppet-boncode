param([string] $InstallDir,[string] $Version)

[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | out-null
[System.IO.Compression.ZipFile]::ExtractToDirectory("$InstallDir\BonCodeAJP13_$Version.zip","$InstallDir\BonCode\")
