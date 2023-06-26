(*==================*)
(*  MaxwellTensors  *)
(*==================*)

Subsection@"The torsion Maxwell tensors";

Comment@"We define a pair of Maxwell tensors naturally according to the vector torsion.";

MaxwellSymb="\[ScriptCapitalF]";
DefTensor[Maxwell1[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[MaxwellSymb,xAct`HiGGS`Private`SO1]];
DefTensor[NonlinearMaxwell1[-a,-b],M4,PrintAs->xAct`HiGGS`Private`SymbolBuild["n"<>MaxwellSymb,xAct`HiGGS`Private`SO1]];
DefTensor[Maxwell2[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[MaxwellSymb,xAct`HiGGS`Private`SO2]];
DefTensor[Maxwell3[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[MaxwellSymb,xAct`HiGGS`Private`SO3]];

Comment@"We define a rule to replace the third Maxwell tensor with its dual (with somewhat loosely-defined conventions for the dual: we only require an invertible definition since we will eliminate it in all our final expressions).";

DualMaxwellSymb="\[FivePointedStar]\[ScriptCapitalF]";
DefTensor[DualMaxwell3[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[DualMaxwellSymb,xAct`HiGGS`Private`SO3]];
MaxwellToDual3=MakeRule[{Maxwell3[c,d],
	epsilonGeoG[c,d,-e,-f]DualMaxwell3[e,f]},
	MetricOn->All,ContractMetrics->True];

Expr=epsilonGeoG[a,b,-c,-d]Maxwell3[c,d]/.MaxwellToDual3//ToCanonical;
Expr=Expr-epsilonGeoG[a,b,-c,-d]Maxwell3[c,d]//ToCanonical;
DualToMaxwell3=MakeQuotientRule[{DualMaxwell3[a,b],Expr}];

Expr=Maxwell3[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.MaxwellToDual3;
Expr//=ToGeoCanonical;
DisplayExpression[Expr,EqnLabel->"MaxwellToDual3"];
Expr=Expr/.DualToMaxwell3;
Expr//=ToGeoCanonical;
DisplayExpression@Expr;

Comment@"We know that these Maxwell tensors will also satisfy the Bianchi identities, even in the curved, Riemannian spacetime.";

Maxwell2~AutomaticRules~MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell2[c,d]],0},MetricOn->All,ContractMetrics->True];
Maxwell3~AutomaticRules~MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell3[c,d]],0},MetricOn->All,ContractMetrics->True];

Bianchi2=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell2[c,d]],0},MetricOn->All,ContractMetrics->True];
Bianchi2a=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[-z][GeoCovD[b][Maxwell2[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi2b=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][GeoCovD[-z][Maxwell2[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi3=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell3[c,d]],0},MetricOn->All,ContractMetrics->True];
Bianchi3a=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[-z][GeoCovD[b][Maxwell3[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi3b=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][GeoCovD[-z][Maxwell3[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi=Join[Bianchi2,Bianchi2a,Bianchi2b,Bianchi3,Bianchi3a,Bianchi3b];

ToMaxwell1=MakeRule[{GeoCovD[-c][T1[c,-a,-b]],(1/2)Maxwell1[-a,-b]+(1/2)(GeoCovD[-c][T1[c,-a,-b]]+GeoCovD[-c][T1[c,-b,-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell1b=MakeRule[{GeoCovD[-j]@GeoCovD[-c][T1[c,-a,-b]],(1/2)GeoCovD[-j]@Maxwell1[-a,-b]+(1/2)GeoCovD[-j]@(GeoCovD[-c][T1[c,-a,-b]]+GeoCovD[-c][T1[c,-b,-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell2=MakeRule[{GeoCovD[-a][T2[-b]],(1/2)Maxwell2[-a,-b]+(1/2)(GeoCovD[-a][T2[-b]]+GeoCovD[-b][T2[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell2b=MakeRule[{GeoCovD[-j]@GeoCovD[-a][T2[-b]],(1/2)GeoCovD[-j]@Maxwell2[-a,-b]+(1/2)GeoCovD[-j]@(GeoCovD[-a][T2[-b]]+GeoCovD[-b][T2[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell3=MakeRule[{GeoCovD[-a][T3[-b]],(1/2)Maxwell3[-a,-b]+(1/2)(GeoCovD[-a][T3[-b]]+GeoCovD[-b][T3[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell3b=MakeRule[{GeoCovD[-j]@GeoCovD[-a][T3[-b]],(1/2)GeoCovD[-j]@Maxwell3[-a,-b]+(1/2)GeoCovD[-j]@(GeoCovD[-a][T3[-b]]+GeoCovD[-b][T3[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell=Join[ToMaxwell1,ToMaxwell2,ToMaxwell3];

FromMaxwell1=MakeRule[{Maxwell1[-a,-b],(GeoCovD[-c][T1[c,-a,-b]]-GeoCovD[-c][T1[c,-b,-a]])},MetricOn->All,ContractMetrics->True];
FromMaxwell2=MakeRule[{Maxwell2[-a,-b],(GeoCovD[-a][T2[-b]]-GeoCovD[-b][T2[-a]])},MetricOn->All,ContractMetrics->True];
FromMaxwell3=MakeRule[{Maxwell3[-a,-b],(GeoCovD[-a][T3[-b]]-GeoCovD[-b][T3[-a]])},MetricOn->All,ContractMetrics->True];
FromMaxwell=Join[FromMaxwell1,FromMaxwell2,FromMaxwell3];

Comment@"We also construct some rules which reverse divergences of gradients of the torsion vector and axial vector.";

Expr=GeoCovD[-a][GeoCovD[-a1][T2[a1]]];
DisplayExpression[Expr,EqnLabel->"Ident1"];
Expr//=ToGeoCanonical;
DisplayExpression[Expr,EqnLabel->"Ident2"];
Expr=Expr-GeoCovD[-a][GeoCovD[-a1][T2[a1]]];
DivGradT2ToGradDivT2=MakeQuotientRule[{GeoCovD[-a1][GeoCovD[-a][T2[a1]]],Expr},Method->"Coefficient"];

Expr=GeoCovD[-a][GeoCovD[-a1][T3[a1]]];
DisplayExpression[Expr,EqnLabel->"Ident3"];
Expr//=ToGeoCanonical;
DisplayExpression[Expr,EqnLabel->"Ident4"];
Expr=Expr-GeoCovD[-a][GeoCovD[-a1][T3[a1]]];
DivGradT3ToGradDivT3=MakeQuotientRule[{GeoCovD[-a1][GeoCovD[-a][T3[a1]]],Expr},Method->"Coefficient"];

Comment@{"Thus, we have rules to move between",Cref@{"Ident1","Ident2"},", or ",Cref@{"Ident3","Ident4"}," (which are identical pairs of expressions). Similarly, some rules are also constructed to express gradient of divergence as divergence of gradient."};

Expr=GeoCovD[-a][GeoCovD[c][T2[a]]];
DisplayExpression@Expr;
Expr//=ToGeoCanonical;
DisplayExpression@Expr;
GradDivT2ToDivGradT2=MakeQuotientRule[{GeoCovD[c][GeoCovD[-a][T2[a]]],Expr-GeoCovD[-a][GeoCovD[c][T2[a]]]}];

Expr=GeoCovD[-a][GeoCovD[c][T3[a]]];
DisplayExpression@Expr;
Expr//=ToGeoCanonical;
DisplayExpression@Expr;
GradDivT3ToDivGradT3=MakeQuotientRule[{GeoCovD[c][GeoCovD[-a][T3[a]]],Expr-GeoCovD[-a][GeoCovD[c][T3[a]]]}];
GradDivToDivGrad=Join[GradDivT2ToDivGradT2,GradDivT3ToDivGradT3];

Comment@"Again, the pairs of expressions above are clearly identical.";
