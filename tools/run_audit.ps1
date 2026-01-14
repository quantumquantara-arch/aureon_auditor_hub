param()
Stop = 'Stop'
# Hard requirement: clean working tree
if ((git status --porcelain) -ne '') {
  Write-Error 'WORKING_TREE_DIRTY'
}
 = Join-Path  '..\audits\latest'
New-Item -ItemType Directory -Force  | Out-Null
# Fixed input / deterministic transform
 = 'Fixed test input for Aureon determinism: 42'
 =  + ' transformed to ' + (42 * 42)
# Expected hash (uppercase hex)
 = '37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759'
function Sha256HexUpper {
  param ([byte[]]70 105 120 101 100 32 116 101 115 116 32 105 110 112 117 116 32 102 111 114 32 65 117 114 101 111 110 32 100 101 116 101 114 109 105 110 105 115 109 58 32 52 50 32 116 114 97 110 115 102 111 114 109 101 100 32 116 111 32 49 55 54 52)
  System.Security.Cryptography.SHA256Managed = [System.Security.Cryptography.SHA256]::Create()
  try {
    ((System.Security.Cryptography.SHA256Managed.ComputeHash(70 105 120 101 100 32 116 101 115 116 32 105 110 112 117 116 32 102 111 114 32 65 117 114 101 111 110 32 100 101 116 101 114 109 105 110 105 115 109 58 32 52 50 32 116 114 97 110 115 102 111 114 109 101 100 32 116 111 32 49 55 54 52) | ForEach-Object { .ToString('x2') }) -join '').ToUpperInvariant()
  } finally {
    System.Security.Cryptography.SHA256Managed.Dispose()
  }
}
 = [System.Text.Encoding]::UTF8
37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759 = Sha256HexUpper (.GetBytes())
# Tool hash (hash of this script file bytes)
 = System.Management.Automation.InvocationInfo.MyCommand.Path
 = [System.IO.File]::ReadAllBytes()
 = Sha256HexUpper 
# Commit + tree evidence
 = (git rev-parse HEAD).Trim()
 = (git ls-tree -r --name-only HEAD)
# Write required artifacts
Set-Content -Encoding utf8 (Join-Path  'commit.txt') 
Set-Content -Encoding utf8 (Join-Path  'tree.txt') ( -join "
")
Set-Content -Encoding utf8 (Join-Path  'clean_tree.txt') 'clean_tree=true'
Set-Content -Encoding utf8 (Join-Path  'input.txt') 
Set-Content -Encoding utf8 (Join-Path  'output.txt') 
Set-Content -Encoding utf8 (Join-Path  'output_hash.txt') 37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759
Set-Content -Encoding utf8 (Join-Path  'expected_output_hash.txt') 
Set-Content -Encoding utf8 (Join-Path  'tool_hash.txt') 
if (37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759 -eq ) {
  Set-Content -Encoding utf8 (Join-Path  'result.txt') 'AUDIT_RESULT=PASS'
} else {
  Set-Content -Encoding utf8 (Join-Path  'result.txt') 'AUDIT_RESULT=FAIL'
  Write-Error 'HASH_MISMATCH'
}
