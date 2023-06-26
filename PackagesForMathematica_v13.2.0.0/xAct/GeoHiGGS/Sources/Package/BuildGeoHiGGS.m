(*=================*)
(*  BuildGeoHiGGS  *)
(*=================*)

$GeoHiGGSBuilt=False;
BuildGeoHiGGS::built="The GeoHiGGS environment has already been built.";
BuildGeoHiGGS::nobin="The binary at `1` cannot be found; quitting.";

BuildGeoHiGGS[]:=Catch@Module[{xAct`GeoHiGGS`Private`$MostNames},

	If[$GeoHiGGSBuilt,Throw@Message[BuildGeoHiGGS::built]];

	(*-----------------------------------*)
	(*  Cache all the HiGGS definitions  *)
	(*-----------------------------------*)

	xAct`GeoHiGGS`Private`$MetricNames=xAct`HiGGS`Private`$PostMetricNames~Complement~xAct`HiGGS`Private`$PreMetricNames;
	xAct`GeoHiGGS`Private`$MostNames=Evaluate@(Names["xAct`HiGGS`*"]~Complement~xAct`GeoHiGGS`Private`$MetricNames);

	DumpSave[FileNameJoin@{$WorkingDirectory,"GeoHiGGS.mx"},xAct`GeoHiGGS`Private`$MostNames];
	(*Print@xAct`GeoHiGGS`Private`$MostNames;*)

	(*Print@Names["xAct`HiGGS`*"];*)
	(*Print@xAct`GeoHiGGS`Private`$MetricNames;*)
	(*Print@Evaluate@(Names["xAct`HiGGS`*"]~Complement~xAct`GeoHiGGS`Private`$MetricNames);*)

	Begin@"xAct`GeoHiGGS`";

		(*--------------------------------------------------------------------------------*)
		(*  From VisitorsOf, it seems xPert assigns PerturbationG, which must be removed  *)
		(*--------------------------------------------------------------------------------*)

		Quiet@UndefTensor@PerturbationG;
		Quiet@UndefMetric@G;

		Quiet@UndefTensor@PerturbationGP;
		Quiet@UndefMetric@GP;

		(*--------------------------------------------------*)
		(*  Define the new metric for the curved spacetime  *)
		(*--------------------------------------------------*)

		xAct`GeoHiGGS`Private`GSymb="\!\(\*OverscriptBox[\(\[ScriptG]\), \(\[Degree]\)]\)";

		Evaluate@xAct`HiGGS`G:=xAct`GeoHiGGS`GeoG;
		Evaluate@xAct`HiGGS`epsilonG:=xAct`GeoHiGGS`epsilonGeoG;
		Evaluate@xAct`HiGGS`GaugeCovD:=xAct`GeoHiGGS`GeoGaugeCovD;

		xAct`GeoHiGGS`Private`$PreMetricNames=Names@"xAct`GeoHiGGS`*";

		DefMetric[-1,xAct`GeoHiGGS`GeoG[-a,-b],xAct`GeoHiGGS`GeoCovD,{";","\!\(\*OverscriptBox[\(\[Del]\), \(\[SmallCircle]\)]\)"},PrintAs->xAct`HiGGS`Private`SymbolBuild@xAct`GeoHiGGS`Private`GSymb,SymCovDQ->True];

		(*------------------------------*)
		(*  Relabel coordinate indices  *)
		(*------------------------------*)

		xAct`GeoHiGGS`Private`StandardIndices=ToExpression/@Alphabet[];
		xAct`GeoHiGGS`Private`ExtendedIndices=ToExpression@(ToString@#<>"1")&/@StandardIndices;

		xAct`GeoHiGGS`Private`GeoStandardIndicesSymb=(ToString@#)&/@Evaluate@((#[[2]])&/@{
			{a,"\[Alpha]"},
			{b,"\[Beta]"},
			{c,"\[Chi]"},
			{d,"\[Delta]"},
			{e,"\[Epsilon]"},
			{f,"\[Phi]"},
			{g,"\[Gamma]"},
			{h,"\[Eta]"},
			{i,"\[Iota]"},
			{j,"\[Theta]"},
			{k,"\[Kappa]"},
			{l,"\[Lambda]"},
			{m,"\[Mu]"},
			{n,"\[Nu]"},
			{o,"\[Omicron]"},
			{p,"\[Pi]"},
			{q,"\[Omega]"},
			{r,"\[Rho]"},
			{s,"\[Sigma]"},
			{t,"\[Tau]"},
			{u,"\[Upsilon]"},
			{v,"\[Psi]"},
			{w,"\[Omega]"},
			{x,"\[Xi]"},
			{y,"\[CurlyPhi]"},
			{z,"\[Zeta]"}
		});

		xAct`GeoHiGGS`Private`GeoExtendedIndicesSymb=ToString@ToExpression@(ToString@#<>"'")&/@xAct`GeoHiGGS`Private`GeoStandardIndicesSymb;

		(PrintAs@Evaluate@#1^:=Evaluate@#2)&~MapThread~{xAct`GeoHiGGS`Private`StandardIndices,xAct`GeoHiGGS`Private`GeoStandardIndicesSymb};
		(PrintAs@Evaluate@#1^:=Evaluate@#2)&~MapThread~{xAct`GeoHiGGS`Private`ExtendedIndices,xAct`GeoHiGGS`Private`GeoExtendedIndicesSymb};

		If[False,

			(*---------------------------------------*)
			(*  If we want to load a spin structure  *)
			(*---------------------------------------*)

			(*--------------------------------------*)
			(*  Relabel Lorentz and spinor indices  *)
			(*--------------------------------------*)

			xAct`GeoHiGGS`Private`LorentzStandardIndices=(ToExpression[#1<>#2]&~MapThread~{#,#})&@(ToString/@xAct`GeoHiGGS`Private`StandardIndices);
			xAct`GeoHiGGS`Private`LorentzExtendedIndices=(ToExpression[#1<>#2]&~MapThread~{#,#})&@(ToString/@xAct`GeoHiGGS`Private`ExtendedIndices);

			xAct`GeoHiGGS`Private`CapsStandardIndices=ToUpperCase/@ToString/@xAct`GeoHiGGS`Private`StandardIndices;
			xAct`GeoHiGGS`Private`CapsExtendedIndices=ToUpperCase/@ToString/@xAct`GeoHiGGS`Private`ExtendedIndices;

			xAct`GeoHiGGS`Private`SpinorStandardIndices=(ToExpression[#1<>#2]&~MapThread~{#,#})&@(ToString/@xAct`GeoHiGGS`Private`CapsStandardIndices);
			xAct`GeoHiGGS`Private`SpinorExtendedIndices=(ToExpression[#1<>#2]&~MapThread~{#,#})&@(ToString/@xAct`GeoHiGGS`Private`CapsExtendedIndices);

			xAct`GeoHiGGS`Private`LorentzStandardIndicesSymb=ToString@ToExpression@("\\[Script"<>ToUpperCase@ToString@#<>"]")&/@Alphabet[];
			xAct`GeoHiGGS`Private`LorentzExtendedIndicesSymb=ToString@ToExpression@(ToString@#<>"'")&/@xAct`GeoHiGGS`Private`LorentzStandardIndicesSymb;
			xAct`GeoHiGGS`Private`SpinorStandardIndicesSymb=ToString@ToExpression@("\\[DoubleStruck"<>ToUpperCase@ToString@#<>"]")&/@Alphabet[];
			xAct`GeoHiGGS`Private`SpinorExtendedIndicesSymb=ToString@ToExpression@(ToString@#<>"'")&/@xAct`GeoHiGGS`Private`SpinorStandardIndicesSymb;

			(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`GeoHiGGS`Private`LorentzStandardIndices,xAct`GeoHiGGS`Private`LorentzStandardIndicesSymb};
			(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`GeoHiGGS`Private`LorentzExtendedIndices,xAct`GeoHiGGS`Private`LorentzExtendedIndicesSymb};
			(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`GeoHiGGS`Private`SpinorStandardIndices,xAct`GeoHiGGS`Private`SpinorStandardIndicesSymb};
			(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`GeoHiGGS`Private`SpinorExtendedIndices,xAct`GeoHiGGS`Private`SpinorExtendedIndicesSymb};

			(*-------------------------*)
			(*  Define a frame bundle  *)
			(*-------------------------*)

			DefFrameBundle[\[ScriptE][-a,aa],\[Eta][-aa,-bb],xAct`GeoHiGGS`Private`LorentzStandardIndices~Join~xAct`GeoHiGGS`Private`LorentzExtendedIndices];

			(*---------------------------*)
			(*  Define a spin structure  *)
			(*---------------------------*)

			DefSpinStructure[GeoG,xAct`GeoHiGGS`Private`SpinorStandardIndices~Join~xAct`GeoHiGGS`Private`SpinorExtendedIndices];

			(*--------------------------------------------*)
			(*  Define a torsionful covariant derivative  *)
			(*--------------------------------------------*)

			DefCovD[GeoGaugeCovD[-a],SpinM4,{"|","\[Del]"},Torsion->True,FromMetric->GeoG];

			(*---------------------------------------*)
			(*  Define a torsionful spin connection  *)
			(*---------------------------------------*)

			DefSpinConnection[\[Omega][-a, -aa, -bb],GeoGaugeCovD];

			(*-----------------------------------------------------------------------*)
			(*  Define a torsion-free spin connection (Ricci rotation coefficients)  *)
			(*-----------------------------------------------------------------------*)

			DefSpinConnection[\[CapitalDelta][-a, -aa, -bb],GeoCovD];,

			(*-----------------------------------------------------*)
			(*  If we don't want to bother loading spin structure  *)
			(*-----------------------------------------------------*)

			(*--------------------------------------------*)
			(*  Define a torsionful covariant derivative  *)
			(*--------------------------------------------*)
			
			Begin@"xAct`GeoHiGGS`";
				DefCovD[xAct`GeoHiGGS`GeoGaugeCovD[-a],{"|","\[Del]"},Torsion->True,FromMetric->xAct`HiGGS`G];
			End[];
		];

		xAct`GeoHiGGS`Private`$PostMetricNames=Names@"xAct`GeoHiGGS`*";

		(*-------------------------------------------*)
		(*  Read in all the xAct`HiGGS` definitions  *)
		(*-------------------------------------------*)

		Print[" ** BuildGeoHiGGS: Incorporating the binary at "<>FileNameJoin@{$WorkingDirectory,"GeoHiGGS.mx"}<>"..."];
		Check[ToExpression["<<"<>FileNameJoin@{$WorkingDirectory,"GeoHiGGS.mx"}<>";"],
			Throw@Message[BuildGeoHiGGS::nobin,FileNameJoin@{$WorkingDirectory,"GeoHiGGS.mx"}];Quit[];
		];

	End[];

	MakeToGeom[];

	(*---------------------------------------*)
	(*  Set the environment to built status  *)
	(*---------------------------------------*)

	$GeoHiGGSBuilt=True;
];
