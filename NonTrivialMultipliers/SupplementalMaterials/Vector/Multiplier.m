Section@{"Column 2 of",Cref@"VectorSectionTable",": Axial multiplier, but no vector mass"};
Subsection@"Setting up the Lagrangian";
Comment@{"We define the Lagrangian. It contains vanishing vector mass parameter",Inline@Mu2," and a multiplier field",Inline@TLambda3[m]," to disable the axial torsion."};
Lagrangian=HoldForm[-(1/2)*MPl^2*RicciScalarGeoGaugeCovD[]+AlphaCoupling*(RicciGeoGaugeCovD[-a,-b]-RicciGeoGaugeCovD[-b,-a])*RicciGeoGaugeCovD[a,b]+TLambda3[-m]*(epsilonGeoG[m,a,b,c]*T[-a,-b,-c]/6)];

Lagrangian2=Lagrangian//=ReleaseHold;
Lagrangian2=Lagrangian2/.TSO13Activate;
Lagrangian2//=ToNewCanonical;
Lagrangian2//=CollectTensors;
DisplayExpression[Lagrangian2,EqnLabel->"VectorSectionqqInitialLagrangian"];

Lagrangian//=ReleaseHold;
Lagrangian//=Evaluate;
Lagrangian//=ToCanonical;

Comment@{"Now we would like to have the post-Riemannian decomposition of the Lagrangian",Cref@"VectorSectionqqInitialLagrangian","."};
Lagrangian=Lagrangian/.RicciGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
Lagrangian=Lagrangian/.RicciScalarGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"VectorSectionqqPostRiemannianExpansion"];

Comment@{"We want to study the theory when it is linearised. As an intermediate step in order to do this, we just keep in",Cref@"VectorSectionqqPostRiemannianExpansion"," the second-order terms in torsion and no higher. Also from this point onwards we completely neglect factors of the curvature which may arise in the field equations by commuting covariant derivatives."};
PertT=MakeRule[{T[a,-m,-n],PertParam*T[a,-m,-n]},MetricOn->All,ContractMetrics->True];
Lagrangian=Lagrangian/.PertT;
Lagrangian=Series[Lagrangian,{PertParam,0,2}];
Lagrangian//=Normal;
Lagrangian=Lagrangian/.{PertParam->1};
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"VectorSectionqqLinearPostRiemannianExpansion"];

Comment@{"Now we decompose the torsion in",Cref@"VectorSectionqqLinearPostRiemannianExpansion"," into the Lorentz irreps."};
WholeLagrangian=Lagrangian;
Lagrangian=Lagrangian/.TSO13Activate;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"VectorSectionqqPostRiemannianExpansion"];

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
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1"];
Eqn1s=Expr;
Comment@{"There is some nuance to how we obtain",Cref@"VectorSectionqqEqn1",", in that we can't just vary with respect to the tensor irrep. If we do that, then the resulting equation can have traces which are not true on-shell. It is safest to actually vary with respect to the whole torsion tensor and then project out the (traceless by construction) tensor irrep from that equation."};

Comment@"Now for the vector equation.";
Expr=VarD[T2[-m],GeoCovD][Lagrangian];
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ToGeoCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn2"];
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
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn3"];
Eqn3=Expr;

Comment@{"Now we can also take the dual of",Cref@"VectorSectionqqEqn3",", and so we write this out for completeness."};
Eqn3b=ReplaceDummies[Expr]*epsilonGeoG[-m,a,b,c];
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.ToMaxwell;
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Eqn3b,EqnLabel->"VectorSectionqqEqn3s"];

Comment@"Finally we have the equation for the multiplier itself.";
DisplayEquation[T3[-m],EqnLabel->"VectorSectionqqEqnTLambda2"];

Comment@{"With the effective 2-form field in",Cref@"KalbRamondDef",", we are ready to simplify the equations of motion."};
Comment@{"Here is the vector equation",Cref@"VectorSectionqqEqn2","."};
Expr=Eqn2;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T3->Zero};
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn2j"];
(*T2ToB=MakeQuotientRule[{T2[m],Expr},Method->"Coefficient"];*)
T2ToB=MakeQuotientRule[{T2[m],Expr},Method->"Coefficient"];

Manuscript@{"Compare",Cref@"VectorSectionqqEqn2j"," with (the linear part of)",Mref@"ReducedNonlinearSpinEquation2"," in our manuscript."};

Comment@{"Here is the axial vector equation",Cref@"VectorSectionqqEqn3","."};
Expr=Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T3->Zero};
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn3j"];
T3ToB=MakeQuotientRule[{TLambda3[m],Expr},Method->"Coefficient"];
Eqn3=Expr;

Comment@{"Again here is the dual part of",Cref@"VectorSectionqqEqn3j"};
Expr=epsilonGeoG[-m,-i,-j,-k]*Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T3->Zero};
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn3sj"];
Comment@{"Note that",Cref@{"VectorSectionqqEqn2j","VectorSectionqqEqn3j"}," allow us to solve for",Inline@T2[-m]," and",Inline@TLambda3[m]," purely in terms of the 2-form."};

Comment@{"And here is the tensor equation",Cref@"VectorSectionqqEqn1","."};
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
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1j"];

Manuscript@{"Compare",Cref@"VectorSectionqqEqn1j"," with (the linear part of)",Mref@"Perturbative"," in our manuscript (note that many higher-order terms will cancel after expanding the third term using",Cref@"KalbRamondDef",")."};

Comment@{"Now the next thing we do is to take the divergence of",Cref@"VectorSectionqqEqn1j","."};
Expr//=GeoCovD[-i];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1k"];

Comment@{"Next we substitute into",Cref@"VectorSectionqqEqn1k"," for the 2-form field in",Cref@"KalbRamondDef"," again."};
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
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1l"];

Comment@{"Next we will take",Cref@"VectorSectionqqEqn1l"," and expand the vector and axial Maxwell tensors back into derivatives, and substitute for the solutions in terms of the 2-form field that we obtained from",Cref@{"VectorSectionqqEqn2j","VectorSectionqqEqn3j"},"."};
Expr=Expr/.FromMaxwell;
Expr=Expr/.T2ToB;
Expr=Expr/.T3ToB;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
(*Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};*)
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T3->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1p"];
Expr2=Expr;

Comment@{"So now the equation in",Cref@"VectorSectionqqEqn1p"," contains all the dynamical information about the linear spectrum of the theory",Cref@"VectorSectionqqInitialLagrangian",", since",Cref@{"VectorSectionqqEqn2j","VectorSectionqqEqn3j","VectorSectionqqEqn1j"}," serve only to determine the torsion in terms of the 2-form. So the key question is how much of the 2-form does",Cref@"VectorSectionqqEqn1p"," propagate?"};
Comment@{"Let's first take the divergence of",Cref@"VectorSectionqqEqn1p","."};
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
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1x"];
Comment@{"So",Cref@"VectorSectionqqEqn1x"," is just a constraint, which knocks out 3 d.o.f from the 2-form."};
Comment@{"Let's now take the dual of the gradient of",Cref@"VectorSectionqqEqn1p","."};
Expr=Expr2;
Expr=epsilonGeoG[v,j,k,q]*GeoCovD[-q]@Expr;
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
DisplayEquation[Expr,EqnLabel->"VectorSectionqqEqn1y"];
Comment@{"So",Cref@"VectorSectionqqEqn1y"," still looks like a propagating equation."};
Manuscript@{"Since we lose 3 d.o.f to a constraint, we conclude that half the 2-form propagates, i.e. 3 propagating d.o.f in the linear spectrum. Note that we may directly integrate",Cref@"VectorSectionqqEqn1p"," to produce (in flat space) the first line in the effective theory",Mref@"BadEffective"," in our manuscript. What about the second line? To explore this, we have to deal with the extension of the theory into the nonlinear regime."};
(*
Expr=-(1/6)*MPl^3*GeneralMaxwell1[-a,-b]*GeneralMaxwell1[a,b]+(AlphaCoupling*MPl/6)Antisymmetrize[GeoCovD[-a]@GeneralMaxwell1[-b,-c],{-a,-b,-c}]*Antisymmetrize[GeoCovD[a]@GeneralMaxwell1[b,c],{a,b,c}];
Expr//=ToCanonical;
Expr=VarD[GeneralMaxwell1[j,k],GeoCovD][Expr];
Expr//=ToCanonical;
Expr//=SortCovDs;
Expr//=ContractMetric;
Expr//=ScreenDollarIndices;
Expr//=CollectTensors;
DisplayExpression@Expr;
*)
