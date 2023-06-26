(*============================*)
(*  LagrangianReconstruction  *)
(*============================*)

Comment@"Now finally we can compare the field equations with those obtained from
our ansatz above.";

Comment@"Remove the matter stress-energy tensor...";
EinsteinEquation=EinsteinEquation/.{ThetaTensor->Zero}//ToGeoCanonical;

Comment@"Compose a big system of equations...";
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

Comment@"Here are the solutions:";
DisplayEquation@Solutions;
