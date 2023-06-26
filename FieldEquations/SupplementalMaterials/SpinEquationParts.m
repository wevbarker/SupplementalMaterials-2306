(*=====================*)
(*  SpinEquationParts  *)
(*=====================*)

Subsection@"Irreducible decomposition of spin connection equation";

Comment@{"Having obtained",Cref@"FinalSpinEquation",", we find it important to decompose it into the irreducible parts under the actions of the Lorentz group."};

Comment@"The largest and most cumbersome part of the spin connection equation, the tensor part with 16 degrees of freedom.";
SpinEquation1=PT1[r,-u,-w,-v,i,j]B[v,-n]SpinEquation/.PActivate//ToNewCanonical;
SpinEquation1//=ToNewCanonical;
DisplayEquation[SpinEquation1,EqnLabel->"SpinEquation1"];

Comment@"The simplest vector part of the spin equation, with four degrees of freedom.";
SpinEquation2=PT2[r,-u,-w,-v,i,j]B[v,-n]SpinEquation/.PActivate//ToNewCanonical;
SpinEquation2//=ToNewCanonical;
SpinEquation2=G[-r,u]SpinEquation2//ToNewCanonical;
DisplayEquation[SpinEquation2,EqnLabel->"SpinEquation2"];

Comment@"The other simplest axial vector part of the spin equation, also with four degrees of freedom.";
SpinEquation3=PT3[r,-u,-w,-v,i,j]B[v,-n]SpinEquation/.PActivate//ToNewCanonical;
SpinEquation3=SpinEquation3//ToNewCanonical;
SpinEquation3=epsilonG[-r,u,w,c]SpinEquation3//ToNewCanonical;
DisplayEquation[SpinEquation3,EqnLabel->"SpinEquation3"];
