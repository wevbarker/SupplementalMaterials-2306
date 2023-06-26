(*=========================*)
(*  SupplementalMaterials  *)
(*=========================*)

<<xAct`xPlain`;

(*
(*the bad case*)

StudyTheory[{{"ConstraintAlgebraAlp0Alp5Bet3",{Alp1==0,Alp2==0,Alp3==0,Alp4==0,Alp6==0,Bet1==0,Bet2==0,cBet1==0,cBet2==0,cBet3==0,cAlp1==0,cAlp2==0,cAlp3==0,cAlp4==0,cAlp5==0,cAlp6==0}}},Brackets->True,Velocities->True];

(*the good case*)

StudyTheory[{{"ConstraintAlgebraAlp0Alp5Bet3cBet1cBet2",{Alp1==0,Alp2==0,Alp3==0,Alp4==0,Alp6==0,Bet1==0,Bet2==0,cBet3==0,cAlp1==0,cAlp2==0,cAlp3==0,cAlp4==0,cAlp5==0,cAlp6==0}}},Brackets->True,Velocities->True];

(*ViewTheory["ConstraintAlgebraAlp0Alp5Bet3cBet2",Brackets->True,Velocities->True];*)
(*
Expr=ConstraintAlgebraAlp0Alp5Bet3cBet2@$Velocities
Print@Expr[[5]];
*)

Quit[];

*)

Mlabel@"Consistency":="9";
Mlabel@"MasterLagrangian":="4";
Mlabel@"Fig2":="Fig. 2";

Title@"Supplemental materials: Hamiltonian analysis";
Section@"Introduction";

Subsection@"How to use this document";

Comment@"These calculations are designed to accompany our manuscript in the form of supplemental materials, for the sake of reproducibility. Throughout, commentary by the authors takes the form of green text. Citations, where needed, will be managed by direct reference to arXiv numbers, and all such references are already provided in full within the body of our manuscript. One exception is the source referred to throughout as `Blagojević'; this pertains to the book `Gravitation and Gauge Symmetries', which is also referenced within the manuscript.";

Manuscript@"In boxes like this, we will make specific connections between a result which is obtained in the supplemental material and a claim which is made in the manuscript. These points of contact are not always numbered equations, they could be textual.";

Comment@"Note that a programmatical session in the Wolfram language does not really correspond to the clean flow of thoughts in a LaTeX document: there are differences that can't (and shouldn't) be ignored. Thus, whilst this document should be at least readable in standalone format, the reader is encouraged to follow it in tandem with the Wolfram language source codes, so as to avoid ambiguities. In this way, the specific operations and manipulations of quantities will become absolutely clear.";

Subsection@"Loading HiGGS";

Comment@"For these calculations, we will use the HiGGS package. The version of HiGGS used for the computations here are both developer-only, and so we include copies of the sources with these supplemental materials.";

<<xAct`HiGGS`;

Comment@"The HiGGS package is now loaded. We are interested only in the computations which lead to our Fig. 3 and Fig. 5. (in the appendix) in the manuscript. Two theories are considered. To perform the Hamiltonian analysis we use the StudyTheory[] command in HiGGS, specifying the parameters of the theory. For details of this command, and for all notation used in this supplement, see arXiv:2206.00658. The results were precomputed on a desktop computer. This is because the full Hamiltonian analysis of a theory, even run on a modern desktop computer with multiple processor cores, still takes up to half an hour. Below we will display the results using the ViewTheory[] command, which takes the pre-computed binary files (.thr.mx) and formats them. If you want to re-compute the analysis locally, the few lines of code you will need are stored at the top of this (.m) file, so just un-comment them. If there are problems with the execution, please refer to the HiGGS docs, or email wb263@cam.ac.uk.";

Section@"Singular spectrum without multipliers";

Subsection@"Introductory comments";

Comment@{"In the first instance we perform the Hamiltonian analysis of the theory without multipliers. As we know, this theory suffers from strong coupling. Accordingly, in",Mref@"MasterLagrangian"," in arXiv:2205.13534 we set",Inline@Alp1,",",Inline@Alp2,",",Inline@Alp3,",",Inline@Alp4,",",Inline@Alp6,",",Inline@Bet1,",",Inline@Bet2,",",Inline@cBet3,", to zero, suppressing most of the higher-curvature invariants, two of the three torsion invariants, and all of the Lagrange multipliers, but allow for nonvanishing",Inline@Alp0,", (Einstein-Hilbert term)",Inline@Alp5," (Riemann-Cartan-Maxwell invariant of curvature) and",Inline@Bet3,"."};

Comment@"The results of the analysis are presented below; the HiGGS output is designed to be reasonably self-explanatory, but we will nonetheless add some guiding commentary.";

Comment@{"The first set of data are the primary constraints",Inline@ToExpression@"\[Phi]"," of the theory. These are implied by the impossibility of inverting the conjugate field-momenta for the velocities of the fields. As is now common in the PGT literature, we refer to these as `if-constraints', i.e. their existence depends on the linear relations assumed among the Lagrangian parameters."};

Comment@{"Next, the Legendre-transformed Lagrangian is presented. This is broken into terms; the super-Hamiltonian (i.e. the coefficient",Inline@xAct`HiGGS`SuperHamiltonian0p[]," of the lapse function ",Inline@xAct`HiGGS`Lapse[],"), the linear super-momentum (i.e. the coefficient",Inline@xAct`HiGGS`LinearSuperMomentum1m[-xAct`HiGGS`l]," of the shift vector) and the angular super-momentum (i.e. the antisymmetric coefficient",Inline@xAct`HiGGS`RotationalSuperMomentum1p[-xAct`HiGGS`n, -xAct`HiGGS`m] ," of the timelike part of the rotational gauge field). These concepts are introduced in Blagojević."};

Comment@{"Once the primary constraints are listed, the matrix",Inline@({ToExpression@"\[Phi]",ToExpression@"\[Phi]"})," of Poisson brackets between the primaries is computed. Of course, these brackets only need to be computed for the upper triangular part of the matrix. The resulting entries lie behind the red, white and yellow squares in the relevant panel of Fig. 3."};

Comment@{"Finally, the velocities of these primaries",Inline@ToExpression@"\[Phi]"," are computed, i.e. their Poisson brackets with the super-Hamiltonian",Inline@xAct`HiGGS`SuperHamiltonian0p[],". These velocities serve two purposes; (i) they can be used to determine the `missing velocities' or `Hamiltonian multipliers'",Inline@ToExpression@"\[ScriptU]"," (not to be confused with the geometric multipliers",Inline@ToExpression@"\[Lambda]"," used in the manuscript), or (ii) they can define the secondary constraints of the theory. Whichever of these applies depends of course on",Inline@({ToExpression@"\[Phi]",ToExpression@"\[Phi]"}),", according to",Mref@"Consistency"," in our manuscript."};


Subsection@"Lists of constraints and Poisson brackets from HiGGS";

Comment@"Having briefly recounted the notation of arXiv:2206.00658, we make a call to the HiGGS command ViewTheory[] on the appropriate model. This command presents all the results which were pre-computed by the earlier call to StudyTheory[].";

(**)
ViewTheory["ConstraintAlgebraAlp0Alp5Bet3",Brackets->True,Velocities->True];
(**)

Comment@"This concludes the HiGGS output.";

Manuscript@{"The above constraints and Poisson brackets constitute the data represented by coloured squares in the left-hand panel of Fig. 2 in our Manuscript. The primary constraints",Inline@ToExpression@"\[Phi]"," are listed along the top row. The primary Poisson brackets",Inline@({ToExpression@"\[Phi]",ToExpression@"\[Phi]"})," are used to infer the white, red or yellow squares in the matrix depending on whether they are vanishing, or appear only in proportion to phase space variables, or are order unity (e.g. proportional to the metric or unit-timelike vector). The",Inline@({ToExpression@"\[Phi]",xAct`HiGGS`SuperHamiltonian0p[]})," Poisson brackets define the secondary constraints",Inline@ToString@"\[Chi]",", which appear on the sides of the matrix. Most of the Poisson brackets",Inline@({ToExpression@"\[Chi]",ToExpression@"\[Phi]"})," need not be computed (grey squares), but it can be noticed without detailed calculation that the remaining required brackets (yellow squares) do indeed arise, and that these determine all the missing velocities and so terminate the Dirac algorithm."};

Section@"Healthy spectrum with multipliers";

Subsection@"Introductory comments";

Comment@{"We now turn to the case in which multipliers have been applied. This time we set",Inline@Alp1,",",Inline@Alp2,",",Inline@Alp3,",",Inline@Alp4,",",Inline@Alp6,",",Inline@Bet1,",",Inline@Bet2,",",Inline@cBet3,", to zero, and allow for nonvanishing",Inline@Alp0,",",Inline@Alp5," and",Inline@Bet3,", but we also admit",Inline@cBet1," and",Inline@cBet2,". These final two couplings switch on the multipliers in the Lagrangian."};

Comment@"Note this time that because some of the Lagrange multiplier fields are present, certain secondary constraints can be anticipated by HiGGS a priori: this is in accordance with the theory set out in arXiv:2205.13534.";

Subsection@"Lists of constraints and Poisson brackets from HiGGS";

Comment@"We will again present the results using the ViewTheory[] command.";

(**)
ViewTheory["ConstraintAlgebraAlp0Alp5Bet3cBet1cBet2",Brackets->True,Velocities->False];
(**)

Comment@"This concludes the HiGGS output.";

Manuscript@{"The above constraints and Poisson brackets constitute the data represented by coloured squares in Fig. 5 in our Manuscript. The primary constraints",Inline@ToExpression@"\[Phi]"," are listed along the top row. The primary Poisson brackets",Inline@({ToExpression@"\[Phi]",ToExpression@"\[Phi]"})," are used to infer the white, red or yellow squares in the matrix depending on whether they are vanishing, or appear only in proportion to phase space variables, or are order unity (e.g. proportional to the metric or unit-timelike vector). The",Inline@({ToExpression@"\[Phi]",xAct`HiGGS`SuperHamiltonian0p[]})," Poisson brackets define the secondary constraints",Inline@ToString@"\[Chi]",", which appear on the sides of the matrix. Most of the Poisson brackets",Inline@({ToExpression@"\[Chi]",ToExpression@"\[Phi]"})," need not be computed (grey squares), but it can be noticed without detailed calculation that many of the remaining required brackets (yellow squares) do indeed arise. Unlike in the strongly coupled case, we find that tertiary and quaternary constraints arise in the theory: but these are also not computed in detail above. Instead, their existence can readily be inferred by considering whether the consistency chain in question can be absorbed by determining a multiplier, or whether it must continue. In case of continuation, the relevant terms in the induced constraints which arise can be understood by considering ",Mref@"MasterLagrangian"," in arXiv:2205.13534."};

Quit[];
