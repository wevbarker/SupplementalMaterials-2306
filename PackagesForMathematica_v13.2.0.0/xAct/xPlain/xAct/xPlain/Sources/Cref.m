(*========*)
(*  Cref  *)
(*========*)

Options@Cref={
	Kind->"Equation"
};
Cref[CellTagNameList_?ListQ,OptionsPattern[]]:=Module[{Expr},
	If[$xPlainCLI,
		Expr=StringJoin@@Flatten@Join[
			{" ",KindAbbrs@OptionValue@Kind},
			{" (##),"}&/@Drop[CellTagNameList,-1],
			{" and (##)"}];
	,
		Expr=Join[{" ",KindAbbrs@OptionValue@Kind},{" (",CounterBox["DisplayFormulaNumbered",#],"),"}&/@Drop[CellTagNameList,-1],{" and (",CounterBox["DisplayFormulaNumbered",CellTagNameList[[-1]]],")"}];
	];
Expr];

Cref[CellTagName_?StringQ,OptionsPattern[]]:=Module[{Expr},
	If[$xPlainCLI,
		Expr={" ",KindAbbr@OptionValue@Kind," (##)"};
	,	
		Expr={" ",KindAbbr@OptionValue@Kind," (",CounterBox["DisplayFormulaNumbered",CellTagName],")"};
	];
Expr];
