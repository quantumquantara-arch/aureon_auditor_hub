# Admissibility (Repository-Local Definition)

An output is admissible if:
1) Reproducible bit-for-bit: same declared inputs produce identical output bytes.
2) No stochastic residue: no RNG, time-based branching, network calls, or hidden mutable state in the audited path.
3) Provenance marked: audit run records HEAD, tree cleanliness, output hash, expected hash comparison.
