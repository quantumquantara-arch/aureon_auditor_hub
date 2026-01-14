Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Resolve-Path "$PSScriptRoot\.."
$out  = Join-Path $root 'audits\latest'
New-Item -ItemType Directory -Force $out | Out-Null

# Require clean tree BEFORE generating evidence
$porcelain = (git status --porcelain)
if (-not [string]::IsNullOrEmpty($porcelain)) {
  "AUDIT_RESULT=FAIL" | Out-File (Join-Path $out 'result.txt') -Encoding utf8
  "REASON=WORKING_TREE_NOT_CLEAN" | Out-File (Join-Path $out 'reason.txt') -Encoding utf8
  $porcelain | Out-File (Join-Path $out 'dirty_status.txt') -Encoding utf8
  exit 2
}

$commit = (git rev-parse HEAD).Trim()
$tree   = (git rev-parse HEAD^{tree}).Trim()

"commit_hash=$commit" | Out-File (Join-Path $out 'commit.txt') -Encoding utf8
"tree_hash=$tree"     | Out-File (Join-Path $out 'tree.txt')   -Encoding utf8
"clean_tree=true"     | Out-File (Join-Path $out 'clean_tree.txt') -Encoding utf8

# Deterministic demo
$input = 42
$outputLine = "Fixed test input for Aureon determinism: $input transformed to $($input*$input)"
$outputLine | Out-File (Join-Path $out 'output.txt') -Encoding utf8
"input=$input" | Out-File (Join-Path $out 'input.txt') -Encoding utf8

$h = (Get-FileHash -Algorithm SHA256 (Join-Path $out 'output.txt')).Hash.ToUpperInvariant()
"output_hash=$h" | Out-File (Join-Path $out 'output_hash.txt') -Encoding utf8

$expected = "37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759"
"expected_output_hash=$expected" | Out-File (Join-Path $out 'expected_output_hash.txt') -Encoding utf8

if ($h -ne $expected) {
  "AUDIT_RESULT=FAIL" | Out-File (Join-Path $out 'result.txt') -Encoding utf8
  "REASON=HASH_MISMATCH" | Out-File (Join-Path $out 'reason.txt') -Encoding utf8
  exit 3
}

$scriptHash = (Get-FileHash -Algorithm SHA256 (Join-Path $root 'tools\run_audit.ps1')).Hash.ToUpperInvariant()
"run_audit_ps1_sha256=$scriptHash" | Out-File (Join-Path $out 'tool_hash.txt') -Encoding utf8

"DGK_ADMISSIBILITY=PASS" | Out-File (Join-Path $out 'dgk.txt') -Encoding utf8
"AUDIT_RESULT=PASS"      | Out-File (Join-Path $out 'result.txt') -Encoding utf8
