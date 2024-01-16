(*=========*)
(*  Title  *)
(*=========*)

Title[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("     # "<>Expr);
	,
		CellPrint@TextCell[Expr,40,Darker@Green,Underlined,Bold,"Text"];
	];
];
