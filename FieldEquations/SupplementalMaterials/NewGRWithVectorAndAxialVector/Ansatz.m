(*==========*)
(*  Ansatz  *)
(*==========*)

Subsection@"Effective theory ansatz";

Comment@"The first task, since this is a case for which we believe we can exactly recover the effective theory, is to construct an ansatz for the effective Lagrangian.";

Comment@"First we define some constants with which to parameterise the ansatz.";

((ToExpression@"\[ScriptC]")~DefNiceConstantSymbol~i)~Table~({i,6});
AnsatzConstants=(ToExpression@("\[ScriptC]"<>ToString@i))~Table~({i,6});
DisplayExpression[AnsatzConstants,EqnLabel->"AnsatzConstants"];

co1=(ToExpression@"\[ScriptC]1");
co2=(ToExpression@"\[ScriptC]2");
co3=(ToExpression@"\[ScriptC]3");
co4=(ToExpression@"\[ScriptC]4");
co5=(ToExpression@"\[ScriptC]5");
co6=(ToExpression@"\[ScriptC]6");

Comment@"Next we define the Lagrangian density; note that we omit the matter Lagrangian.";

LagrangianDensity=Sqrt[-DetGeoG[]](
			-(MPl^2/2)RicciScalarGeoCovD[]
			-(co1/4)Maxwell2[-m,-n]Maxwell2[m,n]
			-(co2/4)Maxwell3[-m,-n]Maxwell3[m,n]
			-(co3/2)T2[-m]T2[m]
			-(co4/2)T3[-m]T3[m]
			-(co5/2)T2[-m]SigmaTensor2[m]
			-(co6/2)T3[-m]SigmaTensor3[m]
		);

LagrangianDensity//=ToGeoCanonical;
LagrangianDensity//=Simplify;
DisplayExpression[LagrangianDensity,EqnLabel->"LagrangianDensity"];

Comment@{"So the Ansatz",Cref@"LagrangianDensity"," is now parameterised in terms of the constants",Cref@"AnsatzConstants","."};

LagrangianDensity=LagrangianDensity/.FromMaxwell//ToCanonical;

TidyFieldEquations[FieldEquation_]:=Module[{Expr=FieldEquation},
	Expr//=ToGeoCanonical;
	Expr=Expr/.GradDivT2ToDivGradT2;
	Expr=Expr/.GradDivT3ToDivGradT3;
	Expr=Expr/.ToMaxwell;
	Expr//=ToGeoCanonical;
	Expr//=ApplyBianchi;
Expr];

Comment@{"In particular, here are the Einstein equations according to",Cref@"LagrangianDensity",", and we note that there is no matter stress-energy tensor because we neglected the Matter Lagrangian."};

TetradCorrection=-(
	(co5/8)T2[-i]SigmaTensor2[-j]
	+(co5/8)T2[-j]SigmaTensor2[-i]
	+(co6/8)T3[-i]SigmaTensor3[-j]
	+(co6/8)T3[-j]SigmaTensor3[-i]);

Expr=VarD[GeoG[i,j],GeoCovD][LagrangianDensity]/Sqrt[-DetGeoG[]];
Expr=Expr+TetradCorrection;
Expr//=TidyFieldEquations;
AnsatzEinsteinEquation=Expr;
DisplayEquation[AnsatzEinsteinEquation,EqnLabel->"AnsatzEinsteinEquation"];

(*Comment@{"Note also in",Cref@"AnsatzEinsteinEquation"," that the effective stress-energy tensor which emerges from the coupling between the torsion and spin vectors has been manually edited to reflect the tetrad-dependence and valence of the spin vectors, and this is supposed to be in line with our result in",Cref@"SpinCoupling","."};*)

Comment@{"Now here is the",Inline@T2[-a]," Proca equation from",Cref@"LagrangianDensity"," which should encode the vector part of the spin equation."};

Expr=VarD[T2[w],GeoCovD][LagrangianDensity]/Sqrt[-DetGeoG[]];
Expr//=TidyFieldEquations;
AnsatzSpinEquation2=Expr;
DisplayEquation[AnsatzSpinEquation2,EqnLabel->"AnsatzSpinEquation2"];

Comment@{"Here is the",Inline@T3[-a]," Proca equation from",Cref@"LagrangianDensity"," which should encode the axial vector part of the spin equation."};

Expr=VarD[T3[-c],GeoCovD][LagrangianDensity]/Sqrt[-DetGeoG[]];
Expr//=TidyFieldEquations;
AnsatzSpinEquation3=Expr;
DisplayEquation[AnsatzSpinEquation3,EqnLabel->"AnsatzSpinEquation3"];
