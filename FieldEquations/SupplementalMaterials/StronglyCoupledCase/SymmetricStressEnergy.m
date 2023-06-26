(*=========================*)
(*  SymmetricStressEnergy  *)
(*=========================*)

Comment@"We now jump straight in with the symmetric part of the stress-energy
tensor.";

Comment@"Eliminate the second order stress-energy tensor in favour of the
Einstein tensor and gravitational variables...";

Expr=Symmetrize[StressEnergyEquation GeoG[-n, -j], {-i, -j}];
Expr//=ToGeoCanonical;
Expr=Expr/.TauToThetaGravity;
Expr//=ToGeoCanonical;

Comment@"Eliminate the tensor multiplier in favour of the spin and gravitational
variables...";

(*Expr=Expr/.TLambda1ToGravitySigma;*)
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Comment@"Use dynamical torsion equations to eliminate d'Alembertians of torsion
in favour of spin...";

Expr=Expr/.LapT2ToSigma;
Expr=Expr/.LapT3ToSigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Comment@"Eliminate divergences of the torsion using similar methods...";

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

Comment@"Convert remaining torsion derivatives to Maxwell tensors...";

Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Comment@"Some curvature cross terms persist, so notice that the third Maxwell
tensor can be expressed in terms of its dual (and back again), and the
intermediate Levi-Civita kills off those curvature couplings due to
Bianchi...";

Expr=Expr/.MaxwellToDual3;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DualToMaxwell3;
Expr//=ToGeoCanonical;

Comment@"Now we replace the source current densities by non-density
counterparts...";

Expr=Expr/.ThetaToThetaTensor;
Expr=Expr/.SigmaToSigmaTensor;
Expr//=ToGeoCanonical;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;

Comment@"Okay, at last here is the symmetric part of the stress-energy
equation:";

EinsteinEquation=Expr;
DisplayEquation@EinsteinEquation;

Comment@"We are finished with the symmetric part of the stress-energy equation.";
