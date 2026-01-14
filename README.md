# Aureon Auditor Hub

Deterministic auditor hub for **Aureon OS** and **Companion Intelligence (CI)**.

This repository is designed for auditors: it contains replayable evidence, hash-locked demonstrations, and audit scripts that verify deterministic behavior, admissibility criteria, and deterministic creativity (novelty via deterministic transformation/searchnot randomness).

## Live runnable audit cell (Colab)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/quantumquantara-arch/aureon_auditor_hub/blob/main/notebooks/deterministic_audit_cell.ipynb)

Open the notebook and run the single cell. It prints the transformed output, its SHA256, and AUDIT_RESULT=PASS when correct.

## What auditors verify

1) Determinism: same input  same output  same hash  
2) Evidence-first claims: claims accepted only when backed by committed artifacts under audits/canonical/ or reproducible scripts under tools/  
3) Deterministic creativity: creative outputs can still be produced deterministically using structured transforms, constraint solving, canonicalization, and bounded search. Creativity  randomness.

## Quickstart (local)

Run the audit script:
powershell -NoProfile -ExecutionPolicy Bypass -File tools\run_audit.ps1

Inspect canonical evidence:
- audits/canonical/output.txt
- audits/canonical/output_hash.txt
- audits/canonical/expected_hash.txt

Audit protocol:
- docs/AUDITOR_INSTRUCTIONS.md
- docs/CLAIMS_AND_EVIDENCE.md
- docs/DGK_ADMISSIBILITY.md
- docs/DETERMINISTIC_CREATIVITY.md
