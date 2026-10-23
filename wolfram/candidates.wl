(* Unique explicit vectors from the notebooks. These are preserved research data,
   not a claim that every vector passes equivariance or the HSOP check. *)
NotebookCandidateNames[] := {"B2-degree7", "G4-degree15", "G5-degree7",
  "G5-twist5-degree5", "G6-degree21", "G14-degree19", "G8-degree5", "G9-degree17",
  "G10-notebook-degree7", "G10-notebook-degree13-a", "G10-notebook-degree13-b",
  "B2-coordinate-powers5", "G9-coordinate-powers41"};

NotebookCandidate[name_String, vars_List] := Module[{x, y, vector},
  If[!validVariablesQ[vars] || Length[vars] =!= 2,
    Return[Failure["InvalidVariables", <|"ExpectedDimension" -> 2|>]]];
  {x, y} = vars;
  vector = Switch[name,
    "B2-degree7",
      {x^5 y^2 - 5 x^4 y^3 + 10 x^3 y^4 - 9 x^2 y^5 + 3 x y^6,
       x^2 y^5 - 2 x y^6 + y^7},
    "G4-degree15",
      {131 x^15/405 + 131 x^12 y^3/81 - 13967 x^9 y^6/81 +
         48133 x^6 y^9/81 + 3695 x^3 y^12/81 - 6052 y^15/405,
       x^14 y + x^11 y^4 + x^8 y^7 + 2337 x^5 y^10/5 - 241 x^2 y^13},
    "G5-degree7",
      {2 x^7/21 + 22 x^4 y^3/3 + 14 x y^6/3,
       x^6 y + x^3 y^4 - 18 y^7/7},
    "G5-twist5-degree5",
      {-x^5 - 10 x^2 y^3, 4 y^5 - 5 x^3 y^2},
    "G6-degree21",
      {904 x^21/3159 + 10265 x^18 y^3/3159 + 115585 x^15 y^6/1053 +
         642709 x^12 y^9/243 + 2722829 x^9 y^12/243 +
         390056 x^6 y^15/81 - 448526 x^3 y^18/243 - 8536 y^21/243,
       x^20 y + x^17 y^4 + x^14 y^7 + x^11 y^10 +
         74303 x^8 y^13/13 + 131987 x^5 y^16/13 + 13330 x^2 y^19/13},
    "G8-degree5",
      {-x^5/5 + x y^4, x^4 y - y^5/5},
    "G9-degree17",
      {1984 x^17/17 + 1200 x^13 y^4 + 1540 x^9 y^8 + x^5 y^12 + x y^16,
       256 x^16 y + 16 x^12 y^5 + 1540 x^8 y^9 + 75 x^4 y^13 + 31 y^17/68},
    "G14-degree19",
      {65 x^19/209 - 69 x^17 y^2/11 + 604 x^15 y^4/33 -
         196 x^13 y^6/33 - 942 x^11 y^8/11 - 446 x^9 y^10/3 +
         116 x^7 y^12/3 + 28 x^5 y^14 + x^3 y^16 + x y^18,
       x^18 y + x^16 y^3 + 28 x^14 y^5 + 116 x^12 y^7/3 -
         446 x^10 y^9/3 - 942 x^8 y^11/11 - 196 x^6 y^13/33 +
         604 x^4 y^15/33 - 69 x^2 y^17/11 + 65 y^19/209},
    "G10-notebook-degree7",
      {x^7/48 - 37 x^4 y^3/12 - 11 x y^6/3,
       -9 x^6 y/16 + x^3 y^4 + y^7},
    "G10-notebook-degree13-a",
      {-x^13 + 218 x^10 y^3 - 1014 x^7 y^6 + 392 x^4 y^9 + 896 x y^12,
       -14 x^12 y + 49 x^9 y^4 + 1014 x^6 y^7 + 1744 x^3 y^10 + 64 y^13},
    "G10-notebook-degree13-b",
      {10 x^10 y^3 - 78 x^7 y^6 - 24 x^4 y^9 + 64 x y^12,
       -x^12 y - 3 x^9 y^4 + 78 x^6 y^7 + 80 x^3 y^10},
    "B2-coordinate-powers5", {x^5, y^5},
    "G9-coordinate-powers41", {x^41, y^41},
    _, Return[Failure["UnknownCandidate", <|"Name" -> name|>]]
  ];
  vector
];
