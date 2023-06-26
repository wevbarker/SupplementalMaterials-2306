(*==============*)
(*  SpinTensor  *)
(*==============*)

Subsection@"The spin connection equations";

Comment@{"Having studied the general tetrad equation, we turn to the spin connection equation. The spin tensor,",Inline@Sigma[i,-j,-k],", is defined in Eq. (3.21) on p. 48 of Blagojević."};

Comment@"Once again, in terms of the generalised momenta and the gauge fields, the left hand side of the spin connection equation as expressed in the second line of Eq. (3.24b) on page 50 of Blagojević is as follows.";

SpinEquation=(
	-CD[-m][AGPi[-i,-j,x,y]H[-x,n]H[-y,m]]
	+A[l,-i,-m]AGPi[-l,-j,x,y]H[-x,n]H[-y,m]
	+A[l,-j,-m]AGPi[-i,-l,x,y]H[-x,n]H[-y,m]
	+BGPi[-i,-j,y]H[-y,n]-BGPi[-j,-i,y]H[-y,n]
);

SpinEquation//=ScreenDollarIndices;
DisplayExpression@SpinEquation;
Comment@{"We now expand the generalised momenta using",Cref@"BGPiDefinition",Cref@"AGPiDefinition",", impose the restriction on the coupling constants defined in",Cref@"ToTheory"," and expand out the quadratic invariant projection operators. We also subtract the right hand side of the second line of Eq. (3.24b) on page 50 of Blagojević, to give an actual equation."};

SpinEquation=SpinEquation/.ToTheory;
SpinEquation=SpinEquation/.GPiActivate;
SpinEquation//=ToNewCanonical;
SpinEquation=SpinEquation/.PActivate;
SpinEquation//=ToNewCanonical;
SpinEquation=SpinEquation/.ToStrengths;
SpinEquation//=ToNewCanonical;
SpinEquation//=xAct`HiGGS`Private`CDToGaugeCovD;
SpinEquation//=ToNewCanonical;

SigmaToGravity=MakeRule[{ Sigma[n,-i,-j],Evaluate[SpinEquation]},MetricOn->All,ContractMetrics->True];
SpinEquation=(Sigma[n,-i,-j]-SpinEquation)/(J[]Lapse[])//ToNewCanonical;

DisplayEquation[SpinEquation,EqnLabel->"FinalSpinEquation"];

Comment@{"So in",Cref@"FinalSpinEquation"," we have the final version of the spin connection equation in the first-order formulation."};

Manuscript@{"This in",Cref@"FinalSpinEquation"," is the spin connection equation for the most general set of Lagrangian parameters used in our manuscript."};
