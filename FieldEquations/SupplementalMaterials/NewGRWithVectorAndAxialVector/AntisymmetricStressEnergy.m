(*=============================*)
(*  AntisymmetricStressEnergy  *)
(*=============================*)

Subsection@"Antisymmetric part of tetrad equation";

Comment@{"Now we want to understand what the antisymmetric part of the tetrad equation is telling us in",Cref@"HealthyStressEnergyEquation","."};

Comment@{"The first step this time is to make use of the conservation law for the spin tensor as written in",Cref@"ConserveSigma",", since it allows us to fully replace precisely the antisymmetric part of the matter tetrad tensor."};

Expr=Antisymmetrize[StressEnergyEquation GeoG[-n, -j], {-i, -j}];
Expr=Expr/.CombineStressEnergy;
Expr//=ToGeometric;
Expr//=ToGeoCanonical;
Expr=Expr/.ConserveSigma;
Expr//=ToGeoCanonical;
Expr=Expr/.TSO13Activate;
Expr=Expr/.SuppressTensorTorsion;
Expr=Expr/.SigmaToGravity;
Expr//=ToGeoCanonical;
Expr//=ToCanonical;
DisplayEquation[Expr,EqnLabel->"EqnConserveSigma"];

Comment@{"Now we take",Cref@"EqnConserveSigma"," and we run through exactly the same steps as we did to get from",Cref@"EqnTauToThetaGravity"," to",Cref@"FinEinsteinEquation","."};

Comment@"Now again eliminate the multiplier.";

Expr=Expr/.TLambda1ToGravitySigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;

Comment@"Again eliminate d'Alembertians.";

Expr=Expr/.LapT2ToSigma;
Expr=Expr/.LapT3ToSigma;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;

Comment@"Again eliminate divergences.";

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
DisplayEquation@Expr;

Comment@"Again convert to Maxwell tensors.";

Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;

Comment@"Again employ the dual/Bianchi trick.";

Expr=Expr/.MaxwellToDual3;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DualToMaxwell3;
Expr//=ToGeoCanonical;
DisplayEquation@Expr;

Comment@"Now at last here is the antisymmetric part of the tetrad equation.";

DisplayEquation[Expr,EqnLabel->"AnIdentity"];

Comment@{"So, we quickly see that in",Cref@"AnIdentity"," the antisymmetric part of the tetrad equation just boils away to an identity."};

Manuscript@"The antisymmetric part of the tetrad equation just boils away to an identity.";
