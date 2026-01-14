[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [int]$auditInput = 42
)

$ErrorActionPreference = 'Stop'

$out = [int]($auditInput * $auditInput)
Write-Output ("Fixed test input for Aureon determinism: {0} transformed to {1}" -f $auditInput, $out)