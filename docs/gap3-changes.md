# GAP3 source consolidation and corrections

Original files were read without modification. The cleaned code uses one explicit `ctx` argument per group, rather than global `W`, `S`, `D`, `A`, and mutable lists shared between unrelated scripts. Source file names below refer to **Gap3 Coding**; the package's source manifest records original paths and hashes.

For the complete input-to-output mapping, see [SOURCE_MAP.md](SOURCE_MAP.md).

## Defects corrected

- Removed incomplete `newM :=` syntax, the broken `Mchains` attempt, Sage syntax embedded in GAP notes, misspelled `ComplexRelfectionGroup`, missing semicolons, and malformed assignment/destructuring fragments.
- Defined one chain orientation: weakly increasing `x1 <= ... <= xk`. Starting and ending restrictions have separate, documented meanings. Every positive `k` is accepted; invalid `k` errors instead of giving an accidental empty result or failed indexing.
- Replaced duplicated exponential "fast" enumeration with dynamic programming for counts. It sums coset indices weighted by chain counts, so it need not materialize parking functions.
- Removed the extra outer loop in `Fuss_w_iso_exceptionals` that counted the same global chain list once per NC element, and eliminated the shadowed/uninitialized local `MC` in that function.
- Applied group actions to the coset label. The original `Representative(w)*g=g` was invalid when `g` included a chain. Class matrix calculations now use `Representative(class)`, rather than passing class records to `MatXPerm`.
- Replaced the undeclared `kh` expression by `k*h` within explicit numerical comparisons. Exact matrix nullity replaces `Size(Set(NullspaceMat(...)))` and the unproved use of reflection length as codimension for every complex group.
- Preserved `[coset,chain]` records rather than globally deduplicating bare cosets across different noncrossing labels.
- Full-support routines consistently return a list of elements. They no longer sometimes return `[elements,reflections]` and accidentally loop over the two lists as if they were elements.
- Full support uses the context's actual generating reflections and proper subgroups. Subgroup membership is tested directly, avoiding repeated `Elements(subgroup)` construction inside loops.
- The full-support group loop no longer hardcodes `ComplexReflectionGroup(5)` while purporting to iterate through other group numbers.
- Support-intersection failures return the actual element and subset witnesses. The whole-group version no longer prints undefined `pifails`, and pair deduplication no longer compares a two-entry key with stored three-entry records.
- Cyclic fixed points require the noncrossing label to be fixed as well as the coset. Accumulators are initialized once per table entry, rather than reset inside the loop over NC elements; eigenspace dimensions are computed once per class and power, rather than repeatedly added once per element.
- Cyclic tests visit all residues including zero. Explicit powers and exact matrix kernels remove fragile special handling of `d/h` and zero eigenvalue exponents.
- Extracted coset-poset data and optional Sage homology code from the exploratory setup, with strict inclusion direction stated explicitly.

## Deliberately omitted or qualified

Repeated hardcoded group runs, debug prints, duplicate "fast/faster" implementations, malformed scratch functions, and historical claims such as "verified through G26" are not copied as runnable code. The original notebooks/files remain the record of those historical experiments.

The proposed generalized rank-filter identities and full-support/codegree products remain numerical experiments. Arbitrary endpoint predicates reproduce the rank-filter computations without claiming that a threshold works in higher rank. No missing intermediate-support theorem was invented.

The old `w_fullsupp_andor_pi_fullsupp` file did not actually implement an additional independent restriction on the coset representative `w`; its working calculation restricts the largest NC chain entry. That implemented behavior is retained. No well-defined coset condition is inferred from the filename.

`W x C` support is limited to `k=1`, matching the actual supplied cyclic algorithms. The generalized Fuss rotation of order `k*h` is not present in those originals and is not replaced with a different action.

No GAP3 or CHEVIE runtime is bundled, and no license for the user's research code is assumed. All scripts are separate from website material.
