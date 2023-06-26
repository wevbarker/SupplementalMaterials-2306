(*===============*)
(*  MaxwellPart  *)
(*===============*)

Subsection@"The Maxwell Riemann-Cartan Ricci tensor";

Comment@"Now we move on to translate the irreducible parts of the Riemann-Cartan tensor into kinetic terms for the torsion.";

Comment@"First we expand the Maxwell part of the Riemann-Cartan tensor, whilst suppressing the tensor part of the torsion.";

Expr=R5[-a,-b];
DisplayExpression@Expr;
Expr=Expr/.RActivate;
Expr//=ToGeometric;
Expr=Expr/.TSO13Activate;
Expr=Expr/.SuppressTensorTorsion;
Expr//=ToGeoCanonical
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
DisplayExpression@Expr;

Comment@"Now we can make some rules to convert between the torsion Maxwell tensors and the Riemann-Cartan Maxwell tensor.";

R5Eqn=R5[-a,-b]-Expr;
DisplayEquation@R5Eqn;
Maxwell2ToR5=MakeQuotientRule[{Maxwell2[-a,-b],R5Eqn}];

R5Eqn=R5Eqn epsilonGeoG[-i,-j,a,b]//ToGeoCanonical;
DisplayEquation@R5Eqn;
Maxwell3ToR5=MakeQuotientRule[{Maxwell3[-i,-j],R5Eqn},Method->"Coefficient"];

Manuscript@"We begin to see here why the dynamics of our new theory are viable. With the tensor torsion suppressed, it is straightforward to obtain the kinetic structure of our effective model from the Riemann-Cartan invariant in our fundamental model. There will be a cross-term, but this is a total divergence.";
