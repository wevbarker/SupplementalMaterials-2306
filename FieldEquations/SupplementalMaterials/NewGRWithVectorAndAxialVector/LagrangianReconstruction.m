(*============================*)
(*  LagrangianReconstruction  *)
(*============================*)

Subsection@"Reconstruction of the effective action";

Comment@{"Now finally we can compare the field equations",Cref@"FinEinsteinEquation",", ",Cref@"ImprovedSpinEquation2"," and ",Cref@"ImprovedSpinEquation3"," with those obtained from our ansatz above in",Cref@"AnsatzEinsteinEquation",", ",Cref@"AnsatzSpinEquation2"," and ",Cref@"AnsatzSpinEquation3",". Note that for the Einstein equations, we must remove the stress-energy tensor of matter to make the comparison. The solutions for the ansatz parameters are as follows."};

EinsteinEquation=EinsteinEquation/.{ThetaTensor->Zero}//ToGeoCanonical;

MakeDifferenceEquation[Eqn_,Ansatz_,MyTerm_]:=Module[{DifferenceEquation},
	DifferenceEquation=Eqn/Coefficient[Eqn,MyTerm]-Ansatz/Coefficient[Ansatz,MyTerm];
	DifferenceEquation//=ToGeoCanonical;
	DifferenceEquation//=CollectTensors;
	DifferenceEquation=DifferenceEquation==0;
DifferenceEquation];

EquationSystem={
	MakeDifferenceEquation[EinsteinEquation,AnsatzEinsteinEquation,RicciGeoCovD[-i,-j]],
	MakeDifferenceEquation[SpinEquation2,AnsatzSpinEquation2,T2[-w]],
	MakeDifferenceEquation[SpinEquation3,AnsatzSpinEquation3,T3[c]]
};

Solutions=SolveConstants[EquationSystem,AnsatzConstants];

DisplayExpression[Solutions,EqnLabel->"Solutions"];

Comment@{"Substituting",Cref@"Solutions"," into our ansatz in",Cref@"LagrangianDensity"," we obtain the reconstructed Lagrangian density."};

Expr=LagrangianDensity/.(First@Solutions);
Expr//=ToNewCanonical;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=CollectTensors;
DisplayExpression[Expr,EqnLabel->"ReconstructedLagrangian"];

Manuscript@{"We obtain our effective Lagrangian: compare",Cref@"ReconstructedLagrangian"," with",Mref@"ReconstructedLagrangian"," in the manuscript."};
