(* Load ReflectionHSOP.wl first; run-tests.wls does this for you. *)

VerificationTest[Length[GroupNames[]], 9, TestID -> "all-source-groups"]
VerificationTest[Length[NotebookCases[]], 14, TestID -> "all-source-degrees-and-twists"]
VerificationTest[FailureQ[ReflectionGenerators["missing"]], True, TestID -> "unknown-group"]
VerificationTest[FailureQ[ReflectionGenerators["G10", 6]], True, TestID -> "reject-non-galois-twist"]
VerificationTest[ReflectionGenerators["G10", 31], ReflectionGenerators["G10", 7], TestID -> "root-exponents-mod-conductor"]
VerificationTest[And @@ Flatten[Table[
  TrueQ[RootReduce[Det[g]] != 0], {name, GroupNames[]}, {g, ReflectionGenerators[name]}]],
  True, TestID -> "generators-invertible"]

VerificationTest[HomogeneousMonomials[{x, y}, 2], {y^2, x y, x^2}, TestID -> "binary-monomial-order"]
VerificationTest[Length[HomogeneousMonomials[{x, y, z}, 4]], 15, TestID -> "ternary-complete-basis"]
VerificationTest[FailureQ[HomogeneousMonomials[{x, x}, 3]], True, TestID -> "distinct-variables"]
VerificationTest[FailureQ[CovariantBasis[ReflectionGenerators["G5"], -1, {x, y}]], True, TestID -> "negative-degree"]
VerificationTest[CovariantSystem[{IdentityMatrix[2]}, 2, {x, y}]["Equations"], {}, TestID -> "empty-equations"]
VerificationTest[Length[CovariantBasis[{IdentityMatrix[2]}, 2, {x, y}]], 6, TestID -> "empty-system-full-space"]
VerificationTest[FailureQ[CovariantBasis[{{{1., 0}, {0, 1.}}}, 2, {x, y}]], True, TestID -> "reject-approximate-generators"]

VerificationTest[CovariantBasis[ReflectionGenerators["G8"], 5, {x, y}],
  {{-x^5/5 + x y^4, x^4 y - y^5/5}}, TestID -> "recover-original-G8"]
VerificationTest[EquivariantQ[{x^7, y^7}, {x, y}, ReflectionGenerators["G5"]], False,
  TestID -> "reject-tautological-G5-equations"]
VerificationTest[And @@ Table[
  EquivariantQ[NotebookCandidate[c[[1]], {x, y}], {x, y}, ReflectionGenerators[c[[2]]]],
  {c, {{"G4-degree15", "G4"}, {"G5-degree7", "G5"}, {"G6-degree21", "G6"},
    {"G8-degree5", "G8"}, {"G9-degree17", "G9"}, {"G10-notebook-degree13-a", "G10"}}}],
  True, TestID -> "preserved-untwisted-covariants"]
VerificationTest[EquivariantQ[NotebookCandidate["G5-twist5-degree5", {x, y}], {x, y},
  ReflectionGenerators["G5"], ReflectionGenerators["G5", 5]], True, TestID -> "genuine-twisted-covariant"]
VerificationTest[EquivariantQ[NotebookCandidate["G10-notebook-degree7", {x, y}], {x, y},
  ReflectionGenerators["G10"]], False, TestID -> "mislabeled-G10-candidate"]
VerificationTest[EquivariantQ[NotebookCandidate["G10-notebook-degree7", {x, y}], {x, y},
  ReflectionGenerators["G5"]], True, TestID -> "mislabeled-candidate-is-G5"]

VerificationTest[HSOPQ[{x^2, y^3}, {x, y}], True, TestID -> "positive-homogeneous-HSOP"]
VerificationTest[HSOPQ[{x^2, x y}, {x, y}], False, TestID -> "reject-common-projective-zero"]
VerificationTest[HSOPQ[{x^2 + y^2, x^2 + y^2}, {x, y}], False, TestID -> "check-complex-common-zeros"]
VerificationTest[HSOPQ[{0, y^2}, {x, y}], False, TestID -> "reject-zero-component"]
VerificationTest[HSOPQ[{1, y^2}, {x, y}], False, TestID -> "reject-degree-zero"]
VerificationTest[HSOPQ[{x + x^2, y}, {x, y}], False, TestID -> "reject-inhomogeneous-vector"]
VerificationTest[FailureQ[HSOPQ[{a x^2, y^2}, {x, y}]], True, TestID -> "specialize-coefficient-parameters"]
VerificationTest[FailureQ[HSOPQ[{1. x^2, y^2}, {x, y}]], True, TestID -> "reject-inexact-HSOP-proof"]
VerificationTest[HSOPQ[NotebookCandidate["B2-degree7", {x, y}], {x, y}], False,
  TestID -> "original-B2-vector-fails-HSOP"]
VerificationTest[HSOPQ[NotebookCandidate["G10-notebook-degree13-b", {x, y}], {x, y}], False,
  TestID -> "original-G10-vector-fails-HSOP"]
VerificationTest[And @@ Table[HSOPQ[NotebookCandidate[name, {x, y}], {x, y}],
  {name, {"G4-degree15", "G5-degree7", "G5-twist5-degree5", "G6-degree21", "G8-degree5", "G9-degree17", "G10-notebook-degree13-a"}}],
  True, TestID -> "preserved-certified-HSOPs"]
VerificationTest[{EquivariantQ[{y^7 + (x - y)^7, y^7}, {x, y}, ReflectionGenerators["B2"]],
  HSOPQ[{y^7 + (x - y)^7, y^7}, {x, y}]}, {True, True}, TestID -> "corrected-B2-example"]

VerificationTest[Block[{a0 = 123, b0 = 456, c1 = 789},
  CovariantBasis[ReflectionGenerators["G25"], 4, {x, y, z}]],
  {{x y^3 - x z^3, -x^3 y + y z^3, x^3 z - y^3 z}}, TestID -> "G25-includes-all-three-coordinates-and-ignores-global-state"]
VerificationTest[HSOPQ[{x y^3 - x z^3, -x^3 y + y z^3, x^3 z - y^3 z}, {x, y, z}],
  False, TestID -> "G25-degree4-is-covariant-but-not-HSOP"]
VerificationTest[HSOPQ[{x^2, y^3, z^4}, {x, y, z}], True, TestID -> "three-dimensional-common-zero-check"]
VerificationTest[{EquivariantQ[NotebookCandidate["G14-degree19", {x, y}], {x, y}, ReflectionGenerators["G14"]],
  HSOPQ[NotebookCandidate["G14-degree19", {x, y}], {x, y}]}, {True, True}, TestID -> "exact-reconstruction-of-G14-output"]
VerificationTest[CovariantBasis[ReflectionGenerators["G10", 31], 7, {x, y}], {},
  TestID -> "G10-conjugated-input-degree7-space-is-zero"]
VerificationTest[Module[{basis = CovariantBasis[ReflectionGenerators["G10"], 5, {x, y}, ReflectionGenerators["G10", 5]]},
  {Length[basis], EquivariantQ[First[basis], {x, y}, ReflectionGenerators["G10"], ReflectionGenerators["G10", 5]],
    HSOPQ[First[basis], {x, y}]}], {1, True, True}, TestID -> "corrected-G10-target-twist"]

VerificationTest[FailureQ[EquivariantQ[{1. x, 1. y}, {x, y}, ReflectionGenerators["G5"]]],
  True, TestID -> "reject-inexact-equivariance-proof"]
