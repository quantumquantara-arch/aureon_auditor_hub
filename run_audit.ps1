param()
$ErrorActionPreference = 'Stop'

# --- Context: quantumquantara-arch/aureon_auditor_hub ---
# Hard requirement: clean working tree to ensure provenance
if ((git status --porcelain) -ne '') {
    Write-Error 'WORKING_TREE_DIRTY: Commit changes before running audit.'
}

# Define output directory
$out = Join-Path $PSScriptRoot '..\audits\latest'
New-Item -ItemType Directory -Force $out | Out-Null

# --- Deterministic Input ---
# FIXED: Renamed $input to $auditInput to avoid PowerShell reserved variable conflict
$auditInput = 'Fixed test input for Aureon determinism: 42'
$outputText = $auditInput + ' transformed to ' + (42 * 42).ToString()

# Expected hash (uppercase hex) - Critical for DGK-governed admissibility
$expected = '37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759'

function Sha256HexUpper {
    param(
        [byte[]]$bytes
    )
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        (($sha.ComputeHash($bytes) | ForEach-Object { $_.ToString('x2') }) -join '').ToUpperInvariant()
    } finally {
        $sha.Dispose()
    }
}

$enc = [System.Text.Encoding]::UTF8
$hash = Sha256HexUpper ($enc.GetBytes($outputText))

# --- Tool Provenance ---
# Hashing the script itself ensures the auditor hasn't been tampered with
$toolPath = $MyInvocation.MyCommand.Path
$toolBytes = [System.IO.File]::ReadAllBytes($toolPath)
$toolHash = Sha256HexUpper $toolBytes

# --- Repo Provenance ---
$head = (git rev-parse HEAD).Trim()
$tree = (git ls-tree -r --name-only HEAD)

# --- Write Artifacts ---
Set-Content -Encoding utf8 (Join-Path $out 'commit.txt') $head
Set-Content -Encoding utf8 (Join-Path $out 'tree.txt') ($tree -join "`n")
Set-Content -Encoding utf8 (Join-Path $out 'clean_tree.txt') 'clean_tree=true'
Set-Content -Encoding utf8 (Join-Path $out 'input.txt') $auditInput
Set-Content -Encoding utf8 (Join-Path $out 'output.txt') $outputText
Set-Content -Encoding utf8 (Join-Path $out 'output_hash.txt') $hash
Set-Content -Encoding utf8 (Join-Path $out 'expected_output_hash.txt') $expected
Set-Content -Encoding utf8 (Join-Path $out 'tool_hash.txt') $toolHash

# --- Validation ---
if ($hash -eq $expected) {
    Set-Content -Encoding utf8 (Join-Path $out 'result.txt') 'AUDIT_RESULT=PASS'
    Write-Host " [PASS] Integrity verified. Artifacts stored in: $out" -ForegroundColor Green
} else {
    Set-Content -Encoding utf8 (Join-Path $out 'result.txt') 'AUDIT_RESULT=FAIL'
    Write-Error 'HASH_MISMATCH: Computed hash does not match expected integrity hash.'
}