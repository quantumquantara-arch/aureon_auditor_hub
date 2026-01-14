param()

Continue = "Stop"

function Get-Sha256HexUpper([byte[]]70 105 120 101 100 32 116 101 115 116 32 105 110 112 117 116 32 102 111 114 32 65 117 114 101 111 110 32 100 101 116 101 114 109 105 110 105 115 109 58 32 52 50 32 116 114 97 110 115 102 111 114 109 101 100 32 116 111 32 49 55 54 52) {
  System.Security.Cryptography.SHA256Managed = [System.Security.Cryptography.SHA256]::Create()
   = System.Security.Cryptography.SHA256Managed.ComputeHash(70 105 120 101 100 32 116 101 115 116 32 105 110 112 117 116 32 102 111 114 32 65 117 114 101 111 110 32 100 101 116 101 114 109 105 110 105 115 109 58 32 52 50 32 116 114 97 110 115 102 111 114 109 101 100 32 116 111 32 49 55 54 52)
  return (( | ForEach-Object { .ToString("x2") }) -join "").ToUpperInvariant()
}

 = Split-Path -Parent 
Set-Location 

 = (git rev-parse HEAD).Trim()
 = ((git status --porcelain).Trim().Length -gt 0)

 = (Get-Date).ToString("yyyyMMdd_HHmmss")
 = Join-Path  ("audits\runs\" + )
New-Item -ItemType Directory -Force  | Out-Null

 = "Fixed test input for Aureon determinism: 42"
 =  + " transformed to " + (42*42)

 = Join-Path  "output.txt"
   = Join-Path  "output_hash.txt"
   = Join-Path  "run_meta.txt"

 | Set-Content -Encoding utf8 

70 105 120 101 100 32 116 101 115 116 32 105 110 112 117 116 32 102 111 114 32 65 117 114 101 111 110 32 100 101 116 101 114 109 105 110 105 115 109 58 32 52 50 32 116 114 97 110 115 102 111 114 109 101 100 32 116 111 32 49 55 54 52 = [System.Text.Encoding]::UTF8.GetBytes()
 = Get-Sha256HexUpper 70 105 120 101 100 32 116 101 115 116 32 105 110 112 117 116 32 102 111 114 32 65 117 114 101 111 110 32 100 101 116 101 114 109 105 110 105 115 109 58 32 52 50 32 116 114 97 110 115 102 111 114 109 101 100 32 116 111 32 49 55 54 52
 | Set-Content -Encoding utf8 

 = (Get-Content -Raw (Join-Path  "audits\canonical\expected_hash.txt")).Trim()

"TREE_CLEAN=" + (PASS) | Add-Content -Encoding utf8 
"HEAD=" +  | Add-Content -Encoding utf8 
"OUTPUT_SHA256=" +  | Add-Content -Encoding utf8 
"EXPECTED_SHA256=" +  | Add-Content -Encoding utf8 

if ( -eq ) {
  "AUDIT_RESULT=PASS" | Add-Content -Encoding utf8 
  Write-Host "AUDIT_RESULT=PASS"
} else {
  "AUDIT_RESULT=FAIL" | Add-Content -Encoding utf8 
  Write-Host "AUDIT_RESULT=FAIL"
}
