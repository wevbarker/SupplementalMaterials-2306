(*=================*)
(*  ConserveSigma  *)
(*=================*)

Subsection@"Symmetrising the matter stress-energy tensor";

Comment@"The conservation law for the spin tensor as set out in Eq. (3.23) on page 49 of Blagojević, leads to a rule for symmetrising the stress-energy tensor.";

Expr=(1/2)(GeoGaugeCovD[-a][Sigma[a,-i,-j]]-TorsionGeoGaugeCovD[k,-k,-a]Sigma[a,-i,-j])//ToGeometric;
ConserveSigma=MakeRule[{Tau[-i,-j],
	(1/2)(Tau[-i,-j]+Tau[-j,-i])+Evaluate@Expr},
	MetricOn->All,ContractMetrics->True];

Expr=Tau[-i,-j];
DisplayExpression@Expr;
Expr=Expr/.ConserveSigma;
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"ConserveSigma"];
