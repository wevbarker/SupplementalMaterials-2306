(*==========*)
(*  xPlain  *)
(*==========*)

(*------------------------------*)
(*  Change version number here  *)
(*------------------------------*)

(*
xAct`xPlain`$Version={"1.0.0",{2023,11,4}};
*)
xAct`xPlain`$Version={"1.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};

If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`xPlain`"];

(* here is an error-killing line, I can't quite remember why we needed it! *)
Off@(Solve::fulldim);

(*=================*)
(*  xAct`xPlain`  *)
(*=================*)

BeginPackage["xAct`xPlain`",{"xAct`xTensor`"}];

(*========================================================================*)
(*  The output can be long, we prefer to scroll automatically to the end  *)
(*========================================================================*)

SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];

Print[xAct`xCore`Private`bars];
Print["Package xAct`xPlain` version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2023, Will E. V. Barker and Sebastian Zell, under the General Public License."];

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`xPlain`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

Comment::usage="Comment";
Title::usage="Title";
Section::usage="Section";
Subsection::usage="Subsection";
DisplayEquation::usage="DisplayEquation";
DisplayExpression::usage="DisplayExpression";
PartIIIProject::usage="PartIIIProject";
Manuscript::usage="Manuscript";
Supercomment::usage="Manuscript";
Cref::usage="Cref";
Mref::usage="Mref";
Inline::usage="Inline";
Mlabel::usage="Mlabel";
EqnLabel::usage="EqnLabel";

Begin["xAct`xPlain`Private`"];

Manuscript[Expr_?StringQ]:=Manuscript[{Expr}];
Manuscript[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Concrete relation to manuscript: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];

Supercomment[Expr_?StringQ]:=Supercomment[{Expr}];
Supercomment[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Key observation: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];

PartIIIProject[Expr_?StringQ]:=PartIIIProject[{Expr}];
PartIIIProject[Expr_?ListQ]:=Module[{},
	CellPrint@Cell[TextData@({StyleBox["Connection to Part III Project: ",Large,FontWeight->Bold]}~Join~Flatten@Expr),Darker@Green,"Text",Background->Yellow]];
(*
PartIIIProject[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[TextGrid[{{Style["Connection to Part III project",Bold],Expr}},Frame->All],Darker@Green,"Text",Background->Yellow]];
*)


Cref[CellTagNameList_?ListQ]:=Join[{" Eqs."},{" (",CounterBox["DisplayFormulaNumbered",#],"),"}&/@Drop[CellTagNameList,-1],{" and (",CounterBox["DisplayFormulaNumbered",CellTagNameList[[-1]]],")"}];

Cref[CellTagName_?StringQ]:={" Eq. (",CounterBox["DisplayFormulaNumbered",CellTagName],")"};
Mref[ManuscriptEquationLabel_?StringQ]:={" Eq. (",ToString@(Mlabel@ManuscriptEquationLabel),")"};
Inline[Expr_]:=Module[{CellToDisplay},	
	(*CellToDisplay=ExpressionCell[Expr,CellContext->"Global`"];*)
	CellToDisplay=Cell[BoxData@MakeBoxes@Expr,CellContext->"Global`"];
{" ",CellToDisplay}];


Comment[Expr_?ListQ]:=CellPrint@Cell[TextData@Flatten@Expr,Darker@Green,"Text",CellContext->"Global`"];
Comment[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,Darker@Green,"Text",CellContext->"Global`"]];

Title[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,40,Darker@Green,Underlined,Bold,"Text"]];

Section[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,30,Darker@Green,Underlined,Bold,"Text"]];

Subsection[Expr_?StringQ]:=Module[{},
	CellPrint@TextCell[Expr,20,Darker@Green,Underlined,"Text"]];

Options@DisplayEquation={EqnLabel->"NoEquationLabel"};
DisplayEquation[Expr_,OptionsPattern[]]:=CellPrint@ExpressionCell[Expr==0,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];

Options@DisplayExpression={EqnLabel->"NoEquationLabel"};
DisplayExpression[Expr_,OptionsPattern[]]:=CellPrint@ExpressionCell[Expr,Background->LightGreen,"DisplayFormulaNumbered",CellTags->OptionValue@EqnLabel];

End[];
EndPackage[];
