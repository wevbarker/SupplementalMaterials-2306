(*==================*)
(*  BeltranJimenez  *)
(*==================*)

ShowMatrix[Expr_String]:=Module[{MyExpr},	
MyExpr=Import[FileNameJoin@{NotebookDirectory[],"SupplementalMaterials",Expr},"PageGraphics"];
CellPrint[
Cell[BoxData[
PaneBox[Magnify[Graphics[First@MyExpr,ImageSize->Scaled[3]],3] // ToBoxes, Alignment -> Left,
ImageSize -> Full]], "Text"]];
];

Unprotect@Print;
Print[Expr___]:=DoNothing[Expr];

SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];

<<xAct`xPlain`;

Mlabel@"FullTable":="1";
Mlabel@"BadEffective":="6";
Mlabel@"Perturbative":="5a";
Mlabel@"ReducedNonlinearSpinEquation2":="5b";

Title@"Supplemental materials: Multipliers are not trivial";
Section@"Introduction";

Subsection@"How to use this document";

Comment@"These calculations are designed to accompany our manuscript in the form of supplemental materials, for the sake of reproducibility. Throughout, commentary by the authors takes the form of green text. Citations, where needed, will be managed by direct reference to arXiv numbers, and all such references are already provided in full within the body of our manuscript. One exception is the source referred to throughout as `Blagojević'; this pertains to the book `Gravitation and Gauge Symmetries', which is also referenced within the manuscript.";

Manuscript@"In boxes like this, we will make specific connections between a result which is obtained in the supplemental material and a claim which is made in the manuscript. These points of contact are not always numbered equations, they could be textual.";

Comment@"Note that a programmatical session in the Wolfram language does not really correspond to the clean flow of thoughts in a LaTeX document: there are differences that can't (and shouldn't) be ignored. Thus, whilst this document should be at least readable in standalone format, the reader is encouraged to follow it in tandem with the Wolfram language source codes, so as to avoid ambiguities. In this way, the specific operations and manipulations of quantities will become absolutely clear.";

Subsection@"Loading HiGGS and GeoHiGGS";

Comment@"For these calculations, we will use the HiGGS and GeoHiGGS packages. Note that GeoHiGGS was not developed for public release, and so is not documented. The versions of HiGGS and GeoHiGGS used for the computations here are both developer-only, and so we include copies of the sources with these supplemental materials.";

<<xAct`GeoHiGGS`;

Subsection@"Define a few constant parameters for the Lagrangian";

Comment@"Define a Planck mass.";
DefConstantSymbol[MPl,PrintAs->"\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(Pl\)]\)"];
DisplayExpression@MPl;

Comment@"Define the (dimensionless) coupling in front of the Ricci squared term.";
DefConstantSymbol[AlphaCoupling,PrintAs->"\[Alpha]"];
DisplayExpression@AlphaCoupling;

Comment@"Define the (dimensionless) mass parameter in front of the vector.";
DefConstantSymbol[Mu2,PrintAs->("\!\(\*OverscriptBox[\(.\), \(2\)]\)"~StringJoin~"\[Mu]")];
DisplayExpression@Mu2;

Comment@"Define the (dimensionless) mass parameter in front of the axial vector.";
DefConstantSymbol[Mu3,PrintAs->("\!\(\*OverscriptBox[\(.\), \(3\)]\)"~StringJoin~"\[Mu]")];
DisplayExpression@Mu3;

DefConstantSymbol[PertParam,PrintAs->"\[Epsilon]"];

BuildGeoHiGGS[];

Subsection@"Post-Riemannian decomposition of curvature";

Comment@"First set up the post-Riemannian expansion of the Ricci scalar.";
tmp=RicciScalarGeoGaugeCovD[];
tmp//=ToGeometric;
RicciScalarGeoGaugeCovDToGeometric=MakeRule[{RicciScalarGeoGaugeCovD[],Evaluate@tmp},MetricOn->All,ContractMetrics->True];
tmp=RicciScalarGeoGaugeCovD[];
DisplayExpression@tmp;
tmp=tmp/.RicciScalarGeoGaugeCovDToGeometric;
tmp//=ToGeoCanonical;
DisplayExpression@tmp;

Comment@"Next set up the post-Riemannian expansion of the Ricci tensor.";
tmp=RicciGeoGaugeCovD[-m,-n];
tmp//=ToGeometric;
tmp//=NoScalar;
RicciGeoGaugeCovDToGeometric=MakeRule[{RicciGeoGaugeCovD[-m,-n],Evaluate@tmp},MetricOn->All,ContractMetrics->True];
tmp=RicciGeoGaugeCovD[-m,-n];
DisplayExpression@tmp;
tmp=tmp/.RicciGeoGaugeCovDToGeometric;
tmp//=ToGeoCanonical;
DisplayExpression@tmp;

Subsection@"Irrep decomposition of the torsion";

Comment@"We will also present our conventions for the tensor, axial vector and vector parts of the torsion field.";
Expr=T[s,-m,-n];
DisplayExpression@Expr;
Expr=Expr/.TSO13Activate;
Expr//=ToNewCanonical;
DisplayExpression@Expr;

Subsection@"Torsion Maxwell tensors";
MaxwellSymb="\[ScriptCapitalF]";
DefTensor[Maxwell1[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[MaxwellSymb,xAct`HiGGS`Private`SO1]];
DefTensor[NonlinearMaxwell1[-a,-b],M4,PrintAs->xAct`HiGGS`Private`SymbolBuild["n"<>MaxwellSymb,xAct`HiGGS`Private`SO1]];
DefTensor[Maxwell2[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[MaxwellSymb,xAct`HiGGS`Private`SO2]];
DefTensor[Maxwell3[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[MaxwellSymb,xAct`HiGGS`Private`SO3]];

DualMaxwellSymb="\[FivePointedStar]\[ScriptCapitalF]";
DefTensor[DualMaxwell3[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[DualMaxwellSymb,xAct`HiGGS`Private`SO3]];
MaxwellToDual3=MakeRule[{Maxwell3[c,d],
	epsilonGeoG[c,d,-e,-f]DualMaxwell3[e,f]},
	MetricOn->All,ContractMetrics->True];

Expr=epsilonGeoG[a,b,-c,-d]Maxwell3[c,d]/.MaxwellToDual3//ToCanonical;
Expr=Expr-epsilonGeoG[a,b,-c,-d]Maxwell3[c,d]//ToCanonical;
DualToMaxwell3=MakeQuotientRule[{DualMaxwell3[a,b],Expr}];
Expr=Maxwell3[-m,-n];
Expr=Expr/.MaxwellToDual3;
Expr//=ToGeoCanonical;
Expr=Expr/.DualToMaxwell3;
Expr//=ToGeoCanonical;


Maxwell2~AutomaticRules~MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell2[c,d]],0},MetricOn->All,ContractMetrics->True];
Maxwell3~AutomaticRules~MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell3[c,d]],0},MetricOn->All,ContractMetrics->True];

Bianchi2=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell2[c,d]],0},MetricOn->All,ContractMetrics->True];
Bianchi2a=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[-z][GeoCovD[b][Maxwell2[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi2b=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][GeoCovD[-z][Maxwell2[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi3=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][Maxwell3[c,d]],0},MetricOn->All,ContractMetrics->True];
Bianchi3a=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[-z][GeoCovD[b][Maxwell3[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi3b=MakeRule[{epsilonGeoG[-a,-b,-c,-d]GeoCovD[b][GeoCovD[-z][Maxwell3[c,d]]],0},MetricOn->All,ContractMetrics->True];
Bianchi=Join[Bianchi2,Bianchi2a,Bianchi2b,Bianchi3,Bianchi3a,Bianchi3b];

ToMaxwell2=MakeRule[{GeoCovD[-a][T2[-b]],(1/2)Maxwell2[-a,-b]+(1/2)(GeoCovD[-a][T2[-b]]+GeoCovD[-b][T2[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell2b=MakeRule[{GeoCovD[-a]@GeoCovD[-j][T2[-b]],(1/2)GeoCovD[-j]@Maxwell2[-a,-b]+(1/2)GeoCovD[-j]@(GeoCovD[-a][T2[-b]]+GeoCovD[-b][T2[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell3=MakeRule[{GeoCovD[-a][T3[-b]],(1/2)Maxwell3[-a,-b]+(1/2)(GeoCovD[-a][T3[-b]]+GeoCovD[-b][T3[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell3b=MakeRule[{GeoCovD[-a]@GeoCovD[-j][T3[-b]],(1/2)GeoCovD[-j]@Maxwell3[-a,-b]+(1/2)GeoCovD[-j]@(GeoCovD[-a][T3[-b]]+GeoCovD[-b][T3[-a]])},MetricOn->All,ContractMetrics->True];
ToMaxwell=Join[ToMaxwell2,ToMaxwell3];
ToMaxwellb=Join[ToMaxwell2b,ToMaxwell3b];

FromMaxwell2=MakeRule[{Maxwell2[-a,-b],(GeoCovD[-a][T2[-b]]-GeoCovD[-b][T2[-a]])},MetricOn->All,ContractMetrics->True];
FromMaxwell3=MakeRule[{Maxwell3[-a,-b],(GeoCovD[-a][T3[-b]]-GeoCovD[-b][T3[-a]])},MetricOn->All,ContractMetrics->True];
FromMaxwell=Join[FromMaxwell2,FromMaxwell3];


Expr=GeoCovD[-a][GeoCovD[-a1][T2[a1]]];
Expr//=ToGeoCanonical;
Expr=Expr-GeoCovD[-a][GeoCovD[-a1][T2[a1]]];
DivGradT2ToGradDivT2=MakeQuotientRule[{GeoCovD[-a1][GeoCovD[-a][T2[a1]]],Expr},Method->"Coefficient"];

Expr=GeoCovD[-a][GeoCovD[-a1][T3[a1]]];
Expr//=ToGeoCanonical;
Expr=Expr-GeoCovD[-a][GeoCovD[-a1][T3[a1]]];
DivGradT3ToGradDivT3=MakeQuotientRule[{GeoCovD[-a1][GeoCovD[-a][T3[a1]]],Expr},Method->"Coefficient"];


Expr=GeoCovD[-a][GeoCovD[c][T2[a]]];
Expr//=ToGeoCanonical;
GradDivT2ToDivGradT2=MakeQuotientRule[{GeoCovD[c][GeoCovD[-a][T2[a]]],Expr-GeoCovD[-a][GeoCovD[c][T2[a]]]}];

Expr=GeoCovD[-a][GeoCovD[c][T3[a]]];
Expr//=ToGeoCanonical;
GradDivT3ToDivGradT3=MakeQuotientRule[{GeoCovD[c][GeoCovD[-a][T3[a]]],Expr-GeoCovD[-a][GeoCovD[c][T3[a]]]}];
GradDivToDivGrad=Join[GradDivT2ToDivGradT2,GradDivT3ToDivGradT3];

Comment@{"It is natural to define some Maxwell tensors",Inline@Maxwell2[-m,-n]," and",Inline@Maxwell3[-m,-n]," for the vector parts of the torsion, such as follows."};
Expr=Maxwell2[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.FromMaxwell;
DisplayExpression@Expr;

Subsection@"The 2-form field";

Comment@"Now we define a general 2-form field.";

Maxwell1Expr=(GeoCovD[-c][T1[c,-a,-b]]-GeoCovD[-c][T1[c,-b,-a]]
		-Maxwell2[-a,-b]
		+(3/4)*epsilonGeoG[-a,-b,-c,-d]*Maxwell3[c,d]
	);

NonlinearMaxwellSymb="\[ScriptCapitalB]";
DefTensor[GeneralMaxwell1[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[NonlinearMaxwellSymb]];

FromGeneralMaxwell1=MakeRule[{GeneralMaxwell1[-a,-b],Evaluate@Maxwell1Expr/MPl},MetricOn->All,ContractMetrics->True];

Expr=(
		(1/2)*(
			MPl*GeneralMaxwell1[-a,-b]
			-(Evaluate@(MPl*GeneralMaxwell1[-a,-b]/.FromGeneralMaxwell1)
				-(GeoCovD[-c][T1[c,-a,-b]]-GeoCovD[-c][T1[c,-b,-a]])))
		+(1/2)*(GeoCovD[-c][T1[c,-a,-b]]+GeoCovD[-c][T1[c,-b,-a]])
)//ToNewCanonical;

ToGeneralMaxwell1c=MakeRule[{
		GeoCovD[-c][T1[c,-a,-b]],
		Evaluate@Expr
	},
	MetricOn->All,ContractMetrics->True];

ToGeneralMaxwell1d=MakeRule[{
		GeoCovD[-c]@GeoCovD[-j][T1[c,-a,-b]],
		Evaluate@(GeoCovD[-j]@Expr)
	},
	MetricOn->All,ContractMetrics->True];

ToGeneralMaxwell1=ToGeneralMaxwell1c;
(*ToGeneralMaxwell1=Join[ToGeneralMaxwell1a,ToGeneralMaxwell1b];*)

ToNonlinearMaxwell=Join[ToGeneralMaxwell1,ToMaxwell2,ToMaxwell3];

ToNonlinearMaxwellb=ToGeneralMaxwell1d;

FromNonlinearMaxwell=Join[FromGeneralMaxwell1,FromMaxwell2,FromMaxwell3];

NewExpr=GeneralMaxwell1[-a,-b];
DisplayExpression@NewExpr;
NewExpr=NewExpr/.FromNonlinearMaxwell;
NewExpr//=ToNewCanonical;
DisplayExpression[NewExpr,EqnLabel->"KalbRamondDef"];

Comment@{"Note that in",Cref@"KalbRamondDef"," and moving forward, the symbol",Inline@(epsilonGeoG[a,b,c,d])," denotes the totally antisymmetric tensor, covariantised with respect to",Inline@(GeoG[-m,-n]),"."};

Constraint1=MakeRule[{GeoCovD[b]@GeoCovD[c]@GeneralMaxwell1[-b,-c],0},MetricOn->All,ContractMetrics->True];
Constraint2=MakeRule[{epsilonGeoG[-a,-b,q,p]*GeoCovD[a]@GeoCovD[b]@GeoCovD[c]@GeneralMaxwell1[d,e],0},MetricOn->All,ContractMetrics->True];
Constraints=Join[Constraint1,Constraint2];

Section@"Summary of findings: when we want the vector to propagate";

Comment@"The next few sections will be focussed on the following class of torsion theory, in which the Einstein-Hilbert term is augmented by the square of the antisymmetric Ricci tensor, and by a vector torsion mass term, and by a multiplier which switches off the axial vector torsion.";

Lagrangian=-(1/2)*MPl^2*RicciScalarGeoGaugeCovD[]+AlphaCoupling*(RicciGeoGaugeCovD[-a,-b]-RicciGeoGaugeCovD[-b,-a])*RicciGeoGaugeCovD[a,b]+Mu2*MPl^2*(T[i,-i,-m])*(T[j,-j,m])+TLambda3[-m]*(epsilonGeoG[m,a,b,c]*T[-a,-b,-c]/6);
Lagrangian=Lagrangian/.TSO13Activate;
Lagrangian//=ToNewCanonical;
Lagrangian//=CollectTensors;
DisplayExpression[Lagrangian,EqnLabel->"VectorSectionLagr"];
(*
Expr=RiemannGeoGaugeCovD[i,j,m,n]*Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[(1/2)(GeoG[-i,-m]GeoG[x,-j]GeoG[y,-n]+GeoG[-j,-n]GeoG[x,-i]GeoG[y,-m]-GeoG[-j,-m]GeoG[x,-i]GeoG[y,-n]-GeoG[-i,-n]GeoG[x,-j]GeoG[y,-m])Antisymmetrize[GeoG[-x,a]GeoG[-y,c]GeoG[b,d],{-x,-y}],{-i,-j}],{-m,-n}],{a,b}],{c,d}]*RiemannGeoGaugeCovD[-a,-b,-c,-d];
Expr//=ToNewCanonical;
DisplayExpression@Expr;
Quit[];
*)
Comment@{"By setting to zero either or both of the mass and multiplier terms in",Cref@"VectorSectionLagr",", we find some interesting effects in the linear spectra. These are summarised in the following table. Note that there are always an extra +2 d.o.f from Einstein's graviton."};
Expr=TextGrid[{{Null,"(No conditions)",Mu2==0,TLambda3[m]==0,Mu2==TLambda3[m]==0},{"Linear d.o.f",HoldForm[6+2],HoldForm[3+2],HoldForm[3+2],HoldForm[0+2]},{"Nonlinear d.o.f",HoldForm[6+2],HoldForm[6+2],HoldForm[6+2],HoldForm[6+2]}},Frame->All];
DisplayExpression[Expr,EqnLabel->"VectorSectionTable"];

Manuscript@{"Note that we can now compare",Cref@"VectorSectionTable"," with",Mref["FullTable",Kind->"Table"]," in the manuscript. Not all the information is present: we are focussing here specifically on the variations of the model which we would naively think to try, i.e. those for which we do not invoke the tensor multiplier",Inline@(T1[a,-m,-n]),". Note that the order of columns in these two tables differs."};

Manuscript@{"The various columns in this table appear to cause some surprise, such as `how does the multiplier not kill off 3 d.o.f' and `how can the spectrum be completely empty'. We will now explore how these effects come to pass; in short it is all due to the interesting mediating effect of the tensor part of the torsion. We will focus mostly on the linear spectrum, but for the case which is thoroughly discussed in the manuscript (i.e. the 2nd column), we will also use Lagrangian techniques to examine the nonlinear spectrum. Later, we will exchange the vector for its axial counterpart (for which ",Inline@(AlphaCoupling>0),"). In that version of the theory, we will again tabulate and study the possible combinations of multipliers and masses, but for each case we will explicitly demonstrate the full nonlinear spectrum using Hamiltonian techniques."};

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Vector/MassMultiplier.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Vector/Multiplier.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Vector/NonlinearMultiplier.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Vector/Mass.m"};

Section@"Summary of findings: when we want the axial vector to propagate";

Comment@"These final few sections are focussed on the following class of torsion theory, in which the Einstein-Hilbert term is augmented by the square of the antisymmetric Ricci tensor, and by an axial vector torsion mass term, and by a multiplier which switches off the vector torsion.";

Lagrangian=-(1/2)*MPl^2*RicciScalarGeoGaugeCovD[]+AlphaCoupling*(RicciGeoGaugeCovD[-a,-b]-RicciGeoGaugeCovD[-b,-a])*RicciGeoGaugeCovD[a,b]+Mu3*MPl^2*(epsilonGeoG[-m,i,j,k]*T[-i,-j,-k]/6)*(epsilonGeoG[m,a,b,c]*T[-a,-b,-c]/6)+TLambda2[-m]*(T[c,-c,m]);
Lagrangian=Lagrangian/.TSO13Activate;
Lagrangian//=ToNewCanonical;
Lagrangian//=CollectTensors;
DisplayExpression[Lagrangian,EqnLabel->"Lagr"];

Comment@{"By setting to zero either or both of the mass and multiplier terms in",Cref@"Lagr",", we find some interesting effects in the linear spectra. These are summarised in the following table. Note that there are always an extra +2 d.o.f from Einstein's graviton."};
Expr=TextGrid[{{Null,"(No conditions)",Mu3==0,TLambda2[m]==0,Mu3==TLambda2[m]==0},{"Linear d.o.f",HoldForm[6+2],HoldForm[3+2],HoldForm[3+2],HoldForm[0+2]},{"Nonlinear d.o.f",HoldForm[6+2],HoldForm[6+2],HoldForm[6+2],HoldForm[6+2]}},Frame->All];
DisplayExpression[Expr,EqnLabel->"Table"];

Manuscript@{"Of course, as we argue in our manuscript,",Cref@{"VectorSectionLagr","Lagr"}," are equivalent theories, the only difference being in the sign of",Inline@(AlphaCoupling)," for which we might be led to believe (naively) that each is viable. Once again, the table is surprising, and we will study each column. Unlike in the case for",Cref@"VectorSectionLagr",", we will not study any of the theories at cubic or higher order using Lagrangian methods. Instead, we use the field equations (Lagrangian methods) to study the linear spectra, and then use the Hamiltonian analysis to study the full nonlinear spectra, including the linear limit."};

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/MassMultiplier.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Multiplier.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Mass.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials/Nothing.m"};
Manuscript@"This concludes our analysis.";

Quit[];
