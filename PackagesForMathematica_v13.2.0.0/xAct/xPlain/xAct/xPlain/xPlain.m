(*==========*)
(*  xPlain  *)
(*==========*)

(*------------------------------*)
(*  Change version number here  *)
(*------------------------------*)

(*
xAct`xPlain`$Version={"0.0.0",{2023,11,4}};
*)
xAct`xPlain`$Version={"0.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};

If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`xPlain`"];

(* here is an error-killing line, I can't quite remember why we needed it! *)
Off@(Solve::fulldim);
Off@(Syntax::stresc);
Off@(FrontEndObject::notavail);

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

(*-------------------------------------------------------------------*)
(*  Modify the path to accommodate notebook and install directories  *)
(*-------------------------------------------------------------------*)

Quiet@If[NotebookDirectory[]==$Failed,
	$xPlainCLI=True,
	$xPlainCLI=False,
	$xPlainCLI=False];

If[$xPlainCLI,
	$xPlainWorkingDirectory=Directory[],
	$xPlainWorkingDirectory=NotebookDirectory[]];

$Path~AppendTo~$xPlainWorkingDirectory;
$xPlainInstallDirectory=Select[FileNameJoin[{#,"xAct/xPlain"}]&/@$Path,DirectoryQ][[1]];

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`xPlain`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

Title::usage="Title";
Chapter::usage="Chapter";
Section::usage="Section";
Subsection::usage="Subsection";

Comment::usage="Comment";
Supercomment::usage="Manuscript";

Kind::usage="Kind";
Cref::usage="Cref";
Mref::usage="Mref";
Inline::usage="Inline";
Mlabel::usage="Mlabel";

DisplayEquation::usage="DisplayEquation";
DisplayExpression::usage="DisplayExpression";
EqnLabel::usage="EqnLabel";

$PaperPrint::usage="$PaperPrint is a global bool.";
$PaperPrint=True;
$Widetext::usage="$Widetext is a global bool.";
$Widetext=True;
$ListingsOutput::usage="$ListingsOutput is a globally-defined string which defines the name associated with the LstListing output.";
LstListingIn::usage="LstListing[Expr_] produces LaTeX listings.";
LstListingOut::usage="LstListing[Expr_] produces LaTeX listings.";

(*legacy*)
PartIIIProject::usage="PartIIIProject";
Manuscript::usage="Manuscript";

NovelOutput::usage="Manuscript";
NovelEcho::usage="Manuscript";
NovelPrint::usage="Manuscript";

Begin["xAct`xPlain`Private`"];

BuildPackage[FileName_String]:=Get[FileNameJoin@{$xPlainInstallDirectory,"Sources",FileName}];

(*-------------------------*)
(*  Registry of functions  *)
(*-------------------------*)

BuildPackage/@{
	"DisplayCLI.m",
	"Title.m",
	"Chapter.m",
	"Section.m",
	"Subsection.m",
	"Comment.m",
	"Supercomment.m",
	"Manuscript.m",
	"PartIIIProject.m",
	"Kind.m",
	"Cref.m",
	"Mref.m",
	"Inline.m",
	"DisplayExpression.m",
	"DisplayEquation.m",
	"LstListing.m"
};

End[];
EndPackage[];
