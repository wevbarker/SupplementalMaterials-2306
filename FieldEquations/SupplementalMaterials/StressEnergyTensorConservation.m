(*==================================*)
(*  StressEnergyTensorConservation  *)
(*==================================*)

Subsection@"Stress-energy conservation";

Comment@"We now have both sets of field equations at our disposal, with reference to their respective source currents. It would be helpful at this stage to verify the second conservation law from Eq. (3.23) p. 49 in Blagojević.";

TotalExpr = B[k,-m]CD[-n][Tau[n,-k]]-B[k,-m]A[l,-k,-n]Tau[n,-l]-(Tau[n,-k]T[k,-l,-q]B[l,-m]B[q,-n]+(1/2)Sigma[n,-i,-j]R[i,j,-l,-q]B[l,-m]B[q,-n]);
DisplayEquation@TotalExpr;

Comment@"We have confirmed that substitution of the field equations into this expression, which refers to the sources only, causes it to vanish. The calculation is computationally quite expensive, so we will omit it here.";
