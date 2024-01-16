
DefConstantSymbol[PerturbativeParameter,PrintAs->xAct`HiGGS`Private`SymbolBuild@"\[Epsilon]"];

NonlinearTensors={T1,T2,T3,Maxwell1,Maxwell2,RiemannGeoCovD,RicciGeoCovD,RicciScalarGeoCovD,GeneralMaxwell1};

PerturbativeExpand={};
(PerturbativeExpand~AppendTo~{#@SomeIndices___->PerturbativeParameter*(#@SomeIndices)})&/@NonlinearTensors;
(PerturbativeExpand~AppendTo~{GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

(PerturbativeExpand~AppendTo~{GeoCovD[Index2_]@GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index2]@GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

(PerturbativeExpand~AppendTo~{GeoCovD[Index3_]@GeoCovD[Index2_]@GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index3]@GeoCovD[Index2]@GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

(PerturbativeExpand~AppendTo~{GeoCovD[Index4_]@GeoCovD[Index3_]@GeoCovD[Index2_]@GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index4]@GeoCovD[Index3]@GeoCovD[Index2]@GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

PerturbativeExpand//=Flatten;

LineariseQuantity[Expr_,Order_:1]:=Module[{LinearisedExpr=Expr}, 
	LinearisedExpr=LinearisedExpr/.PerturbativeExpand;
	LinearisedExpr=LinearisedExpr~Series~{PerturbativeParameter,0,Order};
	LinearisedExpr//=Normal;
	LinearisedExpr=LinearisedExpr/.{PerturbativeParameter->1};
	LinearisedExpr];

Section@{"Column 2 of",Cref@"VectorSectionTable",": Axial multiplier, but no vector mass (nonlinear extension)"};
Subsection@"Setting up the Lagrangian";
Comment@{"We define the Lagrangian. It contains vanishing vector mass parameter",Inline@Mu2," and a multiplier field",Inline@TLambda3[m]," to disable the axial torsion."};
Lagrangian=HoldForm[-(1/2)*MPl^2*RicciScalarGeoGaugeCovD[]+AlphaCoupling*(RicciGeoGaugeCovD[-a,-b]-RicciGeoGaugeCovD[-b,-a])*RicciGeoGaugeCovD[a,b]+TLambda3[-m]*(epsilonGeoG[m,a,b,c]*T[-a,-b,-c]/6)];

Lagrangian2=Lagrangian//=ReleaseHold;
Lagrangian2=Lagrangian2/.TSO13Activate;
Lagrangian2//=ToNewCanonical;
Lagrangian2//=CollectTensors;
DisplayExpression[Lagrangian2,EqnLabel->"NonlinearVectorSectionqqInitialLagrangian"];

Lagrangian//=ReleaseHold;
Lagrangian//=Evaluate;
Lagrangian//=ToCanonical;

Comment@{"Now we would like to have the post-Riemannian decomposition of the Lagrangian",Cref@"NonlinearVectorSectionqqInitialLagrangian","."};
Lagrangian=Lagrangian/.RicciGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
Lagrangian=Lagrangian/.RicciScalarGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"NonlinearVectorSectionqqPostRiemannianExpansion"];

Comment@{"We want to study the theory when it is nonlinear. As an intermediate step in order to do this, we just keep in",Cref@"NonlinearVectorSectionqqPostRiemannianExpansion"," the third-order terms in torsion and no higher: this differs obviously from",Cref@{"VectorSectionqqPostRiemannianExpansion","VectorSectionqqLinearPostRiemannianExpansion"}," above. Also from this point onwards we completely neglect factors of the curvature which may arise in the field equations by commuting covariant derivatives."};
PertT=MakeRule[{T[a,-m,-n],PertParam*T[a,-m,-n]},MetricOn->All,ContractMetrics->True];
Lagrangian=Lagrangian/.PertT;
Lagrangian=Series[Lagrangian,{PertParam,0,3}];
Lagrangian//=Normal;
Lagrangian=Lagrangian/.{PertParam->1};
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"NonlinearVectorSectionqqLinearPostRiemannianExpansion"];

Comment@{"Now we decompose the torsion in",Cref@"NonlinearVectorSectionqqLinearPostRiemannianExpansion"," into the Lorentz irreps."};
WholeLagrangian=Lagrangian;
Lagrangian=Lagrangian/.TSO13Activate;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"NonlinearVectorSectionqqPostRiemannianExpansion"];

Subsection@"Manipulating the field equations";
Comment@"Here is the tensor field equation.";
Expr=VarD[T[a,-b,-c],GeoCovD][WholeLagrangian];
Expr=Expr/.TSO13Activate;
Expr//=ToGeoCanonical;
Expr=PT1[i,-j,-k,a,-b,-c]*Expr;
Expr=Expr/.PActivate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ToGeoCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn1"];
Eqn1s=Expr;
Comment@{"There is some nuance to how we obtain",Cref@"NonlinearVectorSectionqqEqn1",", in that we can't just vary with respect to the tensor irrep. If we do that, then the resulting equation can have traces which are not true on-shell. It is safest to actually vary with respect to the whole torsion tensor and then project out the (traceless by construction) tensor irrep from that equation."};

Comment@"Now for the vector equation.";
Expr=VarD[T2[-m],GeoCovD][Lagrangian];
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ToGeoCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn2"];
Eqn2=Expr;

Comment@"And for the axial vector equation.";
Expr=VarD[T3[-m],GeoCovD][Lagrangian];
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ToGeoCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn3"];
Eqn3=Expr;

Comment@{"Now we can also take the dual of",Cref@"NonlinearVectorSectionqqEqn3",", and so we write this out for completeness."};
Eqn3b=ReplaceDummies[Expr]*epsilonGeoG[-m,a,b,c];
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.ToMaxwell;
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Eqn3b,EqnLabel->"NonlinearVectorSectionqqEqn3s"];

Comment@"Finally we have the equation for the multiplier itself.";
DisplayEquation[T3[-m],EqnLabel->"NonlinearVectorSectionqqEqnTLambda2"];

Comment@{"With the effective 2-form field in",Cref@"KalbRamondDef",", we are ready to simplify the equations of motion."};
Comment@{"Here is the vector equation",Cref@"NonlinearVectorSectionqqEqn2","."};
Expr=Eqn2;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T3->Zero,Maxwell3->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn2j"];
(*T2ToB=MakeQuotientRule[{T2[m],Expr},Method->"Coefficient"];*)
T2ToB=MakeQuotientRule[{T2[m],Expr},Method->"Coefficient"];

Manuscript@{"Compare",Cref@"NonlinearVectorSectionqqEqn2j"," with",Mref@"ReducedNonlinearSpinEquation2"," in our manuscript (note that many higher-order terms will cancel after expanding the third term using",Cref@"KalbRamondDef",")."};

Comment@{"Here is the axial vector equation",Cref@"NonlinearVectorSectionqqEqn3","."};
Expr=Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T3->Zero,Maxwell3->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn3j"];
T3ToB=MakeQuotientRule[{TLambda3[m],Expr},Method->"Coefficient"];
Eqn3=Expr;

Comment@{"Again here is the dual part of",Cref@"NonlinearVectorSectionqqEqn3j"};
Expr=epsilonGeoG[-m,-i,-j,-k]*Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T3->Zero,Maxwell3->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn3sj"];
Comment@{"Note that",Cref@{"NonlinearVectorSectionqqEqn2j","NonlinearVectorSectionqqEqn3j"}," allow us to solve for",Inline@T2[-m]," and",Inline@TLambda3[m]," in terms of the 2-form to linear order, and the (general) torsion at higher orders."};

Comment@{"And here is the tensor equation",Cref@"NonlinearVectorSectionqqEqn1","."};
Expr=Eqn1s;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.ToNonlinearMaxwellb;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.MaxwellToDual3;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.DualToMaxwell3;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.Bianchi;
Expr//=ToNewCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn1j"];
Expr2=Expr;

Manuscript@{"Compare",Cref@"NonlinearVectorSectionqqEqn1j"," with",Mref@"Perturbative"," in our manuscript."};

Comment@"Now we want to be able to solve for the tensor in terms of the 2-form field.";
Expr=Symmetrize[GeoG[-l,-i]Evaluate@Expr,{-l,-k}];
Expr//=ToNewCanonical;
Expr//=ToCanonical;
Expr=Expr-Evaluate[Expr~Coefficient~T1[-j,-k,-l]](T1[-k,-l,-j]+T1[-l,-j,-k]+T1[-j,-k,-l]);
Expr//=ToNewCanonical;
ExplicitExpression=Expr;
Expr//=ToGeoCanonical;
(*Expr//=ApplyBianchi;*)
Expr=LineariseQuantity[Expr,2];

Expr=Expr/.FromMaxwell;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T2ToB;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T3ToB;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
DisplayEquation[Expr,EqnLabel->"TrialSolve"];
T1ToB=MakeQuotientRule[{T1[-k,-l,-j],Expr},Method->"Coefficient"];

Comment@{"Note that",Cref@"TrialSolve"," allows us to solve for",Inline@(T1[a,-m,-n])," in terms of the 2-form field to linear order, and in terms of itself at higher orders: clearly this facilitates a perturbative solution approach."};

Expr=Expr2;
Comment@{"Now the next thing we do is to take the divergence of",Cref@"NonlinearVectorSectionqqEqn1j","."};
Expr//=GeoCovD[-i];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn1k"];

Comment@{"Next we substitute into",Cref@"NonlinearVectorSectionqqEqn1k"," for the 2-form field in",Cref@"KalbRamondDef"," again."};
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.ToNonlinearMaxwellb;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.MaxwellToDual3;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.DualToMaxwell3;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.Bianchi;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn1l"];

Comment@{"Next we will take",Cref@"NonlinearVectorSectionqqEqn1l"," and expand the vector and axial Maxwell tensors back into derivatives, and substitute for the solutions in terms of the 2-form field that we obtained from",Cref@{"NonlinearVectorSectionqqEqn2j","NonlinearVectorSectionqqEqn3j"},". We apply the suggestive perturbative solution approach for torsion in terms of the two-form field, finally ending up with the following nonlinear field equation (i.e. from the cubic action)."};
Expr=Expr/.FromMaxwell;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T2ToB;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T3ToB;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T1ToB;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
(*Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};*)
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;


Expr=Expr/.FromMaxwell;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T2ToB;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T3ToB;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.T1ToB;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr=LineariseQuantity[Expr,2];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
(*Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};*)
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero,Maxwell3->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;




DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn1p"];
Expr2=Expr;

Comment@{"So now the equation in",Cref@"NonlinearVectorSectionqqEqn1p"," contains all the dynamical information about the linear spectrum of the theory",Cref@"NonlinearVectorSectionqqInitialLagrangian",", since",Cref@{"NonlinearVectorSectionqqEqn2j","NonlinearVectorSectionqqEqn3j","NonlinearVectorSectionqqEqn1j"}," serve only to determine the torsion in terms of the 2-form. So the key question is how much of the 2-form does",Cref@"NonlinearVectorSectionqqEqn1p"," propagate?"};
Comment@{"For the linearised version of",Cref@"NonlinearVectorSectionqqEqn1p",", we found that taking the divergence led to a constraint (cf.",Cref@"VectorSectionqqEqn1x","). Let's take the divergence of the full",Cref@"NonlinearVectorSectionqqEqn1p","."};
Expr//=GeoCovD[j];
Expr//=SortCovDs;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.Constraints;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"NonlinearVectorSectionqqEqn1x"];
Comment@{"So",Cref@"NonlinearVectorSectionqqEqn1x"," is no longer a constraint, and it no longer knocks out 3 d.o.f from the 2-form."};
Manuscript@{"We regain 3 d.o.f from the relaxed constraint in the cubic extension to the theory, we conclude that all the 2-form propagates, i.e. 6 propagating d.o.f in the nonlinear spectrum. Note that we may directly integrate",Cref@"NonlinearVectorSectionqqEqn1p"," to produce (in flat space) the first and second lines in the effective theory",Mref@"BadEffective"," in our manuscript."};
