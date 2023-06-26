(*======================*)
(*  StressEnergyTensor  *)
(*======================*)

Subsection@"The tetrad field equation";

Comment@"Now we define the tetrad equation. In terms of the generalised momenta, the Riemann-Cartan curvature, the torsion, and the gauge fields, and also in terms of the projection operators which are used to define the various quadratic invariants, the left hand side of the tetrad equation as expressed in the first line of Eq. (3.24b) on page 50 of Blagojević is as follows.";

StressEnergyEquation=(
	-CD[-m][BGPi[-i,x,y]H[-x,n]H[-y,m]]
	+A[l,-i,-m]BGPi[-l,x,y]H[-x,n]H[-y,m]
	+T[p,-k,-i]BGPi[-p,k,y]H[-y,n]
	+(1/2)R[p,q,-k,-i]AGPi[-p,-q,k,y]H[-y,n]
	+Lapse[]J[](
		T[q,-k,-l](
				( 
					Bet1 PT1[-x,y,z,-q,k,l]
					+Bet2 PT2[-x,y,z,-q,k,l]
					+Bet3 PT3[-x,y,z,-q,k,l]
				)T[x,-y,-z]
				+( 
					cBet1 PT1[-x,y,z,-q,k,l]
					+cBet2 PT2[-x,y,z,-q,k,l]
					+cBet3 PT3[-x,y,z,-q,k,l]
				)TLambda[x,-y,-z]
			)
			+R[q,j,-k,-l](
				( 
					Alp1 PR1[-x,-w,y,z,-q,-j,k,l]
					+ Alp2 PR2[-x,-w,y,z,-q,-j,k,l]
					+ Alp3 PR3[-x,-w,y,z,-q,-j,k,l]
					+ Alp4 PR4[-x,-w,y,z,-q,-j,k,l]
					+ Alp5 PR5[-x,-w,y,z,-q,-j,k,l]
					+ Alp6 PR6[-x,-w,y,z,-q,-j,k,l]
				)R[x,w,-y,-z]
				+( 
					cAlp1 PR1[-x,-w,y,z,-q,-j,k,l]
					+ cAlp2 PR2[-x,-w,y,z,-q,-j,k,l]
					+ cAlp3 PR3[-x,-w,y,z,-q,-j,k,l]
					+ cAlp4 PR4[-x,-w,y,z,-q,-j,k,l]
					+ cAlp5 PR5[-x,-w,y,z,-q,-j,k,l]
					+ cAlp6 PR6[-x,-w,y,z,-q,-j,k,l]
				)RLambda[x,w,-y,-z]
			)-(Alp0/2)R[q,j,k,l]G[-q,-k]G[-j,-l]
		)H[-i,n]
	);
StressEnergyEquation//=ScreenDollarIndices;
DisplayExpression[StressEnergyEquation,EqnLabel->"StressEnergyEquation"];

Comment@{"We next impose the restriction on the coupling constants from",Cref@"ToTheory"," in order to go over to the most general case studied in our manuscript, and then we expand the projection operators and the generalised momenta. We subtract the right hand side of the first line of Eq. (3.24b) on page 50 of Blagojević, i.e. the (asymmetric) matter stress-energy tensor",Inline@Tau[n,-i],", to form the tetrad field equation."};

StressEnergyEquation=StressEnergyEquation/.ToTheory;
StressEnergyEquation=StressEnergyEquation/.GPiActivate;
StressEnergyEquation//=ToNewCanonical;
StressEnergyEquation=StressEnergyEquation/.PActivate;
StressEnergyEquation//=ToNewCanonical;
StressEnergyEquation=StressEnergyEquation/.ToStrengths;
StressEnergyEquation//=ToNewCanonical;
StressEnergyEquation//=xAct`HiGGS`Private`CDToGaugeCovD;
StressEnergyEquation//=ToNewCanonical;

StressEnergyEquation=(Tau[n,-i]-StressEnergyEquation)/(J[]Lapse[])//ToNewCanonical;
DisplayEquation[StressEnergyEquation,EqnLabel->"FullStressEnergyEquation"];

Comment@{"The new kinds of derivative appearing here are Poincaré gauge covariant derivatives, whose connection acts only on Lorentz indices but whose own (derivative) index is actually coordinate (Greek), these derivatives are defined in Eq. (3.5) on page 44 of Blagojević (albeit with a nabla symbol, which is a slight difference with our notation). The equation",Cref@"FullStressEnergyEquation"," is nearly ready to use, but the (asymmetric) stress-energy tensor of matter first needs some attention. This is because it still depends on the contorsion, and later on in the analysis we will need to refer only to the metric-based part, from which the symmetric Einstein stress-energy tensor is eventually derived. Before moving on to the spin connection equations therefore, we will need to explore this matter."};

Subsection@"Splitting matter stress-energy";

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","Contorsion.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","SecondOrderSplitting.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","Variations.m"};

Comment@{"Now the second order formalism `splitting' of the stress-energy current is understood, we will implement the change in our previous version of the tetrad equation",Cref@"FullStressEnergyEquation","."};

StressEnergyEquation=StressEnergyEquation/.SplitStressEnergy;
StressEnergyEquation//=ToNewCanonical;
DisplayEquation[StressEnergyEquation,EqnLabel->"FinalStressEnergyEquation"];

Comment@{"Then we say that",Cref@"FinalStressEnergyEquation"," is the final version of the tetrad equation in the first-order formulation."};

Manuscript@{"This in",Cref@"FinalStressEnergyEquation"," is the (asymmetric) tetrad equation for the most general set of Lagrangian parameters used in our manuscript."};

TauToGravity=MakeQuotientRule[{TorsionlessTau[n,-i],Evaluate[StressEnergyEquation]},
	MetricOn->All,ContractMetrics->True,Method->"Coefficient"];
