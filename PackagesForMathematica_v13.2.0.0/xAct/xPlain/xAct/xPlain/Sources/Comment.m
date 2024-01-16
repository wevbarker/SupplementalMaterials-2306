(*===========*)
(*  Comment  *)
(*===========*)

Comment[Expr_?ListQ]:=If[$xPlainCLI,
	DisplayCLI[("  ---> "<>StringJoin@@Flatten@Expr),StyleCLI->"Comment"];
,
	CellPrint@Cell[TextData@Flatten@Expr,Darker@Green,"Text",CellContext->"Global`"];
];
Comment[Expr_?StringQ]:=Module[{},
	If[$xPlainCLI,
		DisplayCLI[("  ---> "<>Expr),StyleCLI->"Comment"];
	,
		CellPrint@TextCell[Expr,Darker@Green,"Text",CellContext->"Global`"]
	];
];
