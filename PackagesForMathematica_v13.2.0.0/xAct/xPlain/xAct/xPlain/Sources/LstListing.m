(*==============*)
(*  LstListing  *)
(*==============*)

If[$PaperPrint,
	Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,"LstListing"}];
	If[NotebookDirectory[]==$Failed,
	DontPrint[" ** BuildNovel: Purging LstListing directory at "<>FileNameJoin@{$xPlainWorkingDirectory,"LstListing/*"}<>"..."];,
		Run@("rm -rf "<>FileNameJoin@{$xPlainWorkingDirectory,"LstListing/*"});,
		Run@("rm -rf "<>FileNameJoin@{$xPlainWorkingDirectory,"LstListing/*"});
	];
];

$OldLine=$Line;
$SubLine=1;

NovelOutput[x_String]:=Module[{},
	$ListingsOutput=x;
	Run@("rm "<>FileNameJoin@{$xPlainWorkingDirectory,"LstListing",$ListingsOutput});
];

SetAttributes[LstListingIn,HoldAll];
LstListingIn[InputExpr__]:=Block[{
	FormattedInput,
	ListingsFile,
	Expr},

	Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,"LstListing"}];
	FormattedInput=ToString[Unevaluated[InputExpr]~ToString~InputForm];
	Print@FormattedInput;

	ListingsFile=OpenAppend[
			FileNameJoin@{$xPlainWorkingDirectory,"LstListing",$ListingsOutput<>".tex"},
			PageWidth->Infinity];

	WriteString[ListingsFile,"In[]:= "<>FormattedInput<>"\nOut[]= "];
	Close@ListingsFile;
	Expr=Evaluate@InputExpr;
Expr];

LstListingOut[InputExpr__]:=Block[{
	FormattedOutput,
	ListingsFile,
	ChosenImageSize},

	Quiet@CreateDirectory[FileNameJoin@{$xPlainWorkingDirectory,"LstListing"}];
	If[$Widetext,ChosenImageSize=(510/246)*350,ChosenImageSize=350];
	FormattedOutput=InputExpr;

	If[$PaperPrint,
		If[$Line==$OldLine,
			$SubLine=$SubLine+1,
			$SubLine=1;
			$OldLine=$Line;
		];

		ListingsFile=OpenAppend[
				FileNameJoin@{$xPlainWorkingDirectory,"LstListing",$ListingsOutput<>".tex"},
				PageWidth->Infinity];

		If[{FormattedOutput}~AllTrue~StringQ,
			Print@FormattedOutput;
			WriteString[
				ListingsFile,
				"|\n\\vspace{-10pt}\n|\n"<>""<>StringJoin@{FormattedOutput}<>"\n"];,

			FormattedOutput=Panel[
					Row@{"",FormattedOutput},
					ImageSize->ChosenImageSize,
					Background->RGBColor[0.95,1.,0.8],
					FrameMargins->None,
					ContentPadding->True,
					Alignment->Right];
			Print@FormattedOutput;

			FormattedOutputFileName=$ListingsOutput<>ToString@$OldLine<>"-"<>ToString@$SubLine<>"LstListing.pdf";
			FileNameJoin@{$xPlainWorkingDirectory,"LstListing",FormattedOutputFileName}~Export~FormattedOutput;

			WriteString[
				ListingsFile,
				"|\n\\vspace{-4pt}\n\\begin{flushleft}\n\\includegraphics[width=\\linewidth]{LstListing/"<>FormattedOutputFileName<>"}\n\\end{flushleft}\n\\vspace{-5pt}\n|\n"];
		];
		Close@ListingsFile;
	];
];
