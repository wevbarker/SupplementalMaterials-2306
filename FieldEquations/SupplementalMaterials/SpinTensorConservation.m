(*==========================*)
(*  SpinTensorConservation  *)
(*==========================*)

Subsection@"Spin conservation";

Comment@"Equally, it is important to verify the second conservation law from Eq. (3.23) page 49 in Blagojević.";

Comment@"First term in the putatively vanishing expression.";
FirstTerm = 2 Antisymmetrize[TorsionlessTau[n,-j]B[-i,-n], {-i, -j}];
DisplayExpression@FirstTerm;
(*
FirstTerm//=ToNewCanonical;
FirstTerm = FirstTerm/.TauToGravity;
FirstTerm//=ToNewCanonical;
(*FirstTerm = FirstTerm/.TShellActivate;*)
(*FirstTerm//=ToNewCanonical;*)
DisplayEquation@FirstTerm;
*)

Comment@"Second term in the putatively vanishing expression.";
SecondTerm = CD[-n][Sigma[n,-i,-j]]-A[l,-i,-n]Sigma[n,-l,-j]-A[l,-j,-n]Sigma[n,-i,-l];
DisplayExpression@SecondTerm;
(*
SecondTerm//=ToNewCanonical;
SecondTerm = SecondTerm/.SigmaToGravity;
SecondTerm//=ToNewCanonical;
SecondTerm = SecondTerm/.ToStrengths;
SecondTerm//=ToNewCanonical;
SecondTerm//=xAct`HiGGS`Private`GaugeCovDToCD;
SecondTerm//=ToNewCanonical;
SecondTerm//=ToBasicForm;
SecondTerm//=ToNewCanonical;
SecondTerm = SecondTerm/.ToStrengths;
SecondTerm//=ToNewCanonical;
SecondTerm//=xAct`HiGGS`Private`CDToGaugeCovD;
SecondTerm//=ToNewCanonical;
(*SecondTerm = SecondTerm/.TShellActivate;
SecondTerm//ToNewCanonical;
SecondTerm//ToCanonical;*)
DisplayEquation@SecondTerm;

Comment@"Difference between these terms:";
Expr=FirstTerm-SecondTerm//ToNewCanonical;
DisplayEquation@Expr;

Comment@"The satisfaction of the conservation law therefore rests on the
multiplier terms. Not immediately clear to me why this is true, but according
to the old code here I was satisfied at one point that these expressions vanish
on the shell imposed by the multipliers. It would be worth returning to this to
verify.";
*)

Comment@"Once again, by substituting for the source currents on the field equation shell, we have shown these terms to cancel, but the calculation itself is omitted for brevity.";
