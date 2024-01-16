Section@{"Column 4 of",Cref@"Table",": No axial mass, no vector multiplier"};
Subsection@"Setting up the Lagrangian";
Comment@{"We define the Lagrangian. It contains vanishing axial mass parameter",Inline@Mu3," and it does not contain a multiplier field",Inline@TLambda2[m],", which would ordinarily disable the vector torsion."};
Lagrangian=HoldForm[-(1/2)*MPl^2*RicciScalarGeoGaugeCovD[]+AlphaCoupling*(RicciGeoGaugeCovD[-a,-b]-RicciGeoGaugeCovD[-b,-a])*RicciGeoGaugeCovD[a,b]];

Lagrangian2=Lagrangian//=ReleaseHold;
Lagrangian2=Lagrangian2/.TSO13Activate;
Lagrangian2//=ToNewCanonical;
Lagrangian2//=CollectTensors;
DisplayExpression[Lagrangian2,EqnLabel->"vvInitialLagrangian"];

Lagrangian//=ReleaseHold;
Lagrangian//=Evaluate;
Lagrangian=Lagrangian/.PActivate;
Lagrangian//=ToCanonical;

Comment@{"Let's now look at the full nonlinear Hamiltonian analysis of",Cref@"vvInitialLagrangian","."};
ShowMatrix@"ConstraintAlgebraAlp0Alp5.pdf";
Comment@"According to this analysis we will have the following d.o.f in the linear spectrum. We compute this by adding the naive canonical d.o.f from the tetrad and the spin connection, and any multiplier fields, then subtracting the Poincaré and kinematic constraints, then subtracting the primaries and then the secondaries, and the result is then halved.";
Expr=HoldForm[(2*16+2*24-2*10-2*10-(1+3+3+5+1+1+5+5)-(3+3+1+5))/2==2];
DisplayExpression[Expr,EqnLabel->"vvEqnXX"];
Expr//=ReleaseHold;
Manuscript@"So we expect 0 d.o.f in the linear spectrum, apart from the two polarisations of Einstein's graviton, from the Hamiltonian analysis. The non-linear analysis confirms the existence of all 6 d.o.f, and so all 6 of them are strongly coupled.";

Comment@{"Now we would like to have the post-Riemannian decomposition of the Lagrangian",Cref@"vvInitialLagrangian","."};
Lagrangian=Lagrangian/.RicciGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
Lagrangian=Lagrangian/.RicciScalarGeoGaugeCovDToGeometric;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"vvPostRiemannianExpansion"];

Comment@{"We want to study the theory when it is linearised. As an intermediate step in order to do this, we just keep in",Cref@"vvPostRiemannianExpansion"," the second-order terms in torsion and no higher. Also from this point onwards we completely neglect factors of the curvature which may arise in the field equations by commuting covariant derivatives."};
PertT=MakeRule[{T[a,-m,-n],PertParam*T[a,-m,-n]},MetricOn->All,ContractMetrics->True];
Lagrangian=Lagrangian/.PertT;
Lagrangian=Series[Lagrangian,{PertParam,0,2}];
Lagrangian//=Normal;
Lagrangian=Lagrangian/.{PertParam->1};
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"vvLinearPostRiemannianExpansion"];

Comment@{"Now we decompose the torsion in",Cref@"vvLinearPostRiemannianExpansion"," into the Lorentz irreps."};
WholeLagrangian=Lagrangian;
Lagrangian=Lagrangian/.TSO13Activate;
Lagrangian//=ToGeoCanonical;
DisplayExpression[Lagrangian,EqnLabel->"vvPostRiemannianExpansion"];

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
DisplayEquation[Expr,EqnLabel->"vvEqn1"];
Eqn1s=Expr;
Comment@{"There is some nuance to how we obtain",Cref@"vvEqn1",", in that we can't just vary with respect to the tensor irrep. If we do that, then the resulting equation can have traces which are not true on-shell. It is safest to actually vary with respect to the whole torsion tensor and then project out the (traceless by construction) tensor irrep from that equation."};

Comment@"Now for the vector equation.";
Expr=VarD[T2[-m],GeoCovD][Lagrangian];
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ToGeoCanonical;
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Expr,EqnLabel->"vvEqn2"];
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
DisplayEquation[Expr,EqnLabel->"vvEqn3"];
Eqn3=Expr;

Comment@{"Now we can also take the dual of",Cref@"vvEqn3",", and so we write this out for completeness."};
Eqn3b=ReplaceDummies[Expr]*epsilonGeoG[-m,a,b,c];
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.ToMaxwell;
Eqn3b//=ToGeoCanonical;
Eqn3b=Eqn3b/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
DisplayEquation[Eqn3b,EqnLabel->"vvEqn3s"];

Comment@{"With the effective 2-form field in",Cref@"KalbRamondDef",", we are ready to simplify the equations of motion."};
Comment@{"Here is the vector equation",Cref@"vvEqn2","."};
Expr=Eqn2;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"vvEqn2j"];
T2ToB=MakeQuotientRule[{T2[m],Expr},Method->"Coefficient"];
(*T2ToB=MakeQuotientRule[{TLambda2[m],Expr},Method->"Coefficient"];*)

Comment@{"Here is the axial vector equation",Cref@"vvEqn3","."};
Expr=Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"vvEqn3j"];
T3ToB=MakeQuotientRule[{T3[m],Expr},Method->"Coefficient"];
Eqn3=Expr;

Comment@{"Again here is the dual part of",Cref@"vvEqn3j"};
Expr=epsilonGeoG[-m,-i,-j,-k]*Eqn3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToNewCanonical;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"vvEqn3sj"];
Comment@{"Note that",Cref@{"vvEqn2j","vvEqn3j"}," allow us to solve for",Inline@T3[-m]," and",Inline@T2[m]," purely in terms of the 2-form."};

Comment@{"And here is the tensor equation",Cref@"vvEqn1","."};
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
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"vvEqn1j"];

Comment@{"Now the next thing we do is to take the divergence of",Cref@"vvEqn1j","."};
Expr//=GeoCovD[-i];
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"vvEqn1k"];

Comment@{"Next we substitute into",Cref@"vvEqn1k"," for the 2-form field in",Cref@"KalbRamondDef"," again."};
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
DisplayEquation[Expr,EqnLabel->"vvEqn1l"];

Comment@{"Next we will take",Cref@"vvEqn1l"," and expand the vector and axial Maxwell tensors back into derivatives, and substitute for the solutions in terms of the 2-form field that we obtained from",Cref@{"vvEqn2j","vvEqn3j"},"."};
Expr=Expr/.FromMaxwell;
Expr=Expr/.T2ToB;
Expr=Expr/.T3ToB;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr//=SortCovDs;
(*Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};*)
Expr=Expr/.{RicciScalarGeoCovD->Zero,RicciGeoCovD->Zero,RiemannGeoCovD->Zero};
Expr//=ToNewCanonical;
Expr//=CollectTensors;
DisplayEquation[Expr,EqnLabel->"vvEqn1p"];
Expr2=Expr;

Comment@{"So now the equation in",Cref@"vvEqn1p"," contains all the dynamical information about the linear spectrum of the theory",Cref@"vvInitialLagrangian",", since",Cref@{"vvEqn2j","vvEqn3j","vvEqn1j"}," serve only to determine the torsion in terms of the 2-form. But clearly this tells us that none of the 2-form in",Cref@"vvEqn1p"," is propagating!"};
Manuscript@{"Since we lose all 6 d.o.f to a constraint, we conclude that there are 0 propagating d.o.f (besides the graviton) in the linear spectrum. This agrees with",Cref@"vvEqnXX","."};
