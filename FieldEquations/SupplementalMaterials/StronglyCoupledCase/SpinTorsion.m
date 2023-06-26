(*===============*)
(*  SpinTorsion  *)
(*===============*)

Subsection@"The effective Kalb-Ramond theory";

Comment@"We first define a general Kalb-Ramond field (note that strictly the term Kalb-Ramond refers to the canonical, massless case - we will however use it to refer to our general 2-form).";

Maxwell1Expr=(GeoCovD[-c][T1[c,-a,-b]]-GeoCovD[-c][T1[c,-b,-a]]
		-Maxwell2[-a,-b]
		+(3/4)*epsilonGeoG[-a,-b,-c,-d]*Maxwell3[c,d]
		+T2[c]T1[-a,-c,-b]
		-T2[c]T1[-b,-c,-a]
		-(3/2)*epsilonGeoG[-c,-d,-e,-b]T3[c]T1[-a,d,e]
		+(3/2)*epsilonGeoG[-c,-d,-e,-a]T3[c]T1[-b,d,e]
	);

NonlinearMaxwellSymb="\[ScriptCapitalB]";
DefTensor[GeneralMaxwell1[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`HiGGS`Private`SymbolBuild[NonlinearMaxwellSymb]];

FromGeneralMaxwell1=MakeRule[{GeneralMaxwell1[-a,-b],Evaluate@Maxwell1Expr/MPl},MetricOn->All,ContractMetrics->True];

Expr=(
		(1/2)*(
			MPl*GeneralMaxwell1[-a,-b]
			-(Evaluate@(MPl*GeneralMaxwell1[-a,-b]/.FromGeneralMaxwell1)
				-(GeoCovD[-c][T1[c,-a,-b]]-GeoCovD[-c][T1[c,-b,-a]])))
		+(1/2)*(GeoCovD[-c][T1[c,-a,-b]]+GeoCovD[-c][T1[c,-b,-a]])
)//ToNewCanonical;

ToGeneralMaxwell1c=MakeRule[{
		GeoCovD[-c][T1[c,-a,-b]],
		Evaluate@Expr
	},
	MetricOn->All,ContractMetrics->True];

ToGeneralMaxwell1=ToGeneralMaxwell1c;
(*ToGeneralMaxwell1=Join[ToGeneralMaxwell1a,ToGeneralMaxwell1b];*)

ToNonlinearMaxwell=Join[ToGeneralMaxwell1,ToMaxwell2,ToMaxwell3];
FromNonlinearMaxwell=Join[FromGeneralMaxwell1,FromMaxwell2,FromMaxwell3];

NewExpr=GeneralMaxwell1[-a,-b];
DisplayExpression@NewExpr;
NewExpr=NewExpr/.FromNonlinearMaxwell;
NewExpr//=ToNewCanonical;
DisplayExpression[NewExpr,EqnLabel->"KalbRamondDef"];

Manuscript@{"Here is the unlikely-looking definition of our 2-form field: we compare",Cref@"KalbRamondDef"," with ",Mref@"KalbRamondDef"," in our manuscript."};

Comment@{"Having constructed the effective Kalb-Ramond field in",Cref@"KalbRamondDef",", we are ready to simplify the equations of motion."};

Expr=SpinEquation2;
(*DisplayEquation@Expr;*)

Comment@{"Now we express",Cref@"NewSpinEquation2"," in terms of",Cref@"KalbRamondDef","."};

Expr=Expr/.FromMaxwell;
Expr=Expr/.SigmaToSigmaTensor;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=CollectTensors;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
ReducedNonlinearSpinEquation2=Expr;
DisplayEquation[ReducedNonlinearSpinEquation2,EqnLabel->"ReducedNonlinearSpinEquation2"];

Comment@"Clearly this is much more compact. The present form allows us to make a rule to substitute for the vector torsion in terms of the Kalb-Ramond field and the tensor part of the torsion.";

Manuscript@{"Here emerges one of our spin connection equations: compare",Cref@"ReducedNonlinearSpinEquation2"," with",Mref@"ReducedNonlinearSpinEquation2"," in the manuscript."};

T2ToF1T1=MakeQuotientRule[{T2[-w],ReducedNonlinearSpinEquation2},Method->"Coefficient"];

Comment@{"Now we express",Cref@"NewSpinEquation3"," in terms of",Cref@"KalbRamondDef","."};

Expr=SpinEquation3;
(*DisplayEquation@Expr;*)

Expr=Expr/.FromMaxwell;
Expr=Expr/.SigmaToSigmaTensor;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=CollectTensors;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
ReducedNonlinearSpinEquation3=Expr;
DisplayEquation[ReducedNonlinearSpinEquation3,EqnLabel->"ReducedNonlinearSpinEquation3"];

Comment@"And again we make a rule to substitute for the axial vector torsion in terms of the Kalb-Ramond field and the tensor part of the torsion.";

Manuscript@{"Here emerges another of our spin connection equations: compare",Cref@"ReducedNonlinearSpinEquation3"," with",Mref@"ReducedNonlinearSpinEquation3"," in the manuscript."};

T3ToF1T1=MakeQuotientRule[{T3[c],ReducedNonlinearSpinEquation3},Method->"Coefficient"];
(*
Comment@"The tensor torsion equation:";

Expr=LinearSpinEquation1;
Expr=Expr/.SigmaToSigmaTensor;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
ReducedLinearSpinEquation1=Expr;
DisplayEquation@ReducedLinearSpinEquation1;
*)
Comment@{"Now for the less easy (tensor) case, we express",Cref@"NewSpinEquation1"," in terms of",Cref@"KalbRamondDef","."};

Expr=SpinEquation1;
Expr=Expr/.FromMaxwell;
Expr=Expr/.SigmaToSigmaTensor;
Expr=Expr/.SigmaTensorSO13Activate;
Expr//=ToGeoCanonical;
Expr=Expr/.GradDivT2ToDivGradT2;
Expr=Expr/.GradDivT3ToDivGradT3;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr//=CollectTensors;
Expr//=ToNewCanonical;
Expr//=CollectTensors;
Expr=Expr/.ToNonlinearMaxwell;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.Bianchi;
Expr//=CollectTensors;
ReducedNonlinearSpinEquation1=Expr;

Comment@"Here is the tensor part with the Kalb-Ramond field partially implemented and some of the non-commuting derivatives tidied up. The equation still refers to the vector and axial vector torsion, so we will need to substitute for these next.";

Expr=ReducedNonlinearSpinEquation1;
Expr=Expr/.FromMaxwell;
Expr//=ToNewCanonical;
Expr//=SortCovDs;
Expr//=ToNewCanonical;
ReducedNonlinearSpinEquation1=Expr;
DisplayEquation[ReducedNonlinearSpinEquation1,EqnLabel->"ReducedNonlinearSpinEquation1"];

Comment@{"Having made those final vector and axial vector torsion substitutions in",Cref@"ReducedNonlinearSpinEquation1"," using",Cref@"ReducedNonlinearSpinEquation2"," and",Cref@"ReducedNonlinearSpinEquation3",", we arrive at an expression which contains the spin current, the Kalb-Ramond field and the tensor part of the torsion. This is what we need, but notice that we can't solve directly for the tensor torsion due to (i) nonlinearity of the expression and (ii) there are two lowest-order terms linear in the tensor torsion."};

Expr=ReducedNonlinearSpinEquation1;
Expr=Expr/.T2ToF1T1;
Expr=Expr/.T3ToF1T1;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"PrecursorPerturbative"];

Comment@{"We can't solve the nonlinearity problem, but we can use the cyclic identity obeyed by the tensor part to tidy the expression somewhat. Accordingly",Cref@"PrecursorPerturbative"," becomes the following."};

Expr=Symmetrize[GeoG[-v,-r]Evaluate@Expr,{-v,-u}];
Expr//=ToNewCanonical;
Expr//=ToCanonical;
Expr=Expr-Evaluate[Expr~Coefficient~T1[-u,-w,-v]](T1[-u,-v,-w]+T1[-v,-w,-u]+T1[-w,-u,-v]);
Expr//=ToNewCanonical;
ExplicitExpression=Expr;
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
DisplayEquation[Expr,EqnLabel->"Perturbative"];

Manuscript@{"Here is a spin connection equation: compare",Cref@"Perturbative"," with",Mref@"Perturbative"," in the manuscript."};

Comment@{"We can now use",Cref@"Perturbative"," make a rule to substitute for the tensor part of the torsion in terms of the Kalb-Ramond field and the spin current, and also in terms of itself via higher-order corrections."};

T1ToGravityBasic=MakeQuotientRule[{T1[-u,-v,-w],Expr},Method->"Coefficient",Verify->False];

Comment@{"We use this rule to replace within",Cref@"Perturbative"," instances of the tensor part of the torsion which appear in precisely these higher-order corrections, and truncate to fourth-order in small quantities."};

KTerm=Evaluate[ExplicitExpression~Coefficient~T1[-u,-v,-w]]*T1[-u,-v,-w];
Expr=ExplicitExpression-KTerm;
Expr=Expr/.T1ToGravityBasic;
Expr=LineariseQuantity[Expr,4];
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr+KTerm;
Expr//=ToNewCanonical;
DisplayEquation[Expr,EqnLabel->"FullPerturbative"];

Comment@{"We can see how this equation now allows us to solve for the tensor part of the torsion in terms of the Kalb-Ramond field and the spin tensor up to a high perturbative order (when the spin tensor is switched off, the above expression contains a single term linear in the tensor torsion and many more nonlinear terms purely in the Kalb-Ramond field). Accordingly, we make another rule using",Cref@"FullPerturbative","."};

T1ToGravityFourth=MakeQuotientRule[{T1[-u,-v,-w],Expr},Method->"Coefficient"];

Manuscript@{"The price to be paid for working with the Kalb-Ramond field is that the tensor part equation",Cref@"FullPerturbative"," does not immediately act as a field equation to propagate the field. Accordingly, to see how the Kalb-Ramond field moves we must take the divergence of the tensor part equation",Cref@"FullPerturbative",". Remember that in",Cref@"FullPerturbative"," there was a single instance of",Inline@T1[i,-j,-k]," remaining at linear order (you have to search for it among many lines). The divergence of this term can be eliminated using the definition in",Cref@"KalbRamondDef",", and the vector/axial vector torsion eliminated once again using",Cref@{"ReducedNonlinearSpinEquation2","ReducedNonlinearSpinEquation3"}," before using",Cref@"FullPerturbative"," again to eliminate any remaining",Inline@T1[i,-j,-k]," perturbatively. We then truncate the final equation to third order in small quantities, and find the following."};

Expr=ReducedNonlinearSpinEquation1;
Expr//=GeoCovD[-r];
Expr=Expr/.ToNonlinearMaxwell;
Expr=LineariseQuantity[Expr,3];
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.FromMaxwell;
Expr=LineariseQuantity[Expr,3];
Expr=Expr/.T2ToF1T1;
Expr=Expr/.T3ToF1T1;
Expr=LineariseQuantity[Expr,3];
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.T2ToF1T1;
Expr=Expr/.T3ToF1T1;
Expr=LineariseQuantity[Expr,3];
Expr//=ToGeoCanonical;
Expr//=ApplyBianchi;
Expr=Expr/.T1ToGravityFourth;
Expr=LineariseQuantity[Expr,3];
Expr//=ToNewCanonical;
DisplayEquation[Expr,EqnLabel->"FinalFieldEquation"];

FinalKalbRamondFieldEquation=Expr;

Manuscript@{"It is this final expression",Cref@"FinalFieldEquation"," from which the effective theory (the Lagrangian) is inferred in our letter. Note that we are intested in the matter-free limit where the spin tensor is taken to vanish. Sifting through the remaining terms, one finds that there is a mass term and a collection of kinetic terms. Only those kinetic terms which are third order in",Inline@GeneralMaxwell1[-u,-w]," do not cancel among themselves. By considering further the zero-curvature limit of this field equation, we are able to study the torsion dynamics completely in isolation. In that case the field equation does follow from the flat-space Lagrangian presented in",Mref@"EffectiveKalbRamond"," in the manuscript. Because there is then no Einstein-Hilbert term, we do not have to worry about the overall normalisation/sign of this effective Lagrangian, and we are thus free to make the",Inline@GeneralMaxwell1[-u,-w]," mass appear with the right sign and a factor of 1/2. In the full theory, interactions with the curvature are likely to become important (and the sign of the mass may need to be amended), but it is hard to imagine that curvature will in any way fix the kinetic pathologies in the model. The appearance of the six strongly coupled modes from the `stuck together' vector/axial vector sectors is in line with the qualitative predictions made in arXiv:0112030."};

Comment@{"Some extra information can be obtained from this field equation",Cref@"FinalFieldEquation",", if one is interested in the unitarity of the strongly-coupled particle spectrum. The dominant kinetic terms in the field equation are third-order in small quantities, and we'd like to reverse-engineer the specific fourth-order kinetic structure in the effective Lagrangian which gives rise to them."};

KalbRamondFieldEquationKineticTerm=LineariseQuantity[FinalKalbRamondFieldEquation,3]/.{SigmaTensor1->Zero,SigmaTensor2->Zero,SigmaTensor3->Zero};
KalbRamondFieldEquationKineticTerm//=ToGeoCanonical;
KalbRamondFieldEquationKineticTerm-=(2/3)*MPl^3*GeneralMaxwell1[-u,-w];
KalbRamondFieldEquationKineticTerm=KalbRamondFieldEquationKineticTerm/.{RicciGeoCovD->Zero,RiemannGeoCovD->Zero,RicciScalarGeoCovD->Zero};

Comment@"Here is the kinetic term from the field equation.";
DisplayExpression@KalbRamondFieldEquationKineticTerm;

KalbRamondLagrangianKineticTermAnsatz=MakeContractionAnsatz[GeoCovD[-a]@GeneralMaxwell1[-b,-c]GeoCovD[-d]@GeneralMaxwell1[-e,-f]GeneralMaxwell1[-g,-h]GeneralMaxwell1[-i,-j],Parallelization->False];

Comment@"Here is an ansatz for the Lagrangian kinetic term which could give rise to such a field equation.";
DisplayExpression[KalbRamondLagrangianKineticTermAnsatz,EqnLabel->"MyAnsatz"];

KalbRamondFieldEquationKineticTermAnsatz=VarD[GeneralMaxwell1[u,w],GeoCovD][KalbRamondLagrangianKineticTermAnsatz]//ToGeoCanonical;
KalbRamondFieldEquationKineticTermAnsatz=KalbRamondFieldEquationKineticTermAnsatz/.{RicciGeoCovD->Zero,RiemannGeoCovD->Zero,RicciScalarGeoCovD->Zero};

AnsatzSolutions=ToConstantSymbolEquations[KalbRamondFieldEquationKineticTermAnsatz-KalbRamondFieldEquationKineticTerm==0];
AnsatzSolutions=Solve[AnsatzSolutions];
AnsatzSolutions=Join[AnsatzSolutions[[1]],{C12->0,C14->0,C10->0}];
KalbRamondLagrangianKineticTermAnsatz=KalbRamondLagrangianKineticTermAnsatz/.AnsatzSolutions/.AnsatzSolutions//ToNewCanonical;

Comment@{"Here is the ansatz",Cref@"MyAnsatz"," again, solved to match the field equations. We will include it for completeness."};
DisplayExpression[KalbRamondLagrangianKineticTermAnsatz,EqnLabel->"KalbRamondLagrangianKineticTermAnsatz"];

Manuscript@{"The specific kinetic structure in",Cref@"KalbRamondLagrangianKineticTermAnsatz",", with its many indices/terms suppressed, is that which appears in the effective, strongly coupled theory in",Mref@"EffectiveKalbRamond"," (for a specific choice of surface terms)."};
