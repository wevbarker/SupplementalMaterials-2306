(*================*)
(*  ToShellRules  *)
(*================*)

(*Section@"The multiplier shell";*)

(*Comment@"Recall that there is space in our set of Poincaré gauge theories to impose a Lagrange multiplier. It is useful at this time to set up rules to impose the multiplier equation, restricting the torsion multiplier to its tensor part (i.e. from 24 to 16 degrees of freedom) and suppressing only that part of the torsion itself.";*)

SuppressTensorTorsion=Join[
	MakeRule[{TLambda[-a,-b,-c],
		Evaluate[(
			PT1[-a,-b,-c,i,j,k])TLambda[-i,-j,-k]/.PActivate//ToNewCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{TLambda2[-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{TLambda3[-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{T[-a,-b,-c],
		Evaluate[(
			PT2[-a,-b,-c,i,j,k]
			+PT3[-a,-b,-c,i,j,k])T[-i,-j,-k]/.PActivate//ToNewCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{T1[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]
];
(*DisplayEquation@SuppressTensorTorsion;*)

(*Comment@"Analogous rules can be generated to impose the multiplier equation for the case where the vector torsion mode is also suppressed.";*)

SuppressTensorAndVectorTorsion=Join[
	MakeRule[{TLambda[-a,-b,-c],
		Evaluate[(
			PT1[-a,-b,-c,i,j,k]
			+PT2[-a,-b,-c,i,j,k])TLambda[-i,-j,-k]/.PActivate//ToNewCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{TLambda3[-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{T[-a,-b,-c],
		Evaluate[(PT3[-a,-b,-c,i,j,k])T[-i,-j,-k]/.PActivate//ToNewCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{T1[-a,-b,-c],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{T2[-a],0},MetricOn->All,ContractMetrics->True]
];
(*DisplayEquation@SuppressTensorAndVectorTorsion;*)

(*Comment@"Analogous rules can be generated to impose the full multiplier equation, in which all parts of the torsion multiplier are present in the system and all of the torsion is suppressed. This effectively takes us over into Riemann spacetime.";*)

SuppressTensorAndVectorAndAxialVectorTorsion=Join[
	MakeRule[{T[-a,-b,-c],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{T1[-a,-b,-c],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{T2[-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{T3[-a],0},MetricOn->All,ContractMetrics->True]
];
(*DisplayEquation@SuppressTensorAndVectorAndAxialVectorTorsion;*)
