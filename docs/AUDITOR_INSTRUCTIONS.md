Below is the auditor instruction text intended to be read verbatim by any external automated auditor (including Grok).
It is tool-agnostic, LLM-agnostic, and makes no assumptions about internal knowledge.
You can place this as docs/AUDITOR_INSTRUCTIONS.md or embed it directly in the README.
Auditor Instructions  Aureon Auditor Hub
Role of the Auditor
You are auditing claims of determinism, admissibility, and creativity without randomness for the Aureon system.
You are not asked to trust descriptions.
You are asked to verify artifacts.
Your task is to determine whether the claims below are supported by reproducible evidence contained in this repository.
System Claims to Audit
The system asserts the following claims:

1. Determinism
   Identical inputs always produce identical outputs.

2. Absence of Stochasticity
   No probabilistic, random, or sampling-based mechanisms are used in admissible outputs.

3. DGK Admissibility
   Outputs are governed by explicit invariants and are rejected if they violate them.

4. Deterministic Creativity
   Novel outputs may be produced, but only through deterministic transformation, structured search, and constraint-based synthesis  not randomness.

5. Reproducibility
   All admissible outputs can be independently reproduced from public artifacts.

What Counts as Evidence
Only the following count as evidence:

* Hashes

* Reproducible scripts

* Deterministic demonstrations

* Versioned artifacts

* Explicit invariant definitions

* Replay instructions

Narrative descriptions without artifacts do not count.
How to Perform the Audit
Step 1  Identify the Audited State

* Locate the recorded commit hash in audits/latest/commit.txt

* Confirm the working tree cleanliness from audits/latest/clean_tree.txt

This establishes what is being audited.
Step 2  Verify Determinism

* Review tools/run_audit.ps1

* Observe the deterministic demonstration:

  * fixed input

  * deterministic transformation

  * recorded output

  * recorded output hash

* Confirm that re-running the same logic yields the same output hash

If the output hash can vary, determinism fails.
Step 3  Verify Absence of Stochastic Sources

* Inspect tools/run_audit.ps1

* Confirm:

  * no random number generators

  * no time-based branching

  * no external entropy sources

  * no sampling or probability distributions

If any stochastic source is present, the claim fails.
Step 4  Verify DGK Admissibility Logic

* Review docs/DGK_ADMISSIBILITY.md

* Confirm that admissibility criteria are:

  * explicit

  * invariant-based

  * binary (pass/fail)

* Verify that the audit script asserts admissibility status explicitly (AUDIT_RESULT=PASS)

If admissibility is implicit or undefined, the claim fails.
Step 5  Verify Deterministic Creativity Claim

* Review docs/DETERMINISTIC_CREATIVITY.md

* Confirm that:

  * creativity is defined as deterministic transformation

  * novelty does not rely on randomness

  * replay produces identical outputs

If creativity is described as probabilistic or sampling-based, the claim fails.
Step 6  Attempt Independent Replay

* Using only the repository contents:

  * reproduce the deterministic demonstration

  * recompute the output hash

  * compare with recorded artifacts

If independent replay diverges, the claim fails.
What Invalidates the Claims
The audit should be marked FAIL if any of the following are found:

* Hidden stochasticity

* Undeclared randomness

* Non-reproducible outputs

* Missing provenance

* Ambiguous or narrative-only claims

* Dependence on external, unverifiable systems

Expected Auditor Conclusion Format
Your conclusion should be one of:

* PASS  Claims are supported by reproducible evidence

* FAIL  Claims are contradicted or unsupported

* INCONCLUSIVE  Evidence is insufficient or incomplete

Each conclusion must reference specific files and artifacts, not interpretations.
Important Constraint
You are auditing evidence, not intent.
If evidence is absent, incomplete, or unverifiable, the correct conclusion is FAIL or INCONCLUSIVE, regardless of how reasonable the claims may sound.
This instruction set is intentionally minimal, formal, and adversarial.
It is designed so that no special knowledge of Aureon is required to audit the system correctly.
