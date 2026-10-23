# HSOP corrections and preserved research results

The notebooks were inspected as text. Input cells were decoded from their `RowBox` structures without evaluating entire notebooks. Notebook instructions, cached outputs, and saved session state were treated as source material. The rewritten package was evaluated separately in a clean Wolfram kernel.

## Corrections

- Replaced finite coordinate grids with coefficient equations for complete polynomial identities. A finite grid is not generally enough to prove an identity at the degrees used in these notebooks.
- Replaced repeated `NSolve` calls with exact linear algebra. The solutions retain exact roots of unity and rational coefficients instead of numerical noise.
- Replaced global `a0`, `b0`, `x`, `y`, and similar assignments with fresh coefficient symbols and explicit variables. Degree changes no longer depend on which cells ran previously.
- Corrected the `G5_chatgptversion.nb` equation: its two sides both performed the same polynomial substitution, so the comparison was a tautology. The package compares the input action on a polynomial vector with the target action on its values.
- Corrected `G10hsop_31.nb`'s solve-variable problem (`Join[x,y]`), preserving its actual degree-7, conjugated-input-and-target setting. That equivariant space is zero.
- Included all three coefficient families for `G25`. The original solve listed only the first two. The exact degree-4 covariant space is one dimensional; its vectors fail the HSOP condition.
- Reconstructed twists from the defining root formulas. Substitution into an already evaluated root expression is unreliable, particularly after simplification.
- Added an independent HSOP check. Equivariance alone does not exclude nonzero common zeros.
- Used the public name `ReflectionGenerators` because Wolfram already has a protected built-in `GroupGenerators`.

## Source settings and naming corrections

`NotebookCases[]` records all 13 source filenames. `G6_hsop.nb` has an active degree-5 setup and a later saved degree-21 vector; both settings are retained.

`G10hsop_twisted(n).nb`'s active header defines the **G5** matrices, despite its filename. Its active setting is degree 5 with target twist 5. The package preserves that literal setting under `G5`. It also provides an explicitly identified `G10` degree-5 target-twist-5 example using the full `G10` matrix from `G10.nb`; that example passes equivariance and the HSOP check.

The same desktop notebook contains degree-7 and degree-13 saved expressions from other session states. Their names retain `G10-notebook` as provenance, and the table below identifies the representations they actually satisfy. Their degree or representation is not inferred from the active header.

Original coefficient normalizations select particular vectors in a covariant space. The general solver retains the full space rather than hard-coding these normalizations. Explicit distinct vectors are preserved in `candidates.wl`. `G14-degree19` reconstructs the rational coefficients of the saved numerical output; the reconstructed vector satisfies the source's normalizations and was independently checked with exact equivariance and common-zero calculations.

## Exact validation of saved vectors

| Candidate name | Verified equivariance | HSOP? | Interpretation |
| --- | --- | --- | --- |
| `B2-degree7` | `B2`, untwisted | No | Both components vanish on a nonzero coordinate point |
| `G4-degree15` | `G4`, untwisted | Yes | Preserved vector |
| `G5-degree7` | `G5`, untwisted | Yes | Complex-looking source coefficients simplify to rationals |
| `G5-twist5-degree5` | `G5`, target twist 5 | Yes | From the mislabeled desktop notebook |
| `G6-degree21` | `G6`, untwisted | Yes | Preserved later degree-21 vector |
| `G8-degree5` | `G8`, untwisted | Yes | Recovered directly as the computed basis |
| `G9-degree17` | `G9`, untwisted | Yes | Preserved vector |
| `G14-degree19` | `G14`, untwisted | Yes | Exact reconstruction of the saved numerical solution |
| `G10-notebook-degree7` | `G5`, untwisted | Yes | Fails `G10` target twists 1, 5, 7, and 11 |
| `G10-notebook-degree13-a` | `G10`, untwisted | Yes | Preserved successful degree-13 vector |
| `G10-notebook-degree13-b` | `G10`, untwisted | No | Equivariant but has a nonzero common zero |
| `B2-coordinate-powers5` | Fails `B2` equivariance | Yes | Preserved coordinate-power experiment |
| `G9-coordinate-powers41` | Fails `G9` equivariance | Yes | Preserved coordinate-power experiment |

The `B2` degree-7 example added during cleanup is

```wolfram
{y^7 + (x-y)^7, y^7}
```

It passes both checks for the original `B2` matrices. It is explicitly new, and the failed original remains available as historical data. For `G10` degree 13, candidate `a` supplies a validated example alongside the failed candidate `b`.

For `G25`, the complete degree-4 basis is

```wolfram
{{x y^3 - x z^3, -x^3 y + y z^3, x^3 z - y^3 z}}
```

Its vector vanishes at `{1,1,1}`, so every scalar multiple fails the HSOP condition. No claim about other degrees is made.

The listed candidate identities and common-zero results were checked in Wolfram Language 14.2.1 and independently against exact cyclotomic polynomial calculations in SageMath. The nine generator sets were also independently checked for their expected finite group orders and reflection ranks. These checks concern the supplied cases and code; they do not prove a general existence conjecture.
