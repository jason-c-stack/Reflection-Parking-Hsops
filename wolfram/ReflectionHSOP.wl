(* Load with Get["path/to/wolfram/ReflectionHSOP.wl"]. *)
BeginPackage["ReflectionHSOP`"];

ReflectionGenerators::usage = "ReflectionGenerators[name, p:1] returns exact notebook generator matrices with roots of unity raised to p.";
GroupNames::usage = "GroupNames[] lists the supported notebook groups.";
NotebookCases::usage = "NotebookCases[] lists the source notebook degrees and twists, with provenance notes.";
HomogeneousMonomials::usage = "HomogeneousMonomials[vars, degree] returns a deterministic monomial basis.";
CovariantSystem::usage = "CovariantSystem[input, degree, vars, target:Automatic] builds exact coefficient equations for F(Transpose[g].vars)=Transpose[target].F(vars).";
CovariantBasis::usage = "CovariantBasis[input, degree, vars, target:Automatic] returns a basis of homogeneous polynomial vectors satisfying equivariance.";
EquivarianceResiduals::usage = "EquivarianceResiduals[polys, vars, input, target:Automatic] returns the exact polynomial residuals of equivariance.";
EquivariantQ::usage = "EquivariantQ[polys, vars, input, target:Automatic] checks all coefficients of the equivariance identities exactly.";
HSOPReport::usage = "HSOPReport[polys, vars] checks positive homogeneity and exact nonzero common zeros over the complex numbers.";
HSOPQ::usage = "HSOPQ[polys, vars] returns whether an exact homogeneous polynomial vector is an HSOP, or Failure when verification is unavailable.";
NotebookCandidate::usage = "NotebookCandidate[name, vars] returns a unique explicit polynomial vector preserved from the source notebooks.";
NotebookCandidateNames::usage = "NotebookCandidateNames[] lists preserved polynomial vectors.";

Begin["`Private`"];
$packageDirectory = DirectoryName[$InputFileName];
Scan[Get[FileNameJoin[{$packageDirectory, #}]] &,
  {"groups.wl", "solver.wl", "validation.wl", "candidates.wl"}];
End[];
EndPackage[];
