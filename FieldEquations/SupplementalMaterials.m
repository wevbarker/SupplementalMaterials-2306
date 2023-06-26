(*=========================*)
(*  SupplementalMaterials  *)
(*=========================*)

<<xAct`xPlain`;

Mlabel@"KalbRamondDef":="5";
Mlabel@"Perturbative":="6a";
Mlabel@"ReducedNonlinearSpinEquation2":="6b";
Mlabel@"ReducedNonlinearSpinEquation3":="6c";
Mlabel@"SolveForMultiplier":="8a";
Mlabel@"ImprovedSpinEquation2":="8b";
Mlabel@"ImprovedSpinEquation3":="8c";
Mlabel@"ReconstructedLagrangian":="9";
Mlabel@"EffectiveKalbRamond":="8";

Title@"Supplemental materials: field equations";
Section@"Introduction";

Subsection@"How to use this document";

Comment@"These calculations are designed to accompany our manuscript in the form of supplemental materials, for the sake of reproducibility. Throughout, commentary by the authors takes the form of green text. Citations, where needed, will be managed by direct reference to arXiv numbers, and all such references are already provided in full within the body of our manuscript. One exception is the source referred to throughout as `Blagojević'; this pertains to the book `Gravitation and Gauge Symmetries', which is also referenced within the manuscript.";

Manuscript@"In boxes like this, we will make specific connections between a result which is obtained in the supplemental material and a claim which is made in the manuscript. These points of contact are not always numbered equations, they could be textual.";

Comment@"Note that a programmatical session in the Wolfram language does not really correspond to the clean flow of thoughts in a LaTeX document: there are differences that can't (and shouldn't) be ignored. Thus, whilst this document should be at least readable in standalone format, the reader is encouraged to follow it in tandem with the Wolfram language source codes, so as to avoid ambiguities. In this way, the specific operations and manipulations of quantities will become absolutely clear.";

Subsection@"Loading HiGGS and GeoHiGGS";

Comment@"For these calculations, we will use the HiGGS and GeoHiGGS packages. Note that GeoHiGGS was not developed for public release, and so is not documented. The versions of HiGGS and GeoHiGGS used for the computations here are both developer-only, and so we include copies of the sources with these supplemental materials.";

<<xAct`GeoHiGGS`;

Comment@"All the requisite packages have now been loaded, so we can proceed with the calculations.";

Section@"Deriving the field equations";

Comment@"HiGGS is designed to study the full ten-parameter Poincaré gauge theory, including nine extra parameters which activate various Lagrange multipliers as defined in arXiv:2205.13534. As a first step, we define the most general case of the set of theories we are interested in by constructing a rule which constrains the Lagrangian couplings.";

MPlSymb="\!\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(Pl\)]\)";
Quiet@DefConstantSymbol[MPl,PrintAs->MPlSymb];

DefConstantSymbol[AlpM,PrintAs->"\[Alpha]"];
DefConstantSymbol[Mu2,PrintAs->("\!\(\*OverscriptBox[\(.\), \(2\)]\)"~StringJoin~"\[Mu]")];
DefConstantSymbol[Mu3,PrintAs->("\!\(\*OverscriptBox[\(.\), \(3\)]\)"~StringJoin~"\[Mu]")];

(*Comment@{"Now we introduce the new symbols",Inline@AlpM,Inline@Mu2,Inline@Mu3};*)

ToTheory={Alp1->0,Alp2->0,Alp3->0,Alp4->0,Alp6->0,Bet1->0,cAlp1->0,cAlp2->0,cAlp3->0,cAlp4->0,cAlp6->0,cBet3->0};
DisplayExpression[ToTheory,EqnLabel->"ToTheory"];

Comment@{"We can see that the rules in",Cref@"ToTheory"," are used to disable most of the couplings in the general theory. The couplings which are not suppressed are those which appear in the various Lagrangia in the manuscript. Specifically the",Inline@Alp5," coupling, which mediates the quadratic Riemann-Cartan-Maxwell invariant",Inline@(R5[-i,-j]*R5[i,j]),", the",Inline@cBet1," and",Inline@cBet2," couplings, which mediate the torsion multipliers, and the",Inline@Bet2," and",Inline@Bet3," couplings which contribute to the torsion mass. These remaining couplings will appear in the equations below."};

(*===================================*)
(*  Initial computations with HiGGS  *)
(*===================================*)

Manuscript@{"Note a point on conventions. The HiGGS infrastructure, and the computations in this supplement, is heavily dependent on the conventions of Blagojević. This includes the slightly unorthodox understanding that differentiation with respect to an antisymmetric tensor has twice the value which would usually be assumed by other sources. For example, within the supplement we take the partial derivative of",Inline@(A[i,j,-m]A[-i,-j,m])," with respect to",Inline@A[i,j,-m]," to be",Inline@(4A[-i,-j,m])". The conventions used in the body of the manuscript itself do not follow this rule, but would result instead in.",Inline@(4A[-i,-j,m])"."};

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","GeneralisedMomenta.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","StressEnergyTensor.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","SpinTensor.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","StressEnergyTensorConservation.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","SpinTensorConservation.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","SpinEquationParts.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","PresentIrrepConventions.m"};

(*===================================*)
(*  Main computations with GeoHiGGS  *)
(*===================================*)

Section@"First-to-second order";

Comment@"At this point we have developed the field equations as far as we are able within the HiGGS environment; recall that HiGGS is not purpose-built for this Lagrangian analysis, but rather computes the Hamiltonian constraint structure. HiGGS is useful to us only insofar as it provides the conventions associated with the Poincaré gauge theory, and the geometric multipliers defined in arXiv:2205.13534. To proceed further, we wish to use some of the built-in functionality of xAct.";

Comment@"Specifically, HiGGS is based in the first-order or gauge-theoretic formulation of the theory, which is mostly shared by Blagojević. A key aspect of our manuscript is that the second-order formulation appears rather more revealing in the analysis. xAct and xTensor, which were not developed by the authors, already contain some very sophisticated tools for working with the second-order formulation of torsion gravity.";

Comment@"To access these tools, we face another problem. HiGGS is purposely using a flat spacetime, so that the Poincaré gauge theory is seen from a natural Yang-Mills perspective. In contrast the xAct and xTensor setup relies on the geometric interpretation, whereby the Riemann-Cartan curvature and torsion are geometric properties of the manifold.";

Comment@"It turns out to be possible to switch out a flat manifold for a curved/torsionful one with the same name, within one xAct kernel session. To do so requires some very careful treatment of defined symbols across multiple Wolfram language `contexts' (i.e. scopes). This is what GeoHiGGS is defined to do. Given a HiGGS session, having defined a very large number of first-order formulation quantities, an application of the BuildGeoHiGGS command from GeoHiGGS will destroy the underlying Minkowski spacetime and replace it with a curved/torsionful replacement. Natural re-interpretations of various other HiGGS quantities are also made at the same time. The end result is a standard, working xAct/xTensor session with the HiGGS-defined and user-defined quantities still present in the kernel memory.";

Comment@"We run BuildGeoHiGGS now...";

BuildGeoHiGGS[];

Comment@"...and so now BuildGeoHiGGS has completed its execution.";

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","ToShellRules.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","BelinfanteRosenfeldTensor.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","ConserveSigma.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","MaxwellTensors.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","BianchiIdentities.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","MaxwellPart.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","SymmetricPart.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","ScalarPart.m"};
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","SourceCurrents.m"};

Comment@"Now we have set up some tools in the geometric, second-order formulation. The rest of this script will be devoted to an analysis of the case with and without multipliers.";

(*======================================*)
(*  Examination of individual theories  *)
(*======================================*)

(*Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","StronglyCoupledCase/Run.m"};*)
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","NewGRWithVectorAndAxialVector/Run.m"};

Comment@"This concludes the supplemental materials to our manuscript.";
Quit[];
