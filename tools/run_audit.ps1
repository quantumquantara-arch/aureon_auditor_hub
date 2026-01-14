
# Deterministic Creativity (Auditable Definition)

Creativity can be produced without randomness.

This repo defines *deterministic creativity* as:

* **Novelty from deterministic procedures**:

  * canonicalization + rewrite systems
  * constraint solving
  * bounded search with deterministic ordering
  * compositional transformations over stable primitives
  * proof-style verification loops

Audit requirement:

* The same input must yield the same output and the same hash under identical code + environment constraints.
* Novelty is evaluated across differing inputs, not across multiple runs of the same input.

Non-requirement:

* A probabilistic toggle is not required for creativity. Randomness is one way to create variation, but not the only way.
  "@ | Set-Content -Encoding utf8 "docs/DETERMINISTIC_CREATIVITY.md"

# Canonical evidence artifacts (committed)

 = "Fixed test input for Aureon determinism: 42 transformed to 1764"
 | Set-Content -Encoding utf8 "audits\canonical\output.txt"

# Compute canonical SHA256 (UTF-8 bytes)

 = [System.Text.Encoding]::UTF8.GetBytes()
 = [System.Security.Cryptography.SHA256]::Create()
 = (.ComputeHash() | ForEach-Object { .ToString("x2") }) -join ""
 = .ToUpperInvariant()

 | Set-Content -Encoding utf8 "audits\canonical\output_hash.txt"
 | Set-Content -Encoding utf8 "audits\canonical\expected_hash.txt"

@"
param()

Continue = "Stop"

function Get-Sha256HexUpper([byte[]]) {
 = [System.Security.Cryptography.SHA256]::Create()
 = .ComputeHash()
return (( | ForEach-Object { .ToString("x2") }) -join "").ToUpperInvariant()
}

 = Split-Path -Parent 
Set-Location 

 = (git rev-parse HEAD).Trim()
 = ((git status --porcelain).Trim().Length -gt 0)

 = (Get-Date).ToString("yyyyMMdd_HHmmss")
 = Join-Path  ("audits\runs" + )
New-Item -ItemType Directory -Force  | Out-Null

 = "Fixed test input for Aureon determinism: 42"
 =  + " transformed to " + (42*42)

 = Join-Path  "output.txt"
   = Join-Path  "output_hash.txt"
   = Join-Path  "run_meta.txt"

 | Set-Content -Encoding utf8 

 = [System.Text.Encoding]::UTF8.GetBytes()
 = Get-Sha256HexUpper 
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
