# Reflection-group parking functions and HSOP computations

Research code for k-noncrossing parking functions and equivariant homogeneous polynomial maps for finite complex reflection groups. The code was consolidated from GAP3/CHEVIE scripts and Mathematica notebooks. Shared algorithms are implemented once, with separate group data, examples, and regression checks.

## Start here

| Area | Contents | Instructions |
| --- | --- | --- |
| `gap3/` | Noncrossing multichains, parking functions, full support, characters, and related experiments | [GAP3 guide](docs/gap3.md) |
| `wolfram/` | Exact group data, equivariance equations, polynomial candidates, and HSOP checks | [HSOP guide](docs/hsop.md) |
| `docs/` | Source mapping, corrections, and validation evidence | [Validation](docs/VALIDATION.md) · [Original sources](docs/SOURCE_MAP.md) |

For installation requirements and runnable examples, use the guide for the corresponding language. The two parts are independent; running one does not require installing the other.

## Mathematical scope

Parking objects retain both their coset and their noncrossing chain. Counts, explicit enumeration, and fixed-point characters are separate operations so large examples can avoid materializing every object. Group and Coxeter-element choices are explicit.

For HSOP work, equivariance produces a space of candidate polynomial maps. A candidate is certified as an HSOP only after its nonzero common zeros have been excluded; equivariance alone is insufficient. Experimental formulas and incomplete searches are labeled in the language guides.

## What changed

- Repeated algorithms and notebook setup were replaced by shared functions and group definitions.
- Unfinished routines, variable mistakes, and state-dependent computations were corrected or replaced.
- Unique experiments and parameter choices are recorded rather than buried in duplicate files.
- The supplied originals were left untouched. Notebook front-end caches, screenshots of repeated code, and operating-system metadata are excluded from this package.

See [GAP3 corrections](docs/gap3-changes.md) and [HSOP corrections](docs/hsop-changes.md) for the detailed changes. [The source inventory](docs/SOURCE_MANIFEST.json) records SHA-256 hashes of every substantive supplied file.

## Add to GitHub

Follow [GITHUB.md](GITHUB.md) for GitHub Desktop, browser upload, or Terminal instructions. When adding to an existing repository, copying this entire folder as a subdirectory is the easiest way to preserve its existing files.

## Attribution and license

The supplied research code is the source of this cleanup. No new license is imposed. Follow the destination repository's licensing and attribution requirements; review any historical third-party snippets before redistribution. The source notes retain any attribution present in the supplied files.
