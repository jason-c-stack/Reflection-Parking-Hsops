(* Run: wolframscript -file wolfram/run-tests.wls *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "ReflectionHSOP.wl"}]];
report = TestReport[FileNameJoin[{DirectoryName[$InputFileName], "tests", "hsop.wlt"}]];
results = report["Results"];
Print["Wolfram Language: ", $Version];
Print["Test outcomes: ", Counts[(#["Outcome"] &) /@ results]];
Print["All passed: ", report["ReportSucceeded"]];
If[!TrueQ[report["ReportSucceeded"]],
  Scan[Print, Select[results, !MemberQ[{"Success", "Succeeded"}, #["Outcome"]] &]]];
Quit[If[TrueQ[report["ReportSucceeded"]], 0, 1]];
