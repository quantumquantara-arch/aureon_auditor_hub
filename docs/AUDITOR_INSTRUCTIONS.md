Auditor Instructions

1) Verify audited state:
- audits/latest/commit.txt
- audits/latest/tree.txt
- audits/latest/clean_tree.txt (must be true)

2) Verify determinism evidence:
- audits/latest/input.txt
- audits/latest/output.txt
- audits/latest/output_hash.txt
- audits/latest/expected_output_hash.txt (must match output_hash)

3) Verify tool integrity:
- audits/latest/tool_hash.txt must match SHA256 of tools/run_audit.ps1

4) Pass condition:
- audits/latest/result.txt == AUDIT_RESULT=PASS
- audits/latest/clean_tree.txt == clean_tree=true
- output_hash equals expected_output_hash

No execution is required to verify (artifacts are committed).
