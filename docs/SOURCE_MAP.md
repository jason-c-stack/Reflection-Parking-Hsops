# Where the supplied code went

Every substantive input is inventoried in [SOURCE_MANIFEST.json](SOURCE_MANIFEST.json). The three `.DS_Store` files are operating-system metadata and were omitted. Original folders were read only; the package contains new, consolidated files rather than duplicate source snapshots.

## GAP3 scripts

The [GAP3 guide](gap3.md) documents the replacement API and examples. All ordinary and full-support parking computations use the same context, multichain, and coset routines.

| Original file in `Gap3 Coding` | Consolidation |
| --- | --- |
| `#gap3_CompRefGroups_Exceptional` | `gap3/context.g`, `gap3/parking.g`, and `gap3/topology.g`; mixed GAP/Sage scratchpad separated into explicit operations. Historical comment credits a translation of “Nathan's code”; no further attribution was supplied. |
| `noncrossing parking.gap` | `gap3/parking.g`, with `k=1`. |
| `k-noncrossing parking.gap` | `gap3/chains.g` and `gap3/parking.g`; broken alternate multichain draft replaced. |
| `Fuss_dog_ncpark` | `gap3/support.g`, `gap3/chains.g`, and shared parking routines. |
| `Fuss_dog_ncpark_faster` | Shared counting routine avoids listing parking objects; one multichain implementation. |
| `Fuss_dog_ncpark_wchar` | `NCParkingCharacter` and comparisons in `gap3/experiments.g`. |
| `Fuss_dog_fullsupp_break` | `gap3/support.g` and `NCFullSupportProducts`. |
| `Fuss_dog_fullsuppreflections_count` | `gap3/support.g`, product comparisons, and shared character routines. |
| `FullSuppReflcount_summeroutput` | Parameterized full-support reflection count and codegree comparison; no hard-coded group inside a group loop. |
| `General_Fuss_dog_ncpark` | Custom terminal-element restrictions through the shared API; rank-cutoff experiment documented in the GAP3 guide. |
| `Gen_Fuss_dog_ncpark_rankchecking` | Context rank data and configurable endpoint restrictions. |
| `Fuss_w_iso_exceptionals` | Shared multichains and ordinary character comparisons. |
| `exceptional_isomorphism_gap3` | Shared fixed-space and character functions. |
| `exceptional_isomorphism_Fuss_gap3` | Shared k-parking character comparisons; class representatives and multiplication corrected. |
| `wxc_iso_exceptionals` | `gap3/cyclic.g` and `NCCyclicComparison`, for `k=1`. |
| `wxc_iso_exceptionals_fast` | Same cyclic implementation and cached parabolics/cosets. |
| `wxc_iso_exceptionals_faster` | Same implementation; totals are no longer reset inside the noncrossing-element loop. |
| `Support_intersections_nc` | `NCSupportIntersectionReport(ctx, ctx.nc)`. |
| `Support_intersections_w` | Same report with `Elements(ctx.W)`. |
| `w_fullsupp_andor_pi_fullsupp` | Full-support endpoint restriction in the shared parking API. The original active computation restricted the chain endpoint; it did not implement an additional independent restriction on coset representatives. |
| `Poset Topology Code.gap` | `gap3/topology.g`; distinct cosets and strict inclusion relations for a subsequent topology computation. |
| `RandomStuff_Ididntwannadelete` | `NCFixedSpaceDimension`, using nullspace dimension instead of counting fixed ambient basis vectors. |
| `Fussnoncrossing_code_screenshot1.png` | Visual duplicate of the textual multichain routine; excluded from the package. |
| `Fussnoncrossing_code_screenshot2.png` | Visual duplicate of the textual k-parking routine; excluded from the package. |
| `noncrossing_code_screenshot.png` | Per-parabolic coset-count variant of the ordinary computation (G5); covered by the shared count. |

The original topology scratchpad included a Sage `Poset(...).order_complex().homology()` sketch. The package supplies the underlying poset data and an optional `NCWriteSagePoset` export that builds the order complex and computes homology in Sage. No blanket homology result is claimed.

## Mathematica notebooks

The [HSOP guide](hsop.md) lists the group definitions, original degree/twist settings, and runnable examples. The original input cells were read as text; stored notebook outputs were not treated as fresh verification.

| Original folder | Original notebook | Consolidation |
| --- | --- | --- |
| `HSOPs` | `B2_relatetoG5.nb` | B2 group data and its relationship experiment; the saved degree-seven vector is retained as historical data and separately checked. See the HSOP guide. |
| `HSOPs` | `G4_hsops.nb` | Shared polynomial-map solver with G4 data and recorded degree settings. |
| `HSOPs` | `G5.nb` | G5 data and shared solver. |
| `HSOPs` | `G5_chatgptversion.nb` | Same G5 data; tautological substitution equations replaced by actual equivariance equations. |
| `HSOPs` | `G5_twisted.nb` | Explicit G5 target-representation twist. |
| `HSOPs` | `G6_hsop.nb` | G6 data and shared solver. |
| `HSOPs` | `G8.nb` | G8 data and shared solver. |
| `HSOPs` | `G9.nb` | G9 data and shared solver. |
| `HSOPs` | `G10.nb` | G10 data and shared solver. |
| `HSOPs` | `G14.nb` | G14 data, shared solver, and an exact reconstruction of the saved numerical candidate, freshly checked. |
| `HSOPs` | `G25_hsop.nb` | Rank-three G25 data and shared solver; its degree-four covariant space has no HSOP. |
| `G10 HSOP Code` | `G10hsop_31.nb` | Shared exact coefficient equations; the original degree-seven, input/target-twist-31 setting has no nonzero covariant. |
| `G10 HSOP Code` | `G10hsop_twisted(n).nb` | Its supplied generator data identified as G5; preserved with the correct label and a separate G10 example. |

See [HSOP corrections](hsop-changes.md) for details and any unresolved source-data discrepancies. Reusable source files replace notebook presentation metadata, stale outputs, global coefficient lists, and repeated setup cells.
