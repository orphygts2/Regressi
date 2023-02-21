
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://jean-michel-millet.pagesperso-orange.fr/regressi-choco.msi'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
 

  softwareName  = 'Regressi*'

  checksum      = '05F8F43BF57CA84E687CEA4E9A786CAB499FDBD33AC7D3AF633D5E9F7F7F4A04'
  checksumType  = 'sha256'
 

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

















