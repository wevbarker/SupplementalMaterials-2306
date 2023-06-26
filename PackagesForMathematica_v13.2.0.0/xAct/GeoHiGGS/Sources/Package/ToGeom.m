(*==========*)
(*  ToGeom  *)
(*==========*)

ToGeom={};
AppendToGeom[Expr_]:=(ToGeom=ToGeom~Join~Expr);

MakeToGeom[]:=Module[{},
	Begin@"xAct`GeoHiGGS`";

	xAct`GeoHiGGS`Private`AppendToGeom@MakeRule[{H[-a,b],xAct`GeoHiGGS`GeoG[-a,b]},MetricOn->All,ContractMetrics->True];
	xAct`GeoHiGGS`Private`AppendToGeom@MakeRule[{B[a,-b],xAct`GeoHiGGS`GeoG[a,-b]},MetricOn->All,ContractMetrics->True];
	xAct`GeoHiGGS`Private`AppendToGeom@MakeRule[{R[-a,-b,-c,-d],xAct`GeoHiGGS`RiemannGeoGaugeCovD[-c,-d,-a,-b]},MetricOn->All,ContractMetrics->True];
	xAct`GeoHiGGS`Private`AppendToGeom@MakeRule[{xAct`GeoHiGGS`TorsionGeoGaugeCovD[-a,-b,-c],T[-a,-b,-c]},MetricOn->All,ContractMetrics->True];
	xAct`GeoHiGGS`Private`AppendToGeom@MakeRule[{J[],Sqrt[-xAct`GeoHiGGS`DetGeoG[]]/Lapse[]},MetricOn->All,ContractMetrics->True];

	End[];
	];
