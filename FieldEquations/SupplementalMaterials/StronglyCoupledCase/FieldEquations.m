(*==================*)
(*  FieldEquations  *)
(*==================*)

Subsection@"The new field equations";

Comment@"To investigate the strongly-coupled theory, we resurrect the field equations which we last saw in the HiGGS environment, and make sure that they have been correctly translated by GeoHiGGS into the second-order formulation.";

NewGRWithVectorAndAxialVector[Expr_]:=Module[{CaseExpr},
	CaseExpr=Expr/.{Alp0->MPl^2,Alp1->0,Alp2->0,Alp3->0,Alp4->0,Alp5->AlpM,Alp6->0,Bet1->0,Bet2->0,Bet3->0,cAlp1->0,cAlp2->0,cAlp3->0,cAlp4->0,cAlp5->0,cAlp6->0,cBet1->0,cBet2->0,cBet3->0};
	CaseExpr//=ToGeometric;
	CaseExpr=CaseExpr/.TSO13Activate;
	CaseExpr=CaseExpr/.TLambdaSO13Activate;
	CaseExpr//=ToGeoCanonical;
CaseExpr];
(*
Comment@"The full stress-energy equation.";
StressEnergyEquation//=NewGRWithVectorAndAxialVector;
DisplayEquation@StressEnergyEquation;

Comment@"The full spin equation.";
SpinEquation//=NewGRWithVectorAndAxialVector;
DisplayEquation@SpinEquation;

Comment@"The tensor part of the spin equation.";
SpinEquation1//=NewGRWithVectorAndAxialVector;
DisplayEquation@SpinEquation1;

Comment@"The vector part of the spin equation.";
SpinEquation2//=NewGRWithVectorAndAxialVector;
DisplayEquation@SpinEquation2;

Comment@"The pseudovector part of the spin equation.";
SpinEquation3//=NewGRWithVectorAndAxialVector;
DisplayEquation@SpinEquation3;

(FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","StronglyCoupledCase/FieldEquations.mx"})~DumpSave~({StressEnergyEquation,SpinEquation,SpinEquation1,SpinEquation2,SpinEquation3});
Quit[];
*)

Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials","StronglyCoupledCase/FieldEquations.mx"};

Comment@{"The full tetrad equation, the geometric interpretation of",Cref@"FinalStressEnergyEquation","."};
DisplayEquation@StressEnergyEquation;

Comment@{"The full spin connection equation, the geometric interpretation of",Cref@"FinalSpinEquation","."};
DisplayEquation@SpinEquation;

Comment@{"The tensor part of the spin connection equation, the geometric interpretation of",Cref@"SpinEquation1","."};
DisplayEquation[SpinEquation1,EqnLabel->"NewSpinEquation1"];

Comment@{"The vector part of the spin connection equation, the geometric interpretation of",Cref@"SpinEquation2","."};
SpinEquation2//=ApplyBianchi;
DisplayEquation[SpinEquation2,EqnLabel->"NewSpinEquation2"];

Comment@{"The axial vector part of the spin connection equation, the geometric interpretation of",Cref@"SpinEquation3","."};
SpinEquation3//=ApplyBianchi;
DisplayEquation[SpinEquation3,EqnLabel->"NewSpinEquation3"];
