(*===========*)
(*  Chapter  *)
(*===========*)

Chapter[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("    ## "<>Expr);
	,
		CellPrint@TextCell[Expr,30,Darker@Green,Underlined,Bold,"Text"];
	];
];
