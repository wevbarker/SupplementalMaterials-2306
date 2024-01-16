(*==========*)
(*  Inline  *)
(*==========*)

Inline[Expr_]:=Module[{Expr,CellToDisplay},
If[$xPlainCLI,
	Expr=" [inline expression with "<>ToString@LeafCount@Expr<>" leaves]";
,
	CellToDisplay=Cell[BoxData@MakeBoxes@Expr,CellContext->"Global`"];
	Expr={" ",CellToDisplay};
];
Expr];
