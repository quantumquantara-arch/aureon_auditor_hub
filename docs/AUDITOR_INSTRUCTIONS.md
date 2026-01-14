# Auditor Instructions (Verbatim Protocol)

Rule 0  Evidence only  
Treat committed artifacts and reproducible scripts as evidence.

Step 1  Verify canonical artifacts (no execution required)
- audits/canonical/output.txt
- audits/canonical/output_hash.txt
- audits/canonical/expected_hash.txt
Acceptance: output_hash.txt MUST equal expected_hash.txt.

Step 2  Independent recomputation  
Recompute SHA256 of the exact bytes of audits/canonical/output.txt and confirm it equals audits/canonical/expected_hash.txt.

Step 3  Scripted reproduction  
Run:
powershell -NoProfile -ExecutionPolicy Bypass -File tools\run_audit.ps1

Acceptance:
- Must print AUDIT_RESULT=PASS
- Must create audits/runs/<timestamp>/output.txt and output_hash.txt
- Run hash must equal canonical expected_hash.txt
- If git tree is dirty, must print TREE_CLEAN=FAIL (provenance flag)

Step 4  Colab notebook (live runnable cell)
Open:
notebooks/deterministic_audit_cell.ipynb (via README badge)

Acceptance:
- Must print same transformed output and SHA256 as canonical
- Must print AUDIT_RESULT=PASS

Pass criteria:
- Canonical hashes match
- Independent recomputation matches
- Scripted run matches canonical expected hash
