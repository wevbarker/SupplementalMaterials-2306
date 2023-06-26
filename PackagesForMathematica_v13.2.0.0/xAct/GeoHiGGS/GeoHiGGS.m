(*============*)
(*  GeoHiGGS  *)
(*============*)

(*------------------------------*)
(*  Change version number here  *)
(*------------------------------*)

(*
xAct`HiGGS`$Version={"1.0.0",{2022,11,4}};
*)
xAct`GeoHiGGS`$Version={"1.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};

(*----------------------------------*)
(*  Suppress some shadowing errors  *)
(*----------------------------------*)
(*
xAct`HiGGS`G;
Off[xAct`GeoHiGGS`G::shdw];
*)
If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`GeoHiGGS`"];

(*==================*)
(*  xAct`GeoHiGGS`  *)
(*==================*)

BeginPackage["xAct`GeoHiGGS`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`HiGGS`","xAct`FieldsX`"}];

Print[xAct`xCore`Private`bars];
Print["Package xAct`GeoHiGGS`  version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2022, Will E. V. Barker, under the General Public License."];

Quiet@If[NotebookDirectory[]==$Failed,$WorkingDirectory=Directory[];,$WorkingDirectory=NotebookDirectory[];,$WorkingDirectory=NotebookDirectory[];];
$Path~AppendTo~$WorkingDirectory;
$GeoHiGGSInstallDirectory=Select[FileNameJoin[{#,"xAct/GeoHiGGS"}]&/@$Path,DirectoryQ][[1]];

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`GeoHiGGS`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

(*--------------------------------------------------------------*)
(*  Declaration of provided functions and symbols for GeoHiGGS  *)
(*--------------------------------------------------------------*)

BuildGeoHiGGS::usage="BuildGeoHiGGS[] destroys the Minkowskian HiGGS geometry permanantly, use with care!";
ToGeometric::usage="ToGeometric[HiGGS expression or string of HiGGS expression] converts the expression to one with curvature and torsion.";
ToGeoCanonical::usage="ToGeoCanonical[Geometric expression] is a heavy simplifier which commutes the torsion-free but geometric derivatives.";
GeoCalibrate::usage="GeoCalibrate[] explains how we decide on the index configurations for the Riemann tensor and the conventions for the contorsion and torsion. This function is not yet implemented.";

(*==========================*)
(*  xAct`GeoHiGGS`Private`  *)
(*==========================*)

Begin["xAct`GeoHiGGS`Private`"];

BuildPackage[FileName_String]:=Get[FileNameJoin@{$GeoHiGGSInstallDirectory,"Sources","Package",FileName}];

(*-------------------------*)
(*  Registry of functions  *)
(*-------------------------*)

BuildGeoHiGGSPackage[]:=BuildPackage/@{
	"ToGeom.m",
	"BuildGeoHiGGS.m",
	"ToGeometric.m",
	"ToGeoCanonical.m"
	(*"GeoCalibrate.m"*)
};

BuildGeoHiGGSPackage[];

End[];
EndPackage[];
