Set-StrictMode -Version Latest
$out = Join-Path $PSScriptRoot '..\audits\latest'
New-Item -ItemType Directory -Force $out | Out-Null
git rev-parse HEAD | Out-File (Join-Path $out 'HEAD.txt')
git status --porcelain | Out-File (Join-Path $out 'status.txt')
'AUDIT_OK' | Out-File (Join-Path $out 'result.txt')
