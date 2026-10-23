(* Matrices retain the notebook convention; polynomial actions use Transpose. *)
GroupNames[] := {"B2", "G4", "G5", "G6", "G8", "G9", "G10", "G14", "G25"};

ReflectionGenerators[name_String, p_Integer : 1] := Module[
  {conductors, n, q, r, z3, z4, z8, z12, z24, generators},
  conductors = <|"B2" -> 1, "G4" -> 3, "G5" -> 3, "G6" -> 12,
    "G8" -> 4, "G9" -> 8, "G10" -> 12, "G14" -> 24, "G25" -> 3|>;
  If[!KeyExistsQ[conductors, name],
    Return[Failure["UnknownGroup", <|"Name" -> name, "Available" -> GroupNames[]|>]]];
  n = conductors[name];
  If[!CoprimeQ[p, n], Return[Failure["InvalidTwist", <|"Twist" -> p, "Conductor" -> n|>]]];
  {z3, z4, z8, z12, z24} = RootReduce[Exp[2 Pi I p/#] & /@ {3, 4, 8, 12, 24}];
  generators = Switch[name,
    "B2", {{{-1, 0}, {2, 1}}, {{1, 1}, {0, -1}}},
    "G4", {DiagonalMatrix[{1, z3}],
      {{(z3 - z3^2)/3, (2 z3 + z3^2)/3},
       {(4 z3 + 2 z3^2)/3, (-z3 - 2 z3^2)/3}}},
    "G5", {DiagonalMatrix[{1, z3}],
      {{(-z3 - 2 z3^2)/3, (-2 z3 - z3^2)/3},
       {(-4 z3 - 2 z3^2)/3, (z3 - z3^2)/3}}},
    "G6", q = (-z12^7 + z12^11)/3;
      {DiagonalMatrix[{1, z3}], {{q, q}, {2 q, -q}}},
    "G8", {DiagonalMatrix[{1, z4}],
      {{(1 + z4)/2, (-1 + z4)/2}, {(-1 + z4)/2, (1 + z4)/2}}},
    "G9", q = (z8 - z8^3)/2;
      {DiagonalMatrix[{1, z4}], {{q, 1}, {1/2, -q}}},
    "G10", {DiagonalMatrix[{1, z3}],
      {{(-2 z12^4 - 2 z12^7 - z12^8 - z12^11)/3,
         (z12^4 + z12^7 - z12^8 - z12^11)/6},
       {(z12^4 + z12^7 - z12^8 - z12^11)/3,
         (-z12^4 - z12^7 - 2 z12^8 - 2 z12^11)/3}}},
    "G14", {DiagonalMatrix[{1, -1}],
      {{(z24 - z24^16 + z24^19)/2, z3^2/2},
       {-z3^2/2, (-z24 - z24^16 - z24^19)/2}}},
    "G25", q = (-z3 - 2 z3^2)/3; r = (2 z3 + z3^2)/3;
      {DiagonalMatrix[{1, z3, 1}], DiagonalMatrix[{1, 1, z3}],
        {{q, r, r}, {r, q, r}, {r, r, q}}}
  ];
  Map[RootReduce, generators, {3}]
];

ReflectionGenerators[___] := Failure["InvalidArguments", <|"Expected" -> "Group name and integer twist coprime to its conductor."|>];

(* A changed coefficient normalization only selects a vector in the same space. *)
NotebookCases[] := {
  <|"Source" -> "B2_relatetoG5.nb", "Group" -> "B2", "Degree" -> 7, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G4_hsops.nb", "Group" -> "G4", "Degree" -> 15, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G5.nb", "Group" -> "G5", "Degree" -> 7, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G5_chatgptversion.nb", "Group" -> "G5", "Degree" -> 7, "InputTwist" -> 1, "TargetTwist" -> 1,
    "Note" -> "Replaces the original tautological equation with genuine equivariance."|>,
  <|"Source" -> "G5_twisted.nb", "Group" -> "G5", "Degree" -> 7, "InputTwist" -> 1, "TargetTwist" -> 7|>,
  <|"Source" -> "G6_hsop.nb", "Group" -> "G6", "Degree" -> 5, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G6_hsop.nb", "Group" -> "G6", "Degree" -> 21, "InputTwist" -> 1, "TargetTwist" -> 1,
    "Note" -> "Later explicit polynomial vector uses degree 21."|>,
  <|"Source" -> "G8.nb", "Group" -> "G8", "Degree" -> 5, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G9.nb", "Group" -> "G9", "Degree" -> 17, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G10.nb", "Group" -> "G10", "Degree" -> 13, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G14.nb", "Group" -> "G14", "Degree" -> 19, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G25_hsop.nb", "Group" -> "G25", "Degree" -> 4, "InputTwist" -> 1, "TargetTwist" -> 1|>,
  <|"Source" -> "G10hsop_31.nb", "Group" -> "G10", "Degree" -> 7, "InputTwist" -> 31, "TargetTwist" -> 31,
    "Note" -> "Both representations were conjugated; degree is 7, despite the filename."|>,
  <|"Source" -> "G10hsop_twisted(n).nb", "Group" -> "G5", "Degree" -> 5, "InputTwist" -> 1, "TargetTwist" -> 5,
    "Note" -> "Literal active matrices are G5, despite the filename. Other saved vectors have degrees 7 and 13."|>
};
