# Reflection-group parking functions and HSOP computations

Research code for k-noncrossing parking functions and equivariant homogeneous polynomial maps for finite complex reflection groups. The code was consolidated from GAP3/CHEVIE scripts and Mathematica notebooks. Shared algorithms are implemented once, with separate group data, examples, and regression checks.

## Start here

| Area | Contents | Instructions |
| --- | --- | --- |
| `gap3/` | Noncrossing multichains, parking functions, full support condition, characters, and related experiments | [GAP3 guide](docs/gap3.md) |
| `wolfram/` | Exact group data, equivariance equations, polynomial candidates, and HSOP checks | [HSOP guide](docs/hsop.md) |
| `docs/` | Source mapping, corrections, and validation evidence | [Validation](docs/VALIDATION.md) · [Original sources](docs/SOURCE_MAP.md) |

For installation requirements and runnable examples, use the guide for the corresponding language. The two parts are independent; running one does not require installing the other.

## Research Context

Noncrossing parking objects are built out of noncrossing partitions using cosets of corresponding noncrossing parabolics. This code explores the action of the underlying group on its noncrossing parking functions via left multiplication, and its cyclic action as a generalized Kreweras action. It also computes explicit enumeration and character counts. 

The algebraic parking space is built out of certain homogeneous systems of parameters (hsops) for the group. We use the code here to check the existence of these hsops, and build explicit hsops. For HSOP work, equivariance produces a space of candidate polynomial maps. A candidate is certified as an HSOP only after its nonzero common zeros have been excluded; equivariance alone is insufficient. Experimental formulas and incomplete searches are labeled in the language guides.

