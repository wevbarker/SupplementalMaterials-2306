(*======================*)
(*  GeneralisedMomenta  *)
(*======================*)

Subsection@"The generalised momenta";

Comment@"Having done this, we define the generalised momenta associated with this subset of multiplier-constrained Poincaré gauge theory. These quantities are defined on p. 50 of Blagojević.";

BGPiSymb="\!\(\*SubscriptBox[\(\[Pi]\), \(\[ScriptB]\)]\)";
DefTensor[BGPi[-i,k,l],M4,PrintAs->BGPiSymb];
AGPiSymb="\!\(\*SubscriptBox[\(\[Pi]\), \(\[ScriptCapitalA]\)]\)";
DefTensor[AGPi[-i,-j,k,l],M4,Antisymmetric[{-i,-j}],PrintAs->AGPiSymb];

Comment@{"The translational generalised momenta",Inline@BGPi[-i,k,l],"."};

DisplayExpression@BGPi[-i,k,l];

BGPiDefinition=
	-2Lapse[]J[](
			2( 
			Bet1 PT1[-x,y,z,-i,k,l]
			+Bet2 PT2[-x,y,z,-i,k,l]
			+Bet3 PT3[-x,y,z,-i,k,l])T[x,-y,-z]
			+( 
				cBet1 PT1[-x,y,z,-i,k,l]
				+cBet2 PT2[-x,y,z,-i,k,l]
				+cBet3 PT3[-x,y,z,-i,k,l]
			)TLambda[x,-y,-z]
		)/.ToTheory;

BGPiDefinition=BGPiDefinition/.PActivate;
BGPiDefinition//=ToNewCanonical;
BGPiDefinition=BGPiDefinition/.ToStrengths;
BGPiDefinition//=ToNewCanonical;
BGPiDefinition//=CollectTensors;

DisplayExpression[BGPiDefinition,EqnLabel->"BGPiDefinition"];

Comment@{"The rotational generalised momenta",Inline@AGPi[-i,-j,k,l],"."};

DisplayExpression@AGPi[-i,-j,k,l];

AGPiDefinition=
	-4Lapse[]J[](
			2( 
			Alp1 PR1[-x,-w,y,z,-i,-j,k,l]
			+ Alp2 PR2[-x,-w,y,z,-i,-j,k,l]
			+ Alp3 PR3[-x,-w,y,z,-i,-j,k,l]
			+ Alp4 PR4[-x,-w,y,z,-i,-j,k,l]
			+ Alp5 PR5[-x,-w,y,z,-i,-j,k,l]
			+ Alp6 PR6[-x,-w,y,z,-i,-j,k,l])R[x,w,-y,-z]
			+( 
				cAlp1 PR1[-x,-w,y,z,-i,-j,k,l]
				+ cAlp2 PR2[-x,-w,y,z,-i,-j,k,l]
				+ cAlp3 PR3[-x,-w,y,z,-i,-j,k,l]
				+ cAlp4 PR4[-x,-w,y,z,-i,-j,k,l]
				+ cAlp5 PR5[-x,-w,y,z,-i,-j,k,l]
				+ cAlp6 PR6[-x,-w,y,z,-i,-j,k,l]
			)RLambda[x,w,-y,-z]
		)+2Lapse[]J[]Alp0 Antisymmetrize[Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}],{k,l}]/.ToTheory;

AGPiDefinition=AGPiDefinition/.PActivate;
AGPiDefinition//=ToNewCanonical;
AGPiDefinition=AGPiDefinition/.ToStrengths;
AGPiDefinition//=ToNewCanonical;
AGPiDefinition//=CollectTensors;

DisplayExpression[AGPiDefinition,EqnLabel->"AGPiDefinition"];

BGPiActivate=MakeRule[{BGPi[-i,k,l],Evaluate@BGPiDefinition},MetricOn->All,ContractMetrics->True];
AGPiActivate=MakeRule[{AGPi[-i,-j,k,l],Evaluate@AGPiDefinition},MetricOn->All,ContractMetrics->True];
GPiActivate=Join[BGPiActivate,AGPiActivate];

Comment@{"At this point we clear up some confusion by defining the lapse function",Inline@Lapse[],", the induced measure on the spatial foliation",Inline@J[],". Frequently in the expressions below you will see the following cumbersome factor."};
DisplayExpression[J[]Lapse[],EqnLabel->"Measure"];
Comment@{"Remember that all",Cref@"Measure"," means is `the measure in four spacetime dimensions'. The reason it is defined this way is because HiGGS is supposed to be doing Hamiltonian, not Lagrangian, analysis."};

Comment@{"Now in the case above, these generalised momenta are obtained from the Lagrangian represented in Eq. (4) of arXiv:2205.13534, with most of the coupling constants set to zero as per the above restrictions. Note that this Lagrangian differs from the most general Lagrangian represented in Blagojević by the use of so-called geometric multiplier fields",Inline@RLambda[x,w,-y,-z]," and",Inline@TLambda[x,-y,-z],". These are multipliers which can disable all of the Riemann-Cartan",Inline@R[x,w,-y,-z]," or torsion",Inline@T[x,-y,-z]," tensors, but which may typically only be used piecemeal to disable select portions of said tensors. It is this latter use-case which we realise in our manuscript."};
