# Reflection group covariants and HSOPs

The Wolfram Language code replaces the repeated notebook setup with one package. It preserves all nine generator datasets, the notebook degrees and twists, and the distinct saved polynomial vectors. The originals remain unchanged.

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

The stored matrices retain the notebooks' convention. For each input matrix `g` and corresponding target matrix `h`, the equation is

```wolfram
F[Transpose[g].v] == Transpose[h].F[v]
```

Here `F` denotes the polynomial vector and `v` the variable column. Both matrix actions are transposed. The default target is the input representation. This matches the original `ss`/`tt` coordinate substitutions.

`ReflectionGenerators[name, p]` reconstructs the matrices with every defining root of unity raised to the integer `p`. The exponent must be coprime to the relevant cyclotomic conductor. Twisting rebuilt exact formulas avoids substituting a root symbol after its value has already evaluated.

```wolfram
input = ReflectionGenerators["G10"];
target = ReflectionGenerators["G10", 5];
twistedBasis = CovariantBasis[input, 5, {x, y}, target];
HSOPQ[First[twistedBasis], {x, y}]
(* True *)
```

This target twist differs from replacing **both** representations by their conjugates, as `G10hsop_31.nb` does. Its literal setting is reproduced with `CovariantBasis[ReflectionGenerators["G10",31],7,{x,y}]`, which returns `{}`. The filename's `31` is a root exponent; its active polynomial degree is 7.

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
| `NotebookCases[]` | Inspect source filenames, degrees, and twists |
| `NotebookCandidateNames[]`, `NotebookCandidate[name,vars]` | Retrieve preserved explicit polynomial data |

`ReflectionHSOP.wl` loads `groups.wl`, `solver.wl`, `validation.wl`, and `candidates.wl`. Each module is short and has one responsibility. `examples/basic.wls` demonstrates the main workflows.

The equations use coefficients of polynomial identities and exact null spaces. Matrix entries are converted to a shared algebraic number field with [ToNumberField](https://reference.wolfram.com/language/ref/ToNumberField.html) before elimination to control radical expression growth. The separate HSOP check asks whether there is a nonzero common zero over the complex numbers, using [Wolfram's `Reduce`](https://reference.wolfram.com/language/ref/Reduce.html). This is the finite-dimensional quotient criterion for these homogeneous systems. It may be more expensive at high degrees. Unresolved verification returns `Failure`, never an assumed success.

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

For original-to-new file mappings, see [SOURCE_MAP.md](SOURCE_MAP.md). The mathematical corrections and candidate outcomes are in [hsop-changes.md](hsop-changes.md).
