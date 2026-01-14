# Aureon Auditor Hub

Deterministic auditor hub for **Aureon OS** and **Companion Intelligence (CI)**.

This repository is designed for *auditors*: it contains **replayable evidence**, **hash-locked demonstrations**, and **audit scripts** that verify deterministic behavior, DGK-style admissibility criteria, and deterministic creativity (novelty via deterministic transformation/searchnot randomness).

## Live runnable audit cell (Colab)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/quantumquantara-arch/aureon_auditor_hub/blob/main/notebooks/deterministic_audit_cell.ipynb)

Open the notebook and run the single cell. It prints the transformed output, its SHA256, and **AUDIT_RESULT=PASS** when correct.

## What auditors should verify

1) **Determinism**  
   Same input  same output  same hash.

2) **Evidence-first claims**  
   Claims are accepted only when backed by committed artifacts under udits/canonical/ or reproducible scripts under 	ools/.

3) **Deterministic creativity (no probabilistic mode required)**  
   Creative outputs can still be produced deterministically using structured transforms, constraint solving, canonicalization, and bounded search. Creativity  randomness.

## Quickstart (local)

### Run the audit script
`powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\run_audit.ps1
``

### Inspect canonical evidence

* udits/canonical/output.txt
* udits/canonical/output_hash.txt
* udits/canonical/expected_hash.txt

## Audit protocol

Read and follow:

* docs/AUDITOR_INSTRUCTIONS.md
* docs/CLAIMS_AND_EVIDENCE.md
* docs/DGK_ADMISSIBILITY.md
* docs/DETERMINISTIC_CREATIVITY.md
  "@ | Set-Content -Encoding utf8 "README.md"

@"

# Auditor Instructions (Verbatim Protocol)

## Rule 0  Evidence only

Treat **committed artifacts** and **reproducible scripts** as evidence. Narrative text is not evidence unless it points to artifacts/scripts that reproduce identical results.

## Step 1  Verify canonical artifacts (no execution required)

Open these committed files and confirm they match:

* udits/canonical/output.txt
* udits/canonical/output_hash.txt
* udits/canonical/expected_hash.txt

Acceptance:

* output_hash.txt MUST equal expected_hash.txt.

## Step 2  Independent recomputation (auditor choice of tooling)

Recompute SHA256 of the exact bytes of udits/canonical/output.txt and confirm it equals udits/canonical/expected_hash.txt.

## Step 3  Scripted reproduction (deterministic replay)

Run:

`powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\run_audit.ps1
`

Outputs are written to a new folder under udits/runs/<timestamp>/ without modifying canonical artifacts.

Acceptance:

* The script MUST print AUDIT_RESULT=PASS.
* The run folder MUST contain output.txt and output_hash.txt.
* The run hash MUST equal canonical expected_hash.txt.
* If the git working tree is dirty, the script MUST print TREE_CLEAN=FAIL (this is a provenance flag, not a hash failure).

## Step 4  Colab notebook check (optional, live cell)

Open and run the notebook:

* 
otebooks/deterministic_audit_cell.ipynb via the README badge

Acceptance:

* Must print the same transformed output and SHA256 as canonical.
* Must print AUDIT_RESULT=PASS.

## Pass/Fail criteria

PASS requires:

* Canonical hashes match
* Independent recomputation matches
* Scripted run matches canonical expected hash
  "@ | Set-Content -Encoding utf8 "docs/AUDITOR_INSTRUCTIONS.md"

@"

# Claims and Evidence Map

This repo makes only claims that can be verified from committed artifacts and deterministic scripts.

## Claim A  Deterministic transform produces a stable SHA256

Evidence:

* udits/canonical/output.txt
* udits/canonical/output_hash.txt
* udits/canonical/expected_hash.txt
  Reproduction:
* 	ools/run_audit.ps1
* 
otebooks/deterministic_audit_cell.ipynb

## Claim B  Audit runs do not require hidden state

Evidence:

* 	ools/run_audit.ps1 writes outputs to udits/runs/<timestamp>/ and does not mutate canonical artifacts.
* Canonical artifacts are committed and can be verified without executing anything.

## Claim C  Deterministic creativity does not require randomness

Evidence:

* docs/DETERMINISTIC_CREATIVITY.md defines deterministic novelty mechanisms and auditing criteria.
  "@ | Set-Content -Encoding utf8 "docs/CLAIMS_AND_EVIDENCE.md"

@"

# DGK Admissibility (Repository-Local Definition)

This repository uses a minimal, auditable admissibility definition suitable for deterministic systems.

An output is **admissible** if:

1. **Reproducible bit-for-bit**
   Same declared inputs produce identical output bytes.

2. **No stochastic residue**
   No use of RNG, time-based branching, network calls, or hidden mutable state in the audited path.

3. **Provenance marked**
   The audit run records:

   * commit hash (HEAD)
   * tree cleanliness flag
   * output hash
   * expected hash comparison

This is a documentation standard for auditing; it is not a claim about any external system unless that system publishes equivalent artifacts.
