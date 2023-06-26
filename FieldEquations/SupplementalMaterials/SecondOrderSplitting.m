(*========================*)
(*  SecondOrderSplitting  *)
(*========================*)

Comment@"Now in HiGGS we are used to using the following matter stress-energy tensor.";

Expr=Tau[m,-k];
DisplayExpression@Expr;

Comment@"But the point raised above was that this tensor, the (negative) variational derivative of the matter Lagrangian (density) as defined in Eq. (3.21) on p. 48 of Blagojević, still depends on the rotational gauge field. In the second order formalism, this means that it will depend both on the Ricci rotation coefficients and on the contorsion.";

Comment@"We now define the part which depends only on the Ricci rotation coefficients.";

TorsionlessTauSymb="\[Tau](\[CapitalDelta])";
DefTensor[TorsionlessTau[-i,-j],M4,
	PrintAs->xAct`HiGGS`Private`SymbolBuild[TorsionlessTauSymb]];

Expr=TorsionlessTau[-i,-j];
DisplayExpression@Expr;

Comment@"To understand how the contorsion dependency enters in, we look at Eq.  (3.75b) on p. 66 of Blagojević. This separated Lagrangian is varied with respect to the tetrad, in such a way that the Ricci rotation coefficients and contorsion are held constant (they must have two Roman and one Greek index, so that they algebraically inherit the role of the rotational gauge field). The variation of the first term will give us the above quantity, which can then be expressed in terms of the Einstein tensor using the methods of p. 67 (we do this later in the script).";

Comment@"The variation of the second term rests entirely on the variation of the spin tensor. This is rather suspicious, since it means that the details of the spin tensor of matter have a say in whether we can recover the second order formalism at all. However to proceed, we look to the Dirac matter spin tensor in Example 2 at the end of p. 49 of Blagojević. We define a (Lorentz) quantity which is truly independent of the gravitational variables, being composed of Grassmann numbers and (indexed) generators of the Clifford algebra.";

SigmaRomanSymb="\[ScriptCapitalX]";
DefTensor[SigmaRoman[i,-j,-k],M4,Antisymmetric[{-j,-k}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild[SigmaRomanSymb]];

Expr=SigmaRoman[i,-j,-k];
DisplayExpression[Expr,EqnLabel->"SigmaRoman"];

Comment@{"Understand that",Cref@"SigmaRoman"," will only have anholonomic Lorentz indices, and is formed from the fermion current."};

Comment@{"Now we focus on the spin tensor density",Inline@Sigma[i,-j,-k],", which is related to the spin tensor in our manuscript (defined later on in this script) by a factor of the measure in accordance with the paragraph following Eq. (3.58) on p. 67 in Blagojević. It has an initial coordinate index, and then two Lorentz indices. It must also be a density."};

SigmaToSigmaRoman=MakeRule[{Sigma[i,-j,-k],
	Lapse[]J[]H[-s,i]SigmaRoman[s,-j,-k]},
	MetricOn->All,ContractMetrics->True];
SigmaRomanToSigma=MakeRule[{SigmaRoman[i,-j,-k],
	B[i,-s]Sigma[s,-j,-k]/(Lapse[]J[])},
	MetricOn->All,ContractMetrics->True];

Expr=Sigma[i,-j,-k];
DisplayExpression@Expr;
Expr=Expr/.SigmaToSigmaRoman;
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"SpinTensorForm"];

Comment@{"These requirements are met by",Cref@"SpinTensorForm"," w.l.o.g."};

Comment@{"Bringing together the contorsion in",Cref@"Contorsion"," and the (Dirac) spin tensor in",Cref@"SpinTensorForm"," the whole of the correction to the second order matter Lagrangian density now takes the following form."};

Expr=(1/2)Contorsion[i,j,-m]Sigma[m,-i,-j];
DisplayExpression@Expr;
Expr=Expr/.SigmaToSigmaRoman;
Expr//=ToNewCanonical;
MatterLagrangianCorrection=Expr;
DisplayExpression[MatterLagrangianCorrection,EqnLabel->"MatterLagrangianCorrection"];
