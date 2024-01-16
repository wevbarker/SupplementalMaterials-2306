(*===================*)
(*  DisplayEquation  *)
(*===================*)

Options@DisplayEquation={EqnLabel->"NoEquationLabel"};
DisplayEquation[Expr_,OptionsPattern[]]:=Module[{
	LineWidth=60,
	Content,
	ContentWidth},

	If[$xPlainCLI,
		Content="[displayed equation with "<>ToString@LeafCount@Expr<>" leaves]";
		ContentWidth=StringLength@Content;
		Content//=StringPadLeft[#,Floor@(ContentWidth+(LineWidth-ContentWidth)/2)]&;
		ContentWidth=StringLength@Content;
		Content//=StringPadRight[#,Floor@(ContentWidth+(LineWidth-ContentWidth)/2)]&;
		Content//=StringPadRight[#,LineWidth]&;
		Content=Content<>"(##)";
		DisplayCLI[Content,StyleCLI->"Expression"];
		,
		CellPrint@ExpressionCell[Expr==0,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];
	];
];
