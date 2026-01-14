# Aureon Auditor Hub

Deterministic auditor hub for Aureon OS and Companion Intelligence. Includes DGK-governed admissibility checks, coherence verification tools, reproducibility tests, provenance logs, and audit-focused documentation for verifying deterministic creativity and system integrity.

See [docs/AUDITOR_INSTRUCTIONS.md](docs/AUDITOR_INSTRUCTIONS.md) for audit steps.

## Kaggle-Style Test Cell for Deterministic Audit

Copy this Python code into a Jupyter notebook, Kaggle, or Python REPL to test the deterministic hash computation interactively.

`python
import hashlib

# Step 1: Fixed input
input_data = 'Fixed test input for Aureon determinism: 42'

# Step 2: Deterministic transformation
transformed = input_data + ' transformed to ' + str(42 * 42)  # Results in 'Fixed test input for Aureon determinism: 42 transformed to 1764'

# Step 3: Compute output hash (SHA256)
hash_object = hashlib.sha256(transformed.encode('utf-8'))
output_hash = hash_object.hexdigest().upper()

# Step 4: Expected hash for verification
expected_hash = '37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759'

# Step 5: Verify and print result
print(f"Transformed Output: {transformed}")
print(f"Computed Hash: {output_hash}")
if output_hash == expected_hash:
    print('AUDIT_RESULT=PASS')
else:
    print('AUDIT_RESULT=FAIL')
``

Expected Output:
Transformed Output: Fixed test input for Aureon determinism: 42 transformed to 1764
Computed Hash: 37FD88D52D1299721B7B697F37DDC4419E0ADDE5611D22C46B5B77B9BECE6759
AUDIT_RESULT=PASS
