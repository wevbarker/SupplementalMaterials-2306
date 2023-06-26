(*========================*)
(*  AlgebraicElimination  *)
(*========================*)

Section@"Algebraic elimination";


Comment@"Reload the linearising function.";

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","StronglyCoupledCase/Linearise.m"};

Comment@"First a rule which removes the divergence of the new Maxwell tensor.";

Expr=ReducedLinearSpinEquation2;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
DisplayEquation@Expr;
DivMaxwell1ToVectors=MakeQuotientRule[{GeoCovD[-a]@Maxwell1[-w,a],Expr},Method->"Coefficient"];

Comment@"(nonlinear case of above)";

Expr=ReducedNonlinearSpinEquation2;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
DivGeneralMaxwell1ToVectors=MakeQuotientRule[{GeoCovD[-a]@GeneralMaxwell1[-w,a],Expr},Method->"Coefficient"];

Expr=ReducedNonlinearSpinEquation2;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
T2ToF1T1=MakeQuotientRule[{T2[-w],Expr},Method->"Coefficient"];

Comment@"Convert the pseudovector equation to Bianchi form.";

Expr=epsilonGeoG[-i,-j,-k,-c]ReducedLinearSpinEquation3;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
BianchiLinearSpinEquation3=Expr;

Comment@"(nonlinear case of above)";

Expr=epsilonGeoG[-i,-j,-k,-c]ReducedNonlinearSpinEquation3;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
BianchiNonlinearSpinEquation3=Expr;

Expr=ReducedNonlinearSpinEquation3;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
T3ToF1T1=MakeQuotientRule[{T3[c],Expr},Method->"Coefficient"];

Comment@"Now we would like to construct a rule which replaces the d'Alembertian of the new Maxwell tensor.";

Expr=BianchiLinearSpinEquation3;
Expr//=GeoCovD[k]
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DivMaxwell1ToVectors;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
DisplayEquation@Expr;
LapMaxwell1ToVectors=MakeQuotientRule[{GeoCovD[-a]@GeoCovD[a]@Maxwell1[-i,-j],Expr},Method->"Coefficient"];

Comment@"(nonlinear case of above)";
(**)
Expr=BianchiNonlinearSpinEquation3;
Expr//=GeoCovD[k];
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DivMaxwell1ToVectors;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
(*Expr//=ToGeneralCovD;*)
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.DivMaxwell1ToVectors;
Expr//=ToNewCanonical;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
LapGeneralMaxwell1ToVectors=MakeQuotientRule[{GeoCovD[-a]@GeoCovD[a]@GeneralMaxwell1[-i,-j],Expr},Method->"Coefficient"];
(**)

Comment@"Now a recap of the tensor equation.";
Expr=ReducedLinearSpinEquation1;
Expr//=LineariseQuantity;
DisplayEquation@Expr;
NewReducedLinearSpinEquation1=Expr;

Comment@"We'd like to take the divergence of this";

Expr=NewReducedLinearSpinEquation1;
Expr//=GeoCovD[-r];
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
Expr=Expr/.LapMaxwell1ToVectors;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
DisplayEquation@Expr;

Comment@"(nonlinear case of above)";
(*
Expr=ReducedNonlinearSpinEquation1;
DisplayEquation@Expr;
Expr=Expr/.T2ToF1T1;
Expr=Expr/.T3ToF1T1;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;

Expr//=ToGeneralCovD;
Expr//=ToNewCanonical;
DisplayEquation@Expr;
*)
(**)
Expr=ReducedNonlinearSpinEquation1;
Expr//=GeoCovD[-r];
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
(*Expr=Expr/.LapGeneralMaxwell1ToVectors;*)
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
(*Expr=Expr/.DivGeneralMaxwell1ToVectors;*)
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;
(**)
Comment@"now substitute algebraically determined vectors";

Get@(FileNameJoin@{NotebookDirectory[],"StronglyCoupledCase/Linearise.m"});

Expr=Expr/.FromMaxwell;
Expr=Expr/.T2ToF1T1;
Expr=Expr/.T3ToF1T1;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;

Expr=LineariseQuantity[Expr,2];
Expr=Expr/.ToNonlinearMaxwell;
Expr=Expr/.FromMaxwell;
Expr=Expr/.T2ToF1T1;
Expr=Expr/.T3ToF1T1;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation@Expr;

Comment@"Try new derivatives";

(*Expr//=ToGeneralCovD;*)
Expr//=ToNewCanonical;
Expr=LineariseQuantity[Expr,2];
DisplayEquation@Expr;


Throw@"stop here";

Comment@"From here we can solve directly for the new Maxwell tensor.";

Maxwell1ToVectors=MakeQuotientRule[{Maxwell1[-u,-w],Expr},Method->"Coefficient"];

Comment@"Now return this into the vector spin equation.";

Expr=ReducedLinearSpinEquation2;
DisplayEquation@Expr;
Expr=Expr/.Maxwell1ToVectors;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=LineariseQuantity;
Expr=Expr/.FromMaxwell;
Expr//=ToGeoCanonical;
Expr//=LineariseQuantity;
DisplayEquation@Expr;

Comment@"We can make a replacement rule.";
T2ToSpin=MakeQuotientRule[{T2[-w],Expr},Method->"Coefficient"];

Comment@"At lowest perturbative order, here is the algebraic solution for the vector torsion.";

Expr=T2[-m];
Expr=Expr/.T2ToSpin//ToNewCanonical;
DisplayEquation@Expr;

Comment@"And now we'd like to do the same with the pseudovector equation.";

Expr=ReducedLinearSpinEquation3;
DisplayEquation@Expr;
Expr=Expr/.Maxwell1ToVectors;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=LineariseQuantity;
Expr=Expr/.FromMaxwell;
Expr//=ToGeoCanonical;
Expr//=LineariseQuantity;
DisplayEquation@Expr;

Comment@"We can make a replacement rule.";
T3ToSpin=MakeQuotientRule[{T3[c],Expr},Method->"Coefficient"];

Comment@"At lowest perturbative order, here is the algebraic solution for the pseudovector torsion.";

Expr=T3[-m];
Expr=Expr/.T3ToSpin//ToNewCanonical;
DisplayEquation@Expr;

Comment@"And finally an analytic result for the tensor part.";

Expr=ReducedLinearSpinEquation1;
DisplayEquation@Expr;
Expr=Expr/.Maxwell1ToVectors;
Expr=Expr/.ToMaxwell;
Expr//=ToNewCanonical;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
Expr//=ToNewCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=LineariseQuantity;
Expr=Expr/.FromMaxwell;
Expr//=ToNewCanonical;
Expr//=LineariseQuantity;
DisplayEquation@Expr;

Comment@"Now with the vectors eliminated.";
(*
Expr=Expr/.T3ToSpin;
Expr//=LineariseQuantity;
Expr=Expr/.T2ToSpin;
Expr//=LineariseQuantity;
Expr=Expr/.ToMaxwell;
Expr//=LineariseQuantity;
Expr//=ToNewCanonical;
Expr//=LineariseQuantity;
Expr//=ApplyBianchi;
Expr//=LineariseQuantity;
Expr//=ToNewCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=LineariseQuantity;
Expr=Expr/.FromMaxwell;
Expr//=ToNewCanonical;
Expr//=LineariseQuantity;
DisplayEquation@Expr;
*)
