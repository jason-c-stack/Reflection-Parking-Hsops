EquivariantQ[polys_List, vars_List, input_List, target_ : Automatic] := Module[{residuals},
  If[!FreeQ[polys, _Real], Return[Failure["InexactCoefficients", <||>]]];
  residuals = EquivarianceResiduals[polys, vars, input, target];
  If[FailureQ[residuals], Return[residuals]];
  AllTrue[Flatten[(Last /@ CoefficientRules[#, vars]) & /@ residuals], exactZeroQ]
];

(* An equivariant polynomial vector need not be an HSOP. This is a separate test. *)
HSOPReport[polys_List, vars_List] := Module[
  {rules, coefficients, degrees, nonzeroZeros},
  If[!validVariablesQ[vars] || Length[polys] =!= Length[vars] ||
      !AllTrue[polys, PolynomialQ[#, vars] &],
    Return[Failure["InvalidPolynomialVector", <||>]]];
  rules = CoefficientRules[Expand[#], vars] & /@ polys;
  coefficients = Flatten[(Last /@ #) & /@ rules];
  If[!AllTrue[coefficients, exactAlgebraicQ],
    Return[Failure["NonExactCoefficients", <|"Message" -> "Specialize all parameters to exact algebraic numbers first."|>]]];
  If[AnyTrue[polys, exactZeroQ], Return[<|"HSOP" -> False, "Reason" -> "ZeroComponent"|>]];
  degrees = DeleteDuplicates[Total /@ (First /@ #)] & /@ rules;
  If[!AllTrue[degrees, Length[#] === 1 && First[#] > 0 &],
    Return[<|"HSOP" -> False, "Reason" -> "NotPositiveHomogeneous"|>]];
  nonzeroZeros = Quiet[Check[
    Reduce[And @@ ((# == 0 &) /@ polys) && Or @@ ((# != 0 &) /@ vars), vars, Complexes], $Failed]];
  If[nonzeroZeros === $Failed || !FreeQ[nonzeroZeros, _Reduce],
    Return[Failure["CommonZeroCheckFailed", <||>]]];
  <|"HSOP" -> (nonzeroZeros === False), "Degrees" -> Flatten[degrees],
    "NonzeroCommonZeros" -> nonzeroZeros|>
];

HSOPQ[polys_List, vars_List] := Module[{report = HSOPReport[polys, vars]},
  If[FailureQ[report], report, report["HSOP"]]
];

EquivariantQ[___] := Failure["InvalidArguments", <||>];
HSOPReport[___] := Failure["InvalidArguments", <||>];
HSOPQ[___] := Failure["InvalidArguments", <||>];
