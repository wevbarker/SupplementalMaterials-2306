(*=============================*)
(*  AntisymmetricStressEnergy  *)
(*=============================*)

Comment@"Now we want to understand what the antisymmetric part of the stress
energy equation is telling us.";

Comment@"The first step this time is to make use of the conservation law for the
	spin tensor, since it allows us to replace precisely the antisymmetric
	part of the matter stress-energy tensor...";

Expr=Antisymmetrize[StressEnergyEquation GeoG[-n, -j], {-i, -j}];
Expr=Expr/.CombineStressEnergy;
Expr//=ToGeometric;
Expr//=ToGeoCanonical;
Expr=Expr/.ConserveSigma;
Expr//=ToGeoCanonical;
Expr=Expr/.TSO13Activate;
(*Expr=Expr/.SuppressTensorTorsion;*)
Expr=Expr/.SigmaToGravity;
Expr//=ToGeoCanonical;
Expr//=ToCanonical;

Comment@"Now again eliminate the multiplier...";

(*Expr=Expr/.TLambda1ToGravitySigma;*)
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Comment@"Again eliminate d'Alembertians...";

Expr=Expr/.LapT2ToSigma;
Expr=Expr/.LapT3ToSigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Comment@"Again eliminate divergences...";

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

Comment@"Again convert to Maxwell tensors...";

Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Comment@"Again employ dual/Bianchi trick...";

Expr=Expr/.MaxwellToDual3;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DualToMaxwell3;
Expr//=ToGeoCanonical;

Comment@"Okay, now at last here is the antisymmetric part of the stress-energy
equation:";

DisplayEquation@Expr;

Comment@"So, the antisymmetric part of the stress-energy tensor is just an identity.";
