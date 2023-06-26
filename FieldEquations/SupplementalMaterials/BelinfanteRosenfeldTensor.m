(*=============================*)
(*  BelinfanteRosenfeldTensor  *)
(*=============================*)

Subsection@"The Belinfante-Rosenfeld tensor";

Comment@{"Now we define the usual Einstein stress-energy tensor",Inline@Theta[-a,-b],", according to Eq. (3.59) on p. 67 of Blagojević. This is a further development of our `split' stress-energy tensor in",Cref@"SplitStressEnergy",". Note, by the way, that all indices are now Greek (and will remain so from this point onwards) since we ran BuildGeoHiGGS."};

ThetaSymb="\[Theta]";
DefTensor[Theta[-a,-b],M4,Symmetric[{-a,-b}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[ThetaSymb]];

ThetaEqn=TorsionlessTau[m,-k]-Theta[m,-k]-(1/2)GeoCovD[-l][Sigma[m,-k,l]+Sigma[-k,m,l]-Sigma[l,-k,m]];
ThetaEqn//=ToGeometric;
ThetaEqn//=ToGeoCanonical;
DisplayEquation[ThetaEqn,EqnLabel->"ThetaEquation"];
TauToThetaSigma=MakeQuotientRule[{TorsionlessTau[m,-k],ThetaEqn},MetricOn->All,ContractMetrics->True];
