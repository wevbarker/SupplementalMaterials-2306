(*==============*)
(*  ScalarPart  *)
(*==============*)
(*
Subsection@"The Riemann-Cartan Ricci scalar";

Comment@"Finally the scalar part, this is naturally quite straightforward.";
*)
Expr=R6[];
(*DisplayExpression@Expr;*)
Expr=Expr/.RActivate;
Expr//=ToGeometric;
Expr=Expr/.TSO13Activate;
Extr=Expr/.SuppressTensorTorsion;
Expr//=ToGeoCanonical;
(*
Comment@"Once again, we can construct a rule to convert from the divergence of one of the torsion vectors to the scalar mode.";
*)
R6Eqn=R6[]-Expr;
(*DisplayEquation@R6Eqn;*)
DivT2ToR6=MakeQuotientRule[{CD[-a][T2[a]],R6Eqn}];
