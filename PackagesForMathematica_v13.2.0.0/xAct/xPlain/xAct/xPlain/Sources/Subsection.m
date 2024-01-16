(*==============*)
(*  Subsection  *)
(*==============*)

Subsection[Expr_?ListQ]:=If[$xPlainCLI,
		DisplayCLI@("   #### "<>StringJoin@Expr);,
		CellPrint@Cell[TextData@Flatten@Expr,
				30,
				Darker@Green,
				Underlined,Bold,
				"Text",
				CellContext->"Global`"];
];

Subsection[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI@("  #### "<>Expr);
	,
		CellPrint@TextCell[Expr,30,Darker@Green,Underlined,Bold,"Text"];
	];
];
