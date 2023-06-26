(*==================*)
(*  ToGeoCanonical  *)
(*==================*)

ToGeoCanonical::unbuilt="The GeoHiGGS environment has not yet been built.";
ToGeoCanonical[GeometricExpr_]:=Catch@Module[{
	CanonicalGeometricExpr=GeometricExpr,
	PrintVariable
	},

	PrintVariable={};
	If[!$GeoHiGGSBuilt,Throw@Message[ToGeoCanonical::unbuilt]];

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToGeoCanonical...";

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";

	CanonicalGeometricExpr//=NoScalar;
	CanonicalGeometricExpr//=ToCanonical;
	CanonicalGeometricExpr//=ContractMetric;
	CanonicalGeometricExpr//=ScreenDollarIndices;
	CanonicalGeometricExpr//=NoScalar;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** SymmetrizeCovDs...";
	CanonicalGeometricExpr//=SymmetrizeCovDs;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	CanonicalGeometricExpr//=NoScalar;
	CanonicalGeometricExpr//=ToCanonical;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ExpandSymCovDs...";
	CanonicalGeometricExpr//=ExpandSymCovDs;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** SortCovDs...";
	CanonicalGeometricExpr//=SortCovDs;

	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ToCanonical...";
	CanonicalGeometricExpr//=NoScalar;
	CanonicalGeometricExpr//=ToCanonical;
	CanonicalGeometricExpr//=NoScalar;
	CanonicalGeometricExpr//=ToCanonical;
	CanonicalGeometricExpr//=ContractMetric;
	CanonicalGeometricExpr//=ScreenDollarIndices;
	CanonicalGeometricExpr//=NoScalar;

	NotebookDelete@PrintVariable;
CanonicalGeometricExpr];
