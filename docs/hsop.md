# Reflection group covariants and HSOPs

This package constructs exact equivariant homogeneous polynomial maps and checks the HSOP condition. It includes generator data for nine reflection groups, example degree and twist settings, and named polynomial vectors.

Use Wolfram Language 14 or newer. Tests were run with Wolfram 14.2.1 on macOS ARM. No extra Wolfram packages are required.

## Load and use

From the package directory (the folder containing `gap3` and `wolfram`), run this in a Wolfram notebook or kernel:

```wolfram
Get["wolfram/ReflectionHSOP.wl"];
Clear[x, y, z];

basis = CovariantBasis[ReflectionGenerators["G8"], 5, {x, y}];
(* {{-x^5/5 + x y^4, x^4 y - y^5/5}} *)

EquivariantQ[First[basis], {x, y}, ReflectionGenerators["G8"]]
(* True *)
HSOPReport[First[basis], {x, y}]
(* <|"HSOP" -> True, "Degrees" -> {5,5}, "NonzeroCommonZeros" -> False|> *)
```

If the kernel's current directory is elsewhere, give `Get` the full path to `ReflectionHSOP.wl`. Pass distinct, unassigned symbols as variables. Coefficients and generators must be exact algebraic numbers; approximate values and unresolved coefficient parameters cannot certify an HSOP.

`CovariantBasis` returns polynomial vectors spanning the entire equivariant space. An empty list means this space is zero. Its basis vectors are candidates: each chosen vector or linear combination still needs an HSOP check.

## Matrix convention and twists

Matrices act on the polynomial variables using transposes. For each input matrix `g` and corresponding target matrix `h`, the equation is

```wolfram
F[Transpose[g].v] == Transpose[h].F[v]
```

Here `F` denotes the polynomial vector and `v` the variable column. Both matrix actions are transposed. The default target is the input representation.

`ReflectionGenerators[name, p]` reconstructs the matrices with every defining root of unity raised to the integer `p`. The exponent must be coprime to the relevant cyclotomic conductor. Twisting rebuilt exact formulas avoids substituting a root symbol after its value has already evaluated.

```wolfram
input = ReflectionGenerators["G10"];
target = ReflectionGenerators["G10", 5];
twistedBasis = CovariantBasis[input, 5, {x, y}, target];
HSOPQ[First[twistedBasis], {x, y}]
(* True *)
```

A target twist differs from replacing **both** representations by their conjugates. For example, `CovariantBasis[ReflectionGenerators["G10",31],7,{x,y}]` returns `{}`: no nonzero degree-7 covariant exists for that input and target. Here `31` is the root exponent and `7` the polynomial degree.

## Functions and files

| Function | Purpose |
| --- | --- |
| `GroupNames[]` | List `B2`, `G4`, `G5`, `G6`, `G8`, `G9`, `G10`, `G14`, `G25` |
| `ReflectionGenerators[name,p:1]` | Build exact matrices, optionally conjugated |
| `HomogeneousMonomials[vars,degree]` | Build the complete monomial basis |
| `CovariantSystem[input,degree,vars,target:Automatic]` | Inspect polynomial vector, fresh coefficient symbols, equations, and matrix |
| `CovariantBasis[input,degree,vars,target:Automatic]` | Solve the homogeneous linear equations exactly |
| `EquivarianceResiduals[...]`, `EquivariantQ[...]` | Check the actual representation identity |
| `HSOPReport[polys,vars]`, `HSOPQ[polys,vars]` | Check positive homogeneity and complex common zeros |
| `NotebookCases[]` | Inspect recorded example degrees, twists, and source filenames |
| `NotebookCandidateNames[]`, `NotebookCandidate[name,vars]` | Retrieve named explicit polynomial vectors |

`ReflectionHSOP.wl` loads `groups.wl`, `solver.wl`, `validation.wl`, and `candidates.wl`. Each module is short and has one responsibility. `examples/basic.wls` demonstrates the main workflows.

The equations use coefficients of polynomial identities and exact null spaces. Matrix entries are converted to a shared algebraic number field with [ToNumberField](https://reference.wolfram.com/language/ref/ToNumberField.html) before elimination to control radical expression growth. The separate HSOP check asks whether there is a nonzero common zero over the complex numbers, using [Wolfram's `Reduce`](https://reference.wolfram.com/language/ref/Reduce.html). This is the finite-dimensional quotient criterion for these homogeneous systems. It may be more expensive at high degrees. Unresolved verification returns `Failure`, never an assumed success.

## Named polynomial examples

`NotebookCandidate[name, vars]` includes successful HSOPs and examples that deliberately fail one of the required checks. A vector can be an HSOP without being equivariant for the requested group, or equivariant without being an HSOP. Check both properties when selecting an example.

| Candidate name | Verified equivariance | HSOP? |
| --- | --- | --- |
| `B2-degree7` | B2, untwisted | No |
| `G4-degree15` | G4, untwisted | Yes |
| `G5-degree7` | G5, untwisted | Yes |
| `G5-twist5-degree5` | G5, target twist 5 | Yes |
| `G6-degree21` | G6, untwisted | Yes |
| `G8-degree5` | G8, untwisted | Yes |
| `G9-degree17` | G9, untwisted | Yes |
| `G14-degree19` | G14, untwisted | Yes |
| `G10-notebook-degree7` | G5, untwisted; fails G10 target twists 1, 5, 7, 11 | Yes |
| `G10-notebook-degree13-a` | G10, untwisted | Yes |
| `G10-notebook-degree13-b` | G10, untwisted | No |
| `B2-coordinate-powers5` | Fails B2 equivariance | Yes |
| `G9-coordinate-powers41` | Fails G9 equivariance | Yes |

The `G10-notebook` names retain historical labels; use the verified representation in the table rather than inferring it from the name. `G14-degree19` uses an exact reconstruction of the recorded numerical coefficients, verified with exact substitution and common-zero checks.

The degree-7 B2 example in `examples/basic.wls`, `{y^7 + (x-y)^7, y^7}`, passes both checks. For G10 degree 13, candidate `a` supplies an HSOP in the two-dimensional untwisted covariant space. Both failed HSOP vectors in the table vanish at the nonzero point `{1,0}`.

For G25 in degree 4, the complete untwisted covariant basis is

```wolfram
{{x y^3 - x z^3, -x^3 y + y z^3, x^3 z - y^3 z}}
```

The displayed vector vanishes at `{1,1,1}`, so every scalar multiple fails the HSOP condition. This degree has covariants but no HSOP of the requested type.

## Run the tests and example

From the package directory (the folder containing `gap3` and `wolfram`):

```sh
wolframscript -file wolfram/run-tests.wls
wolframscript -file wolfram/examples/basic.wls
```

If `wolframscript` cannot locate an installed Wolfram kernel on a Mac with Wolfram.app, use:

```sh
/Applications/Wolfram.app/Contents/MacOS/WolframKernel -noprompt -script wolfram/run-tests.wls
```

The test runner exits with status 0 only when the whole report passes. Tests cover exact coefficient recovery, genuine target twists, three-coordinate `G25`, invalid inputs, independence from previous notebook coefficient values, and the distinction between equivariance and an HSOP.

For recorded test results and supported scope, see [VALIDATION.md](VALIDATION.md).
