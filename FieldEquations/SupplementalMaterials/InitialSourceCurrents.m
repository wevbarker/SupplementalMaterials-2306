(*=========================*)
(*  InitialSourceCurrents  *)
(*=========================*)

Comment@"Define a spin tensor, to replace the density in accordance with the
paragraph following Eq. (3.58) on page 67 in Blagojevic.";

SigmaTensorSymb="S";
DefTensor[SigmaTensor[i,j,k],M4,Antisymmetric[{j,k}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[SigmaTensorSymb]];
GaugeSigmaToSigmaTensor=MakeRule[{Sigma[-a,-b,-c],
	Lapse[]J[]SigmaTensor[-a,-b,-c]},
	MetricOn->All,ContractMetrics->True];

GaugeSigmaTensorToSigma=MakeRule[{SigmaTensor[-a,-b,-c],
	Sigma[-a,-b,-c]/(Lapse[]J[])},
	MetricOn->All,ContractMetrics->True];

Comment@"Similarly, define the symmetric (metrical) matter stress-energy tensor.";
(*
ThetaTensorSymb="T";
DefTensor[ThetaTensor[-i,-j],M4,Symmetric[{-i,-j}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[ThetaTensorSymb]];
GaugeThetaToThetaTensor=MakeRule[{Theta[-a,-b],
	Lapse[]J[]ThetaTensor[-a,-b]},MetricOn->All,ContractMetrics->True];
*)
