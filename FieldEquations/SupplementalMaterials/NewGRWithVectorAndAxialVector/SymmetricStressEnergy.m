(*=========================*)
(*  SymmetricStressEnergy  *)
(*=========================*)

Subsection@"Symmetric part of tetrad equation";

Comment@{"We now jump straight in with the symmetric part of the tetrad equation in",Cref@"HealthyStressEnergyEquation","."};

Comment@{"We eliminate the second-order stress-energy tensor in favour of the Einstein tensor and gravitational variables using the equation",Cref@"TauToThetaGravity","."};

Expr=Symmetrize[StressEnergyEquation GeoG[-n, -j], {-i, -j}];
Expr//=ToGeoCanonical;
Expr=Expr/.TauToThetaGravity;
Expr//=ToGeoCanonical;
DisplayEquation[Expr,EqnLabel->"EqnTauToThetaGravity"];

Comment@{"We also eliminate from",Cref@"EqnTauToThetaGravity"," the tensor multiplier in favour of the spin and gravitational variables using our",Cref@"SolveForMultiplier","."};

Expr=Expr/.TLambda1ToGravitySigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"EqnSolveForMultiplier"];

Comment@{"We use dynamical torsion equations",Cref@"LapT2ToSigma"," and",Cref@"LapT3ToSigma"," to eliminate in",Cref@"EqnSolveForMultiplier"," d'Alembertians of torsion in favour of the spin tensor."};

Expr=Expr/.LapT2ToSigma;
Expr=Expr/.LapT3ToSigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"EqnLapT2ToSigma"];

Comment@{"We use dynamical torsion equations",Cref@"DivT2ToSigma"," and",Cref@"DivT3ToSigma"," to eliminate in",Cref@"EqnLapT2ToSigma"," divergences of torsion in favour of the spin tensor."};

Expr=Expr/.DivT2ToSigma;
Expr=Expr/.DivT3ToSigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DivGradT2ToGradDivT2;
Expr=Expr/.DivGradT3ToGradDivT3;
Expr=Expr/.DivT2ToSigma;
Expr=Expr/.DivT3ToSigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"EqnDivT2ToSigma"];

Comment@{"Convert remaining torsion derivatives to Maxwell tensors in",Cref@"EqnDivT2ToSigma","."};

Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"EqnMaxwell"];

Comment@{"Some curvature cross terms persist in",Cref@"EqnMaxwell",", so we notice that the third Maxwell tensor can be expressed in terms of its dual (and back again) using",Cref@"MaxwellToDual3",", and the intermediate Levi-Civita kills off those curvature couplings due to the Bianchi identity obeyed by the Maxwell tensors."};

Expr=Expr/.MaxwellToDual3;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DualToMaxwell3;
Expr//=ToGeoCanonical;
DisplayEquation[Expr,EqnLabel->"EqnMaxwell"];

Comment@{"Now we replace in",Cref@"EqnMaxwell"," the source current densities by non-density counterparts, defined in",Cref@"SigmaToSigmaTensor"," and",Cref@"ThetaToThetaTensor","."};

Expr=Expr/.ThetaToThetaTensor;
Expr=Expr/.SigmaToSigmaTensor;
Expr//=ToGeoCanonical;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;

EinsteinEquation=Expr;
DisplayEquation[EinsteinEquation,EqnLabel->"FinEinsteinEquation"];

Comment@{"And at last here in",Cref@"FinEinsteinEquation"," is the symmetric part of the tetrad equation."};

Manuscript@{"Here in",Cref@"FinEinsteinEquation"," is the symmetric tetrad equation of the effective theory."};
