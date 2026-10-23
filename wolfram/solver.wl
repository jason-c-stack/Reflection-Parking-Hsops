(* Coefficients are fresh local symbols. No global x, y, a0, ... are assigned. *)
validVariablesQ[vars_] := ListQ[vars] && Length[vars] > 0 &&
  AllTrue[vars, MatchQ[#, _Symbol] &] && DuplicateFreeQ[vars];
nonnegativeIntegerQ[n_] := IntegerQ[n] && n >= 0;
exactAlgebraicQ[value_] := FreeQ[value, _Real] && TrueQ[Element[value, Algebraics]];
exactZeroQ[value_] := TrueQ[RootReduce[value] == 0];

validGeneratorsQ[generators_, n_] := ListQ[generators] && Length[generators] > 0 &&
  AllTrue[generators, Dimensions[#] === {n, n} &&
    AllTrue[Flatten[#], exactAlgebraicQ] && !exactZeroQ[Det[#]] &];

exponentVectors[d_, 1] := {{d}};
exponentVectors[d_, n_] := Flatten[
  Table[Prepend[#, i] & /@ exponentVectors[d - i, n - 1], {i, 0, d}], 1];

HomogeneousMonomials[vars_List, degree_?nonnegativeIntegerQ] :=
  If[validVariablesQ[vars],
    (Times @@ MapThread[Power, {vars, #}] &) /@ exponentVectors[degree, Length[vars]],
    Failure["InvalidVariables", <|"Variables" -> vars|>]];

EquivarianceResiduals[polys_List, vars_List, input_List, target_ : Automatic] := Module[
  {output = If[target === Automatic, input, target], n = Length[vars]},
  If[!validVariablesQ[vars] || Length[polys] =!= n ||
      !AllTrue[polys, PolynomialQ[#, vars] &] || !validGeneratorsQ[input, n] ||
      !validGeneratorsQ[output, n] || Length[input] =!= Length[output],
    Return[Failure["InvalidRepresentations", <||>]]];
  Flatten[MapThread[
    Function[{g, h}, Expand[(polys /. Thread[vars -> Transpose[g].vars]) - Transpose[h].polys]],
    {input, output}]]
];

CovariantSystem[input_List, degree_?nonnegativeIntegerQ, vars_List, target_ : Automatic] := Module[
  {monomials, coefficients, vector, residuals, equations, matrix, count},
  monomials = HomogeneousMonomials[vars, degree];
  If[FailureQ[monomials], Return[monomials]];
  count = Length[vars] Length[monomials];
  coefficients = Table[Unique["coefficient$"], {count}];
  vector = Partition[coefficients, Length[monomials]].monomials;
  residuals = EquivarianceResiduals[vector, vars, input, target];
  If[FailureQ[residuals], Return[residuals]];
  equations = DeleteDuplicates[Flatten[
    (Last /@ CoefficientRules[#, vars]) & /@ residuals]];
  equations = Select[equations, # =!= 0 &];
  matrix = If[equations === {}, {},
    Table[RootReduce[Coefficient[eq, c]], {eq, equations}, {c, coefficients}]];
  matrix = DeleteDuplicates[DeleteCases[matrix, ConstantArray[0, count]]];
  equations = If[matrix === {}, {}, matrix.coefficients];
  <|"Variables" -> vars, "Degree" -> degree, "Monomials" -> monomials,
    "Coefficients" -> coefficients, "PolynomialVector" -> vector,
    "Equations" -> ((# == 0 &) /@ equations), "Matrix" -> matrix|>
];

CovariantBasis[input_List, degree_?nonnegativeIntegerQ, vars_List, target_ : Automatic] := Module[
  {system, kernel, width, fieldMatrix},
  system = CovariantSystem[input, degree, vars, target];
  If[FailureQ[system], Return[system]];
  width = Length[system["Monomials"]];
  (* A shared algebraic number field avoids radical expression swell. *)
  fieldMatrix = If[system["Matrix"] === {}, {}, Partition[
    ToNumberField[Flatten[system["Matrix"]]], Length[system["Coefficients"]]]];
  kernel = If[fieldMatrix === {}, IdentityMatrix[Length[system["Coefficients"]]],
    NullSpace[fieldMatrix, ZeroTest -> exactZeroQ]];
  (RootReduce /@ (Partition[#, width].system["Monomials"]) &) /@ kernel
];

HomogeneousMonomials[___] := Failure["InvalidArguments", <|"Expected" -> "Distinct symbols and a nonnegative integer degree."|>];
CovariantSystem[___] := Failure["InvalidArguments", <|"Expected" -> "Exact generator lists, nonnegative integer degree, and distinct symbols."|>];
CovariantBasis[___] := Failure["InvalidArguments", <|"Expected" -> "Exact generator lists, nonnegative integer degree, and distinct symbols."|>];
EquivarianceResiduals[___] := Failure["InvalidArguments", <||>];
