Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "ReflectionHSOP.wl"}]];
Clear[x, y, z];

(* Recover a saved vector with exact equations and certify the HSOP separately. *)
g8Basis = CovariantBasis[ReflectionGenerators["G8"], 5, {x, y}];
Print["G8 degree-5 basis: ", g8Basis];
Print["G8 HSOP report: ", HSOPReport[First[g8Basis], {x, y}]];

(* Genuine target twist: rebuild generators with the root exponent p. *)
g5Twisted = NotebookCandidate["G5-twist5-degree5", {x, y}];
Print["G5 twist-5 equivariance: ", EquivariantQ[g5Twisted, {x, y},
  ReflectionGenerators["G5"], ReflectionGenerators["G5", 5]]];

(* A corrected B2 example, added during cleanup; the original is also retained. *)
b2Corrected = {y^7 + (x - y)^7, y^7};
Print["Corrected B2 equivariance: ", EquivariantQ[b2Corrected, {x, y}, ReflectionGenerators["B2"]]];
Print["Corrected B2 HSOP: ", HSOPQ[b2Corrected, {x, y}]];

(* Degree 4 in G25 has covariants, but this one-dimensional space has no HSOP. *)
g25Basis = CovariantBasis[ReflectionGenerators["G25"], 4, {x, y, z}];
Print["G25 degree-4 basis: ", g25Basis];
Print["G25 degree-4 HSOP: ", HSOPQ[First[g25Basis], {x, y, z}]];

(* Preserve both distinct meanings of the G10 source files. *)
Print["G10 conjugated-input degree-7 basis: ", CovariantBasis[
  ReflectionGenerators["G10", 31], 7, {x, y}]];
Print["G10 target-twist-5 degree-5 basis: ", CovariantBasis[
  ReflectionGenerators["G10"], 5, {x, y}, ReflectionGenerators["G10", 5]]];
