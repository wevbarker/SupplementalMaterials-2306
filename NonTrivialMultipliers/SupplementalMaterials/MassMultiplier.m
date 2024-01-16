Section@{"Column 1 of",Cref@"Table",": Axial mass and vector multiplier"};
Subsection@"Setting up the Lagrangian";
Comment@{"We define the Lagrangian. It contains both the nonvanishing axial mass parameter",Inline@Mu3," and a multiplier field",Inline@TLambda2[m]," to disable the vector torsion."};
Lagrangian=HoldForm[-(1/2)*MPl^2*RicciScalarGeoGaugeCovD[]+AlphaCoupling*(RicciGeoGaugeCovD[-a,-b]-RicciGeoGaugeCovD[-b,-a])*RicciGeoGaugeCovD[a,b]+Mu3*MPl^2*(epsilonGeoG[-m,i,j,k]*T[-i,-j,-k]/6)*(epsilonGeoG[m,a,b,c]*T[-a,-b,-c]/6)+TLambda2[-m]*(T[c,-c,m])];

Lagrangian2=Lagrangian//=ReleaseHold;
Lagrangian2=Lagrangian2/.TSO13Activate;
Lagrangian2//=ToNewCanonical;
Lagrangian2//=CollectTensors;
DisplayExpression[Lagrangian2,EqnLabel->"InitialLagrangian"];

Lagrangian//=ReleaseHold;
Lagrangian//=Evaluate;
Lagrangian//=ToCanonical;

Comment@{"Let's now look at the full nonlinear Hamiltonian analysis of",Cref@"InitialLagrangian","."};
ShowMatrix@"ConstraintAlgebraAlp0Alp5Bet3cBet2.pdf";
Comment@"According to this analysis we will have the following d.o.f in the linear spectrum. We compute this by adding the naive canonical d.o.f from the tetrad and the spin connection, and any multiplier fields, then subtracting the Poincaré and kinematic constraints, then subtracting the primaries and then the secondaries, and the result is then halved.";
Expr=HoldForm[(2*16+2*24+2*4-2*10-2*10-(1+3+5+1+1+5+5+1+3)-(1+1+5))/2==6+2];
DisplayExpression[Expr,EqnLabel->"EqnXX"];
Expr//=ReleaseHold;
Manuscript@"So we expect 6 d.o.f in the linear spectrum, apart from the two polarisations of Einstein's graviton, from the Hamiltonian analysis. The nonlinear analysis yields the same number of d.o.f, so there is no strong coupling.";

Comment@{"Now we would like to have the post-Riemannian decomposition of the Lagrangian",Cref@"InitialLagrangian","."};
Lagrangian=Lagrangian/.RicciGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
Lagrangian=Lagrangian/.RicciScalarGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"PostRiemannianExpansion"];

Comment@{"We want to study the theory when it is linearised. As an intermediate step in order to do this, we just keep in",Cref@"PostRiemannianExpansion"," the second-order terms in torsion and no higher. Also from this point onwards we completely neglect factors of the curvature which may arise in the field equations by commuting covariant derivatives."};
PertT=MakeRule[{T[a,-m,-n],PertParam*T[a,-m,-n]},MetricOn->All,ContractMetrics->True];
Lagrangian=Lagrangian/.PertT;
Lagrangian=Series[Lagrangian,{PertParam,0,2}];
Lagrangian//=Normal;
Lagrangian=Lagrangian/.{PertParam->1};
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"LinearPostRiemannianExpansion"];

Comment@{"Now we decompose the torsion in",Cref@"LinearPostRiemannianExpansion"," into the Lorentz irreps."};
WholeLagrangian=Lagrangian;
Lagrangian=Lagrangian/.TSO13Activate;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"PostRiemannianExpansion"];

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
DisplayEquation[Expr,EqnLabel->"Eqn1"];
Eqn1s=Expr;
Comment@{"There is some nuance to how we obtain",Cref@"Eqn1",", in that we can't just vary with respect to the tensor irrep. If we do that, then the resulting equation can have traces which are not true on-shell. It is safest to actually vary with respect to the whole torsion tensor and then project out the (traceless by construction) tensor irrep from that equation."};

Comment@"Now for the vector equation.";
Expr=VarD[T2[-m],GeoCovD][Lagrangian];
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ToGeoCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Expr,EqnLabel->"Eqn2"];
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
DisplayEquation[Expr,EqnLabel->"Eqn3"];
Eqn3=Expr;

Comment@{"Now we can also take the dual of",Cref@"Eqn3",", and so we write this out for completeness."};
Eqn3b=ReplaceDummies[Expr]*epsilonGeoG[-m,a,b,c];
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.ToMaxwell;
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Eqn3b,EqnLabel->"Eqn3s"];

Comment@"Finally we have the equation for the multiplier itself.";
DisplayEquation[T2[-m],EqnLabel->"EqnTLambda2"];

Comment@{"With the effective 2-form field in",Cref@"KalbRamondDef",", we are ready to simplify the equations of motion."};
Comment@{"Here is the vector equation",Cref@"Eqn2","."};
Expr=Eqn2;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
Expr=Expr/.{T2->Zero};
DisplayEquation[Expr,EqnLabel->"Eqn2j"];
(*T2ToB=MakeQuotientRule[{T2[m],Expr},Method->"Coefficient"];*)
T2ToB=MakeQuotientRule[{TLambda2[m],Expr},Method->"Coefficient"];

Comment@{"Here is the axial vector equation",Cref@"Eqn3","."};
Expr=Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"Eqn3j"];
T3ToB=MakeQuotientRule[{T3[m],Expr},Method->"Coefficient"];
Eqn3=Expr;

Comment@{"Again here is the dual part of",Cref@"Eqn3j"};
Expr=epsilonGeoG[-m,-i,-j,-k]*Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"Eqn3sj"];
Comment@{"Note that",Cref@{"Eqn2j","Eqn3j"}," allow us to solve for",Inline@T3[-m]," and",Inline@TLambda2[m]," purely in terms of the 2-form."};

Comment@{"And here is the tensor equation",Cref@"Eqn1","."};
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
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T2->Zero,Maxwell2->Zero};
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"Eqn1j"];

Comment@{"Now the next thing we do is to take the divergence of",Cref@"Eqn1j","."};
Expr//=GeoCovD[-i];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"Eqn1k"];

Comment@{"Next we substitute into",Cref@"Eqn1k"," for the 2-form field in",Cref@"KalbRamondDef"," again."};
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
DisplayEquation[Expr,EqnLabel->"Eqn1l"];

Comment@{"Next we will take",Cref@"Eqn1l"," and expand the vector and axial Maxwell tensors back into derivatives, and substitute for the solutions in terms of the 2-form field that we obtained from",Cref@{"Eqn2j","Eqn3j"},"."};
Expr=Expr/.FromMaxwell;
Expr=Expr/.T2ToB;
Expr=Expr/.T3ToB;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
(*Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};*)
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero,T2->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"Eqn1p"];
Expr2=Expr;

Comment@{"So now the equation in",Cref@"Eqn1p"," contains all the dynamical information about the linear spectrum of the theory",Cref@"InitialLagrangian",", since",Cref@{"Eqn2j","Eqn3j","Eqn1j"}," serve only to determine the torsion in terms of the 2-form. So the key question is how much of the 2-form does",Cref@"Eqn1p"," propagate?"};
Comment@{"Let's first take the divergence of",Cref@"Eqn1p","."};
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
DisplayEquation[Expr,EqnLabel->"Eqn1x"];
Comment@{"So",Cref@"Eqn1x"," still looks like a propagating equation."};
Comment@{"Let's now take the dual of the gradient of",Cref@"Eqn1p","."};
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
DisplayEquation[Expr,EqnLabel->"Eqn1y"];
Comment@{"So",Cref@"Eqn1y"," still looks like a propagating equation."};
Manuscript@{"Since we are unable to find non-propagating parts in the field equation, we conclude that the whole 2-form propagates, i.e. 6 propagating d.o.f in the linear spectrum. This agrees with",Cref@"EqnXX","."};
