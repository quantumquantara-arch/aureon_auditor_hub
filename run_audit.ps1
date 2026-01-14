[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [int]$auditInput = 42
)

$ErrorActionPreference = 'Stop'

# Deterministic transform
$out = [int]($auditInput * $auditInput)

# Required canonical evidence line (exact text)
Write-Output ("Fixed test input for Aureon determinism: {0} transformed to {1}" -f $auditInput, $out)