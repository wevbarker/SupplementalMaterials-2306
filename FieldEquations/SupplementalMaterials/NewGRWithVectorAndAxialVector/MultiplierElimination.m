(*=========================*)
(*  MultiplierElimination  *)
(*=========================*)

Subsection@"Algebraic elimination of the multiplier";

Comment@{"We now use the symmetries of",Inline@TLambda1[-u,-v,-w]," to rearrange",Cref@"HealthySpinEquation1"," into a form where we can solve for the multiplier."};

Expr=Symmetrize[GeoG[-v,-r]Evaluate@SpinEquation1,{-v,-u}];
(*Expr*=cBet1;*)
Expr//=ToNewCanonical;
Expr//=ToCanonical;
Expr=Expr-Evaluate[Expr~Coefficient~TLambda1[-u,-w,-v]](TLambda1[-u,-v,-w]+TLambda1[-v,-w,-u]+TLambda1[-w,-u,-v]);
Expr//=ToNewCanonical;
(*Expr/=cBet1;*)
DisplayEquation[Expr,EqnLabel->"SolveForMultiplier"];

Manuscript@{"Here is another spin equation: compare",Cref@"SolveForMultiplier"," to",Mref@"SolveForMultiplier"," in the manuscript."};

TLambda1ToGravitySigma=MakeQuotientRule[{TLambda1[-u,-v,-w],Expr}];

SigmaToGravity=MakeQuotientRule[{Sigma[n,-i,-j],SpinEquation}];

TauToGravity=MakeQuotientRule[{TorsionlessTau[n,-i],StressEnergyEquation}];

Comment@{"Now we examine",Cref@"HealthySpinEquation2"," and",Cref@"HealthySpinEquation3"," to construct rules to replace the divergences of the torsion."};

Expr=SpinEquation2;
Expr=GeoCovD[w]@Expr;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"DivT2ToSigma"];
DivT2ToSigma=MakeQuotientRule[{GeoCovD[-a]@T2[a],Expr},Method->"Coefficient",Verify->False];

Expr=SpinEquation3;
Expr=GeoCovD[-c]@Expr;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"DivT3ToSigma"];
DivT3ToSigma=MakeQuotientRule[{GeoCovD[-a]@T3[a],Expr},Method->"Coefficient",Verify->False];

Comment@{"Now we examine",Cref@"HealthySpinEquation2"," and",Cref@"HealthySpinEquation3"," to construct rules to replace the d'Alembertians of the torsion."};

Expr=SpinEquation2;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DivT2ToSigma;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
DisplayEquation[Expr,EqnLabel->"LapT2ToSigma"];
LapT2ToSigma=MakeQuotientRule[{GeoCovD[-a]@GeoCovD[a]@T2[-w],Expr},Method->"Coefficient"];

Expr=SpinEquation3;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DivT3ToSigma;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
DisplayEquation[Expr,EqnLabel->"LapT3ToSigma"];
LapT3ToSigma=MakeQuotientRule[{GeoCovD[-a]@GeoCovD[a]@T3[c],Expr},Method->"Coefficient"];

Comment@{"We can now use the definition of the Belinfante-Rosenfeld tensor in",Cref@"ThetaEquation"," and the expression for the spin in terms of the gravitational fields in",Cref@"HealthySpinEquation",", to construct a rule to replace the general stress-energy tensor with the Belinfante-Rosenfeld tensor and gravitational fields."};

Expr=ThetaEqn/.SigmaToGravity;
Expr//=ToGeoCanonical;
Expr=Expr/.SigmaToSigmaTensor;
Expr//=ToGeoCanonical;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.TSO13Activate;
Expr=Expr/.TLambdaSO13Activate;
Expr=Expr/.SuppressTensorTorsion;
Expr//=ToGeoCanonical;
ThetaEqn=Expr;
DisplayEquation[ThetaEqn,EqnLabel->"TauToThetaGravity"];
TauToThetaGravity=MakeQuotientRule[{TorsionlessTau[m,-k],Evaluate@ThetaEqn},MetricOn->All,ContractMetrics->True];
