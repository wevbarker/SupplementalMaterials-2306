(*=====================*)
(*  BianchiIdentities  *)
(*=====================*)

(*Section@"The torsionless Bianchi identities";*)

(*Comment@"We next construct some general rules to impose the Riemannian Bianchi identities.";*)

FirstBianchi=MakeRule[{epsilonGeoG[r,m,l,n]RiemannGeoCovD[s,-m,-l,-n],0},MetricOn->All,ContractMetrics->True];
SecondBianchi=MakeRule[{epsilonGeoG[r,l,m,n]GeoCovD[-b]@RiemannGeoCovD[i,j,-m,-n],0},MetricOn->All,ContractMetrics->True];

(*Comment@"Here there is an opportunity to deploy some of Teake Nutma's code from 2012, but we cannot really get it to help, so we leave it in comments.";*)

(*
FirstBianchiRule=RiemannGeoCovD[a_,b_,c_,d_]/;(Ordering@{b,c,d}==={2,3,1})->
		RiemannGeoCovD[a,c,b,d]-RiemannGeoCovD[a,d,b,c];

SecondBianchiRule=GeoCovD[a_]@RiemannGeoCovD[b_,c_,d__]/;(Ordering@{a,b,c}==={2,3,1})->
		GeoCovD[b]@RiemannGeoCovD[a,c,d]-GeoCovD[c]@RiemannGeoCovD[a,b,d];
ApplyBianchi[Expr_]:=Module[{AppliedExpr=Expr},
	AppliedExpr//=ToCanonical;
	AppliedExpr=AppliedExpr//.FirstBianchiRule;
	AppliedExpr=AppliedExpr//.SecondBianchiRule;
	AppliedExpr//=ToCanonical;
AppliedExpr];
*)

(*Comment@"We now define some rules which are designed to ameliorate multi-term symmetries of the Riemann tensor.";*)

CurrentFirstBianchiRule=MakeRule[{Maxwell2[-c,-d]RiemannGeoCovD[-e,-f,c,d],
			-Maxwell2[-c,-d]RiemannGeoCovD[-e,c,d,-f]
			-Maxwell2[-c,-d]RiemannGeoCovD[-e,d,-f,c]},
				MetricOn->All,ContractMetrics->True];

NewFirstBianchiRule=MakeRule[{epsilonGeoG[-a,-b,-c,-d]RiemannGeoCovD[-e,-f,c,d],
			-epsilonGeoG[-a,-b,-c,-d]RiemannGeoCovD[-e,c,d,-f]
			-epsilonGeoG[-a,-b,-c,-d]RiemannGeoCovD[-e,d,-f,c]},
				MetricOn->All,ContractMetrics->True];

NewSecondBianchiRule=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b]@RiemannGeoCovD[-e,c,-f,d],0},
				MetricOn->All,ContractMetrics->True];

NewerSecondBianchiRule=MakeRule[{GeoCovD[-c]@RiemannGeoCovD[-i,-j,-a,c],
	-GeoCovD[-i]@RiemannGeoCovD[-j,-c,-a,c]
	-GeoCovD[-j]@RiemannGeoCovD[-c,-i,-a,c]}
	,MetricOn->All,ContractMetrics->True];

ApplyBianchi[Expr_]:=Module[{AppliedExpr=Expr},
	AppliedExpr//=ToCanonical;
	AppliedExpr=AppliedExpr//.FirstBianchi;
	AppliedExpr=AppliedExpr//.SecondBianchi;
	AppliedExpr=AppliedExpr//.CurrentFirstBianchiRule;
	AppliedExpr=AppliedExpr//.NewFirstBianchiRule;
	AppliedExpr=AppliedExpr//.NewSecondBianchiRule;
	AppliedExpr=AppliedExpr//.NewerSecondBianchiRule;
	AppliedExpr//=ToCanonical;
AppliedExpr];
