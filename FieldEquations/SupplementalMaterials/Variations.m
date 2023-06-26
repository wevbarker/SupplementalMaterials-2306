(*==============*)
(*  Variations  *)
(*==============*)

Comment@"At this point we will remind ourselves about the derivatives with respect to the tetrad of some quantities. This is really a tangent to the calculations, but the expressions may become useful later in the script. Because HiGGS is oriented towards the ADM formulation, you will see frequent appearances of the following symbol.";

Expr=V[a];
DisplayExpression[Expr,EqnLabel->"UnitTimelike"];

Comment@{"Now",Cref@"UnitTimelike"," is just a unit-timelike vector with Lorentz indices. Okay, let's find the (coordinate) derivative of the lapse function."};

Expr=Lapse[];
DisplayExpression@Expr;
Expr//=CD[-m];
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"DerLapse"];

Comment@"Now the (coordinate) derivative of the spatial measure.";

Expr=J[];
DisplayExpression@Expr;
Expr//=CD[-m];
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"DerJ"];

Comment@"Now the (coordinate) derivative of the (inverse) tetrad.";

Expr=H[-i,n];
DisplayExpression@Expr;
Expr//=CD[-m];
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"DerH"];

Comment@{"Very well. Now with",Cref@"DerLapse",Cref@"DerJ",Cref@"DerH"," are mostly obtained as a tangent to the computations."};

Comment@{"Now that the dependence of the contorsion correction to the second-order Lagrangian on the translational gauge field has been made clear in",Cref@"MatterLagrangianCorrection",", we can use the above derivative laws",Cref@"DerLapse",Cref@"DerJ",Cref@"DerH"," to reconstruct the variational derivative of the correction with respect to the translational gauge field. This in turn will tell us how the Ricci rotation coefficient part of the matter stress energy tensor is augmented by terms bilinear in the torsion and the spin tensor."};

Expr=(TorsionlessTau[m,-k]
	+VarD[B[k,-m],CD][MatterLagrangianCorrection]
	+VarD[Lapse[],CD][MatterLagrangianCorrection]Lapse[]H[-l,m]V[l]V[-k]
	+VarD[J[],CD][MatterLagrangianCorrection]J[](H[-k,m]-H[-l,m]V[l]V[-k])
	-VarD[H[-i,n],CD][MatterLagrangianCorrection]H[-i,m]H[-k,n]);

Expr//=ToNewCanonical;
Expr=Expr/.SigmaRomanToSigma;
Expr//=ToNewCanonical;
DisplayExpression@Expr;
Expr=Expr/.ContorsionToTorsion;
Expr//=ToNewCanonical;
SplitExpression=Expr;
DisplayExpression@Expr;

Comment@"We are now ready to write the formula which `splits' the usual HiGGS stress-energy tensor into torsion-free and torsionful parts.";

SplitStressEnergy=MakeRule[{Tau[m,-k],
	Evaluate@SplitExpression},
	MetricOn->All,ContractMetrics->True];

Expr=Tau[m,-k];
DisplayExpression@Expr;
Expr=Expr/.SplitStressEnergy;
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"SplitStressEnergy"];

Comment@"And we will also write a rule to invert this.";

CombineStressEnergy=MakeQuotientRule[{TorsionlessTau[m,-k],
	Tau[m,-k]-Evaluate@(Tau[m,-k]/.SplitStressEnergy)},
	MetricOn->All,ContractMetrics->True];

Expr=TorsionlessTau[m,-k];
DisplayExpression@Expr;
Expr=Expr/.CombineStressEnergy;
Expr//=ToNewCanonical;
DisplayExpression@Expr;
