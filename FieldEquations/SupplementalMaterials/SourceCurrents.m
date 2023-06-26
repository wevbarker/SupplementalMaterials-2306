(*==================*)
(*  SourceCurrents  *)
(*==================*)

Subsection@"Non-density source currents";

Comment@{"Define a spin tensor, to replace the spin tensor density in",Cref@"FinalSpinEquation"," in accordance with the paragraph following Eq. (3.58) on p. 67 in Blagojević."};

SigmaTensorSymb="S";
DefTensor[SigmaTensor[i,j,k],M4,Antisymmetric[{j,k}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[SigmaTensorSymb]];
SigmaToSigmaTensor=MakeRule[{Sigma[-a,-b,-c],
	Sqrt[-DetGeoG[]]SigmaTensor[-a,-b,-c]},
	MetricOn->All,ContractMetrics->True];

Comment@"Define irreducible parts of this tensor using HiGGS conventions.";

DefTensor[SigmaTensor1[-i,-j,-k],M4,Symmetric[{-i,-j}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[SigmaTensorSymb,xAct`HiGGS`Private`SO1]]; 
DefTensor[SigmaTensor2[i],M4,
	PrintAs->xAct`HiGGS`Private`SymbolBuild[SigmaTensorSymb,xAct`HiGGS`Private`SO2]];
DefTensor[SigmaTensor3[i],M4,
	PrintAs->xAct`HiGGS`Private`SymbolBuild[SigmaTensorSymb,xAct`HiGGS`Private`SO3]];

AutomaticRules[SigmaTensor1,MakeRule[{SigmaTensor1[a,a1,-a1],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaTensor1,MakeRule[{SigmaTensor1[a,-a,-a1],0},MetricOn->All,ContractMetrics->True]];

SigmaTensorDefinition=(2/3)(SigmaTensor1[-i,-j,-k]-SigmaTensor1[-i,-k,-j])+
(1/3)(GeoG[-i,-j]SigmaTensor2[-k]-GeoG[-i,-k]SigmaTensor2[-j])+
epsilonGeoG[-i,-j,-k,-m]SigmaTensor3[m];

SigmaTensorSO13Activate=MakeRule[{SigmaTensor[-i,-j,-k],Evaluate[SigmaTensorDefinition]},MetricOn->All,ContractMetrics->True];


Expr=Sigma[-i,-j,-k]/Sqrt[-DetGeoG[]];
DisplayExpression@Expr;
Expr=Expr/.SigmaToSigmaTensor//ToCanonical;
DisplayExpression[Expr,EqnLabel->"SigmaToSigmaTensor"];
Expr=Expr/.SigmaTensorSO13Activate//ToCanonical//ScreenDollarIndices;
DisplayExpression@Expr;

Comment@{"Similarly, define the symmetric (metrical) matter stress-energy tensor",Inline@ThetaTensor[-i,-j],", to replace the tensor density in",Cref@"ThetaEquation","."};

ThetaTensorSymb="T";
DefTensor[ThetaTensor[-i,-j],M4,Symmetric[{-i,-j}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[ThetaTensorSymb]];
ThetaToThetaTensor=MakeRule[{Theta[-a,-b],
	Sqrt[-DetGeoG[]]ThetaTensor[-a,-b]},MetricOn->All,ContractMetrics->True];

DefTensor[ThetaTensor1[-i,-j],M4,Symmetric[{-i,-j}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[ThetaTensorSymb,xAct`HiGGS`Private`SO1]]; 
DefTensor[ThetaTensor2[],M4,
	PrintAs->xAct`HiGGS`Private`SymbolBuild[ThetaTensorSymb,xAct`HiGGS`Private`SO2]];

AutomaticRules[ThetaTensor1,MakeRule[{ThetaTensor1[a1,-a1],0},MetricOn->All,ContractMetrics->True]];

ThetaTensorDefinition=ThetaTensor1[-i,-j]+(1/4)GeoG[-i,-j]ThetaTensor2[];

ThetaTensorSO13Activate=MakeRule[{ThetaTensor[-i,-j],
	Evaluate[ThetaTensorDefinition]},MetricOn->All,ContractMetrics->True];

Expr=Theta[-i,-j]/Sqrt[-DetGeoG[]];
DisplayExpression@Expr;
Expr=Expr/.ThetaToThetaTensor//ToCanonical//ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"ThetaToThetaTensor"];
Expr=Expr/.ThetaTensorSO13Activate//ToCanonical//ScreenDollarIndices;
DisplayExpression@Expr;
