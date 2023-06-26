(*==============*)
(*  Contorsion  *)
(*==============*)

Comment@"First we define the contorsion tensor to have strictly two anholonomic indices and a holonomic index, in line with its interpretation as a part of the connection. This is recovered through Eq. (3.32b) on p. 57 of Blagojević, with comparisons with Eq (3.46) on p. 61, and checks against the methods used on p. 67. Great care must be taken when attempting to achieve this index configuration using contractions of the HiGGS anholonomic torsion tensor with the translational gauge field and inverse:";

ContorsionSymb="\[ScriptCapitalK]";
DefTensor[Contorsion[i,j,-m],M4,Antisymmetric[{i,j}],
	PrintAs->xAct`HiGGS`Private`SymbolBuild@ContorsionSymb];

ContorsionToTorsion=MakeRule[{Contorsion[i,j,-m],
	-(1/2)(
		T[i,j,-l]B[l,-m]
		-T[l,i,j]B[-l,-m]
		+T[j,-l,i]B[l,-m])},
	MetricOn->All,ContractMetrics->True];

Expr=Contorsion[i,j,-m];
DisplayExpression[Expr,EqnLabel->"Contorsion"];
Expr=Expr/.ContorsionToTorsion;
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"ExpandedContorsion"];

Comment@{"Note that in",Cref@"Contorsion"," and",Cref@"ExpandedContorsion"," you don't actually see the holonomic and anholonomic indices with different labels (e.g. Greek and Roman). This is because in HiGGS the tangent space of the index is assumed to be determined by the name of the tensor. Thus all instances of the translational gauge field are Roman in their first index and Greek (coordinate) in their second index."};
