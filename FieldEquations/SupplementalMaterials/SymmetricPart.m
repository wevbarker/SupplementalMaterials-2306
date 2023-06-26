(*=================*)
(*  SymmetricPart  *)
(*=================*)
(*
Subsection@"The symmetric-traceless Riemann-Cartan Ricci tensor";

Comment@"Next for the symmetric, traceless part. It is somewhat cumbersome, but potentially quite interesting down the line, and we imagine in particular some further work in which the activation of the scalar mode in traditional higher-derivative extensions to metrical gravity is examined through the non-Riemannian perspective with the aid of multipliers to remove strongly-coupled fields.";

Expr=R4[-a,-b];
DisplayExpression@Expr;
Expr=Expr/.RActivate;
Expr//=ToGeometric;
Expr=Expr/.TSO13Activate;
Expr=Expr/.SuppressTensorTorsion;
Expr//=ToGeoCanonical;
DisplayExpression@Expr;
*)
