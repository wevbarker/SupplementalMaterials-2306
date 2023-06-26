(*===============*)
(*  ToGeometric  *)
(*===============*)

ToCartanForm[VerbatimExpr_]:=Module[{
	GeometricExpr,
	GeoCovDSymb,
	GeoGaugeCovDSymb,
	PrintVariable},

	PrintVariable={};

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ChangeCovD...";
	GeoCovDSymb=ToExpression@"xAct`GeoHiGGS`GeoCovD";
	GeoGaugeCovDSymb=ToExpression@"xAct`GeoHiGGS`GeoGaugeCovD";
	GeometricExpr=ChangeCovD[VerbatimExpr,GeoGaugeCovDSymb,GeoCovDSymb];

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ChristoffelToGradMetric...";
	GeometricExpr//=ChristoffelToGradMetric;
	GeometricExpr//=ToCanonical;
	GeometricExpr//=ContractMetric;
	GeometricExpr//=ScreenDollarIndices;
	GeometricExpr//=NoScalar;
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	GeometricExpr//=ToCanonical;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ChangeCurvature...";
	GeometricExpr=ChangeCurvature[GeometricExpr,GeoGaugeCovDSymb,GeoCovDSymb];

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ChristoffelToGradMetric...";
	GeometricExpr//=ChristoffelToGradMetric;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	GeometricExpr//=ToCanonical;
	GeometricExpr//=ContractMetric;
	GeometricExpr//=ScreenDollarIndices;
	GeometricExpr//=NoScalar;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	GeometricExpr//=ToCanonical;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCartanForm...";
	GeometricExpr=GeometricExpr/.xAct`GeoHiGGS`Private`ToGeom;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	GeometricExpr//=ToCanonical;

	GeometricExpr//=ContractMetric;
	GeometricExpr//=ScreenDollarIndices;
	GeometricExpr//=NoScalar;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	GeometricExpr//=ToCanonical;

	NotebookDelete@PrintVariable;
GeometricExpr];

ToGeometric::unbuilt="The GeoHiGGS environment has not yet been built.";
ToGeometric[HiGGSExprOrString_]:=Catch@Module[{
	GeometricExpr,
	VerbatimExpr,
	PrintVariable},

	PrintVariable={};

	If[!$GeoHiGGSBuilt,Throw@Message[ToGeometric::unbuilt]];

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToGeometric...";
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** Imposing the ToGeom rules on tensors...";
	VerbatimExpr=HiGGSExprOrString/.xAct`GeoHiGGS`Private`ToGeom;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	VerbatimExpr//=ToCanonical;
	GeometricExpr=VerbatimExpr//ToCartanForm;

	NotebookDelete@PrintVariable;
GeometricExpr];
