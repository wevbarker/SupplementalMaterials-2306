(*===============*)
(*  SpinTorsion  *)
(*===============*)

Subsection@"Spin connection equations";

Comment@"Finally, we would like to write the remaining spin connection equations in their most compact form.";

Comment@{"The vector part of the spin connection equation in",Cref@"HealthySpinEquation2","."};

Expr=SpinEquation2;
Expr=Expr/.SigmaToSigmaTensor;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
SpinEquation2=Expr;
DisplayEquation[SpinEquation2,EqnLabel->"ImprovedSpinEquation2"];

Manuscript@{"Here is another of the field equations: compare",Cref@"ImprovedSpinEquation2"," to",Mref@"ImprovedSpinEquation2"," in the manuscript."};

Comment@{"The axial vector part of the spin connection equation in",Cref@"HealthySpinEquation3","."};

Expr=SpinEquation3;
Expr=Expr/.SigmaToSigmaTensor;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
SpinEquation3=Expr;
DisplayEquation[SpinEquation3,EqnLabel->"ImprovedSpinEquation3"];

Manuscript@{"Here is another of the field equations: compare",Cref@"ImprovedSpinEquation3"," to",Mref@"ImprovedSpinEquation3"," in the manuscript."};
