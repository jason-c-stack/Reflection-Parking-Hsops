# Independent mathematical and computational review

Reviewed 20 October 2026. Original scripts and notebooks were read without changing them. These checks supplement the repository's regression suites.

## GAP3 checks

The consolidated implementation was run with the locally installed GAP3/CHEVIE. For G4, G5, G6, G8, G10, and G14:

- Explicit parking-object enumeration agrees with the dynamic counts for k=1 and k=2.
- Directly applying each conjugacy-class representative to every coset agrees with the computed W-character for both k values.
- The k=1 cyclic character comparison passes for every residue modulo the Coxeter-element order and every conjugacy class.

For G4, an additional direct check verifies that the cyclic action stays in the parking set, is independent of the chosen representative of each left coset, and satisfies the W × C composition law.

The left-coset convention agrees with the [GAP3 manual](https://webusers.imj-prg.fr/~jean.michel/gap3/htm/chap007.htm): a left coset is represented as gH. The implementation's k=1 cyclic convention matches [Definition 3.4 of the parking-space paper](https://arxiv.org/html/2502.01970v1#S3.SS1): the coset representative becomes wgc^(-d), while the noncrossing element is conjugated by c^d.

The k>1 Fuss cyclic action requires generalized rotation of order kh. Entrywise conjugation is insufficient. This package correctly limits its cyclic functions to k=1. W-actions and multichain enumeration support positive integer k.

## Independent exact polynomial checks

SageMath 10.4 was used with an exact cyclotomic field, independently of the Wolfram helper routines. Every generator has rank(g−I)=1. Exhaustive matrix multiplication gives these group orders:

| Dataset | Order |
| --- | ---: |
| B2 | 8 |
| G4 | 24 |
| G5 | 72 |
| G6 | 48 |
| G8 | 96 |
| G9 | 192 |
| G10 | 288 |
| G14 | 144 |
| G25 | 648 |

For the original exact binary polynomial vectors listed below, exact polynomial substitution checked equivariance. A polynomial gcd check separately tested for nonzero common zeros. For two positive-degree homogeneous binary forms, a nonconstant gcd is equivalent to a common projective zero.

| Preserved vector | Equivariance in the stated basis | HSOP |
| --- | --- | --- |
| B2-degree7 | B2, untwisted | No |
| G4-degree15 | G4, untwisted | Yes |
| G5-degree7 | G5, untwisted | Yes |
| G5-twist5-degree5 | G5, target twist 5 | Yes |
| G6-degree21 | G6, untwisted | Yes |
| G8-degree5 | G8, untwisted | Yes |
| G9-degree17 | G9, untwisted | Yes |
| G14-degree19 | G14, untwisted | Yes |
| G10-notebook-degree7 | G5, untwisted; fails G10 twists 1, 5, 7, 11 | Yes |
| G10-notebook-degree13-a | G10, untwisted | Yes |
| G10-notebook-degree13-b | G10, untwisted | No |
| B2-coordinate-powers5 | Fails B2 equivariance | Yes |
| G9-coordinate-powers41 | Fails G9 equivariance | Yes |

For both failed HSOP vectors, (x,y)=(1,0) is an exact nonzero common zero. Their equivariance therefore does not certify an HSOP. Conversely, coordinate powers can be an HSOP without satisfying the required representation identity.

The G10-titled twisted notebook's active matrices generate the order-72 group G5. The genuine G10 matrices in the other notebook generate the order-288 group. Keeping these cases separately labeled prevents a filename from overriding the actual computation.

The reconstructed G14 degree-19 vector also passes the independent exact substitution and gcd checks. All six coefficient normalizations agree with the original notebook: a1=a3=b16=b18=1 and a5=b14=28.

An independent exact coefficient-equation solver in Sage also gives these dimensions of the covariant spaces:

| Group / degree | Input twist | Target twist | Dimension | Further check |
| --- | ---: | ---: | ---: | --- |
| G8 / 5 | 1 | 1 | 1 | A nonzero basis vector is an HSOP. |
| G25 / 4 | 1 | 1 | 1 | A nonzero basis vector is not an HSOP: its common-zero ideal has positive dimension. |
| G10 / 5 | 1 | 5 | 1 | A nonzero basis vector is an HSOP. |
| G10 / 13 | 1 | 1 | 2 | The preserved degree13-a vector is an HSOP. |
| G10 / 7 | 31 | 31 | 0 | The original setting admits only the zero vector. |

Twists 31 and 7 agree on the conductor-12 G10 matrices. The Sage solver generated all monomials of the requested total degree and equated every coefficient of each generator identity; it did not sample numerical points or use the Wolfram package's solver.

## Scope and preservation

The source map accounts for the distinct categories of supplied computations: ordinary/Fuss parking enumeration, full-support restrictions, W and k=1 W × C character experiments, support intersections, rank restrictions, codegree products, coset-poset topology, group data, Galois twists, and explicit polynomial vectors. Screenshots duplicate supplied textual computations.

Full support is relative to the generators of the chosen Coxeter word. The reflection-count product is intended for irreducible groups with one zero codegree; filtering that zero avoids dependence on codegree ordering. Neither experimental identities nor historical “verified through G…” comments constitute fresh checks of every exceptional group. Tests of finite examples do not establish a theorem for arbitrary groups, k, or polynomial degrees.
