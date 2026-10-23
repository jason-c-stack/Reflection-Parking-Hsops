# Tests and verified examples

Last runtime verification: 2026-10-20. 

Run commands below from the package directory, the folder containing `gap3` and `wolfram`. The two test suites are independent.

## GAP3/CHEVIE

Start GAP3 and run:

```gap
Read("gap3/tests/regression.g");
Read("gap3/examples/g4.g");
Read("gap3/examples/restricted.g");
```

The regression suite prints `ALL GAP3 REGRESSION TESTS PASSED` on success. GAP3 can enter an error loop while still returning exit status zero; inspect the success marker and any errors.

Recorded runtime: GAP3 `lib:07 Jan 2024, src:19 Mar 2021, sys:macosx gcc64`. The suite and both example scripts passed. This GAP3 distribution emits an existing `DisplayPresentation` warning from its own `fptietze.g`.

| Group | Ordinary parking counts for k = 1, 2, 3, 4 |
| --- | --- |
| A2 | 16, 49, 100, 169 |
| G4 | 49, 169, 361, 625 |
| G5 | 169, 625, 1369, 2401 |
| G6 | 169, 625, 1369, 2401 |

Tests compare counts with explicit chains and parking objects, W-characters with direct fixed-point enumeration, and k=1 cyclic fixed counts with the explicit action. They also check action composition and period, endpoint restrictions, support intersections, coset inclusions, an explicit Coxeter word, and an A3 character example.

Additional exact checks confirmed counts and characters for G8, G10, and G14 at k=1,2, all k=1 cyclic residues/classes, and representative independence for the G4 action. The optional Sage export was also run for A2, giving reduced integral homology `{0: 0, 1: Z x Z x Z x Z}` for its proper coset order complex.

## Wolfram Language

Run:

```sh
wolframscript -file wolfram/run-tests.wls
wolframscript -file wolfram/examples/basic.wls
```

Recorded runtime: Wolfram Language 14.2.1 on macOS ARM. All 38 regression tests and the example passed, with exit status 0 and no stderr. The runner prints `All passed: True` on success.

Tests cover exact coefficient equations, complete monomial bases, target twists, invalid and inexact inputs, independence from global coefficient assignments, known polynomial vectors, and complex common-zero checks. Expected negative results include the G25 degree-4 HSOP failure and the zero G10 degree-7 covariant space when both representations have twist 31.

Separate exact cyclotomic calculations in SageMath 10.4 confirmed the nine generator-group orders and reflection ranks and checked the named polynomial examples. See [the HSOP guide](hsop.md#named-polynomial-examples) for the candidate outcomes and [the GAP3 guide](gap3.md) for action conventions and dependencies.

## Scope

Finite computations verify the listed examples, not general character identities. Full support depends on the chosen generating reflections. The implemented cyclic action is limited to k=1. Large enumerations and exact common-zero calculations can be expensive.
