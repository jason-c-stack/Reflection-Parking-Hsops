# Validation record

Prepared on 2026-10-20. These checks concern this cleaned package. Historical comments and stored notebook outputs were not counted as test results.

## GAP3/CHEVIE

The supplied regression suite and both example scripts ran successfully with GAP3 `lib:07 Jan 2024, src:19 Mar 2021, sys:macosx gcc64`. The suite printed `ALL GAP3 REGRESSION TESTS PASSED`.

| Group | Ordinary parking counts for k = 1, 2, 3, 4 |
| --- | --- |
| A2 | 16, 49, 100, 169 |
| G4 | 49, 169, 361, 625 |
| G5 | 169, 625, 1369, 2401 |
| G6 | 169, 625, 1369, 2401 |

The suite compares dynamic-programming counts with explicit chains and parking objects, class characters with direct fixed-point enumeration, and the k=1 cyclic fixed-count routine with the explicit action at every class and cyclic power. It also checks action composition and period, endpoint restrictions, empty/duplicate endpoints, support intersections, proper coset inclusions, an explicit Coxeter word, and a rank-three A3 character example.

The independent review extended enumeration/count/character comparisons to G8, G10, and G14, and checked representative independence and closure of the G4 cyclic action. See [the independent review](independent-review.md).

The optional Sage export was run for A2: the proper coset order complex had reduced integral homology `{0: 0, 1: Z x Z x Z x Z}`. This is one computed example, not a general topology claim.

To repeat the package tests, start GAP3 in the package directory and run:

```gap
Read("gap3/tests/regression.g");
Read("gap3/examples/g4.g");
Read("gap3/examples/restricted.g");
```

This local GAP3 distribution issues an existing `DisplayPresentation` warning from its own `fptietze.g`. A GAP3 error can leave the process in an error loop with exit status zero, so inspect the success marker and any error output.

## Wolfram Language

All 38 final Wolfram regression tests passed under Wolfram Language 14.2.1 (exit status 0, no stderr). An independent earlier run also passed the 34 core tests available at that point. Tests cover exact equivariance, full monomial bases, target twists, invalid inputs, global coefficient-state isolation, known saved candidates, and the complex common-zero condition. Equivariance and the HSOP condition are separate properties.

The shipped `wolfram/examples/basic.wls` also ran successfully (exit status 0, no stderr), including the expected negative G25 and empty-space G10 results.

See [the HSOP guide](hsop.md) for the exact regression command, runtime details, and candidate outcomes.

The independent review built all nine matrix groups over exact cyclotomic fields in Sage. Each had its expected finite order, and every supplied generator satisfied `rank(g-I)=1`; the complete order table and independent candidate results are in [the review](independent-review.md).

## Package integrity and limits

The SHA-256 hashes of all 38 substantive original files match the inventory in [SOURCE_MANIFEST.json](SOURCE_MANIFEST.json). No originals were edited. Duplicate screenshots, operating-system files, notebook caches, and repeated implementations were excluded. The package has no duplicate file contents.

Finite regression checks do not establish general character identities. Full support is relative to the chosen generating reflections. The cyclic action implemented here is the supplied k=1 action. Large enumerations and exact common-zero computations may be expensive. The guides identify mathematically invalid saved candidates and source-data discrepancies rather than treating them as successful results.
