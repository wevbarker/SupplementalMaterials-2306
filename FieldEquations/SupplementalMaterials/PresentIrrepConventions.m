(*===========================*)
(*  PresentIrrepConventions  *)
(*===========================*)

Subsection@"Irrep conventions for spin and torsion";

Comment@{"Here are the conventions used for the irreps of the torsion tensor. Note that the totally antisymmetric tensor will be formatted as",Inline@epsilonG[m,-n,-s,-a],"."};

Expr=T[m,-n,-s];
DisplayExpression@Expr;
Expr=Expr/.TSO13Activate//ToNewCanonical;
DisplayExpression@Expr;

Comment@"And we also want to see what the teleparallel Lagrangian looks like, this is the double-bar T symbol which must be multiplied by the measure and half the Planck mass, with a positive sign (see Eq. (15) in arXiv:2006.03581).";
Expr=(1/4)T[-i,-j,-k]T[i,j,k]+(1/2)T[-j,-i,-k]T[i,j,k]-T[k,-j,-k]T[i,j,-i]/.TSO13Activate//ToNewCanonical;
DisplayExpression@Expr;

Comment@"Now we also want to expand these irreps back in terms of the original tensor. First the tensor part.";

Expr=(1/2)*(T[a,-b,-c]+T[-b,a,-c]);
(*Expr=PT1[a,-b,-c,-d,e,f]*T[d,-e,-f];*)
(*Expr=(PT1[-a,-b,-c,-d,e,f]+PT1[-b,-c,-a,-d,e,f]+PT1[-c,-a,-b,-d,e,f])*T[d,-e,-f];*)
Expr=Expr/.PActivate;
Expr//=ToNewCanonical;
DisplayExpression@Expr;
Expr=Expr/.TSO13Activate//ToNewCanonical;
Expr//=CollectTensors;
DisplayExpression@Expr;

Comment@"Now the vector part.";

Expr=-PT2[a,-b,-a,-d,e,f]*T[d,-e,-f];
Expr=Expr/.PActivate;
Expr//=ToNewCanonical;
DisplayExpression@Expr;
Expr=Expr/.TSO13Activate//ToNewCanonical;
DisplayExpression@Expr;

Comment@"Now the pseudovector part.";

Expr=(1/6)*epsilonG[-z,-a,b,c]*PT3[a,-b,-c,-d,e,f]*T[d,-e,-f];
Expr=Expr/.PActivate;
Expr//=ToNewCanonical;
DisplayExpression@Expr;
Expr=Expr/.TSO13Activate//ToNewCanonical;
DisplayExpression@Expr;

Comment@{"We will also take a look at our irrep conventions for the spin tensor. Remembering the form we arrived at in",Cref@"SpinTensorForm",", we see that the following combination must have all Roman (Lorentz) indices, and we will understand that it is the version with all Roman indices which is decomposed."};

Expr=H[k,-m]Sigma[m,-i,-j];
DisplayExpression[Expr,EqnLabel->"RomanSpin"];
Expr=Expr/.SigmaSO13Activate//ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"ExpandedRomanSpin"];

Comment@{"So to make double sure, note that in",Cref@"RomanSpin"," and",Cref@"ExpandedRomanSpin"," the decomposed parts are defined only for the version of the spin tensor which has all Lorentz indices, so the version of the tensor we decompose has to have an extra factor of the (inverse) tetrad (and an implicit curved-space metric to lower the Greek index on that field) so as to get rid of the natural coordinate index in our definition of the undecomposed spin tensor."};

Comment@"Some care has to be taken when understanding how the vector and axial vector parts of the torsion couple to the respective parts of the spin tensor. The reason for this is that the spin tensor is constructed, as per the discussion above, with two Lorentz indices, and so in the stress-energy field equation there is a possible factor of two that can go missing unless the indices are kept carefully tracked (think about what it means to take variations with respect to the tetrad vs with respect to the metric tensor). When we go over to the GeoHiGGS second-order formulation in the next part of the script, all appearances of the tetrad and its inverse are simply replaced by the Kronecker symbol. This is safe in the gravity sector of the theory, but not in the matter coupling.";

(*Comment@"Now we assume that every instance of an epsilon tensor appears with lowered Greek indices in the second-order formalism, so that it is safe to consider this equal to the original epsilon (with Roman indices assumed) with all indices contracted with translational (not inverse) gauge fields.";*)
EpsilonTangentSpaceConvert=MakeRule[{epsilonG[-a,-b,-c,-d],
		B[i,-a]B[j,-b]B[k,-c]B[l,-d]epsilonG[-i,-j,-k,-l]},
		MetricOn->All,ContractMetrics->True];
EpsilonTangentSpaceConvert=MakeRule[{epsilonG[-a,-b,-c,-d],
		H[i,-a]H[j,-b]H[k,-c]H[l,-d]epsilonG[-i,-j,-k,-l]},
		MetricOn->All,ContractMetrics->True];
(*
Expr=epsilonG[-a,-b,-c,-d];
DisplayExpression@Expr;
Expr=Expr/.EpsilonTangentSpaceConvert//ToNewCanonical;
DisplayExpression@Expr;
*)
(*Comment@"Moreover, Greek-index curved-metric tensors will always appear so as to satisfy the following rules, where we use the flat-space metric of HiGGS as a temporary abuse of notation.";*)
BTangentSpaceConvert=MakeRule[{B[i,m]B[j,-m],
		G[i,j]},
		MetricOn->All,ContractMetrics->True];
(*
Expr=B[i,m]B[j,-m];
DisplayExpression@Expr;
Expr=Expr/.BTangentSpaceConvert;
DisplayExpression@Expr;
*)
HTangentSpaceConvert=MakeRule[{H[-i,m]H[-j,-m],
		G[-i,-j]},
		MetricOn->All,ContractMetrics->True];
(*
Expr=H[-i,m]H[-j,-m];
DisplayExpression@Expr;
Expr=Expr/.HTangentSpaceConvert;
DisplayExpression@Expr;
*)
(*Comment@"Here is the part of the Lagrangian in which the torsion is coupled to spin.";*)
Expr=(1/4)*H[m,-z]Sigma[z,-i,-j]*(
	T[s,-e,-m1]B[i,-s]H[j,e]H[-m,m1]
	-T[s,-r,-p]B[-m,-s]H[i,r]H[j,p]
	+T[s,-m1,-e]B[j,-s]H[-m,m1]H[i,e]
);
(*DisplayExpression@Expr;*)

Comment@{"To get a good understanding of how factors of the tetrad enter in, we decompose both factors in",Cref@"MatterLagrangianCorrection"," but pretend that the torsion carries only Greek (coordinate) indices. This is an abuse of notation for the HiGGS variables, but we only do it at this one step so as to make sure that the matter coupling is correct."};
Expr=Expr/.TSO13Activate//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.EpsilonTangentSpaceConvert//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.SigmaSO13Activate//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.BTangentSpaceConvert//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.HTangentSpaceConvert//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.BTangentSpaceConvert//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.HTangentSpaceConvert//ToNewCanonical;
Expr//=ToNewCanonical;
Expr=Expr/.{T1->Zero}//ToNewCanonical;
Expr//=ToNewCanonical;
DisplayExpression[Expr,EqnLabel->"SpinCoupling"];

Comment@{"The form in",Cref@"SpinCoupling"," has the tensor parts of both fields neglected. We'll use it later on in our script."};
