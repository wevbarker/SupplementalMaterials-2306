(*=============*)
(*  Linearise  *)
(*=============*)

(*Section@"Linearised field equations";*)

DefConstantSymbol[PerturbativeParameter,PrintAs->xAct`HiGGS`Private`SymbolBuild@"\[Epsilon]"];

NonlinearTensors={T1,T2,T3,R1,R2,R3,R4,R5,R6,Maxwell1,Maxwell2,Maxwell3,TorsionlessTau,Sigma,SigmaTensor1,SigmaTensor2,SigmaTensor3,RiemannGeoCovD,RicciGeoCovD,RicciScalarGeoCovD,GeneralMaxwell1};

PerturbativeExpand={};
(PerturbativeExpand~AppendTo~{#@SomeIndices___->PerturbativeParameter*(#@SomeIndices)})&/@NonlinearTensors;
(PerturbativeExpand~AppendTo~{GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

(PerturbativeExpand~AppendTo~{GeoCovD[Index2_]@GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index2]@GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

(PerturbativeExpand~AppendTo~{GeoCovD[Index3_]@GeoCovD[Index2_]@GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index3]@GeoCovD[Index2]@GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

(PerturbativeExpand~AppendTo~{GeoCovD[Index4_]@GeoCovD[Index3_]@GeoCovD[Index2_]@GeoCovD[Index1_]@(#@SomeIndices___)->PerturbativeParameter*(GeoCovD[Index4]@GeoCovD[Index3]@GeoCovD[Index2]@GeoCovD[Index1]@(#@SomeIndices))})&/@NonlinearTensors;

PerturbativeExpand//=Flatten;

LineariseQuantity[Expr_,Order_:1]:=Module[{LinearisedExpr=Expr}, 
	LinearisedExpr=LinearisedExpr/.PerturbativeExpand;
	LinearisedExpr=LinearisedExpr~Series~{PerturbativeParameter,0,Order};
	LinearisedExpr//=Normal;
	LinearisedExpr=LinearisedExpr/.{PerturbativeParameter->1};
	LinearisedExpr];

(*Comment@"For the case without multipliers, it appears hard to obtain an exact expression for the effective theory. We therefore include some rudimentary tools with which to linearise equations (i.e. expand to lowest order in the torsion and Riemann curvature).";*)

(*Comment@"The full stress-energy equation.";
DisplayEquation@LinearStressEnergyEquation;*)

(*Comment@"The full spin equation.";*)
LinearSpinEquation=SpinEquation//LineariseQuantity;
(*DisplayEquation@LinearSpinEquation;*)

(*Comment@"The tensor part of the spin equation.";*)
LinearSpinEquation1=SpinEquation1//LineariseQuantity;
(*DisplayEquation@LinearSpinEquation1;*)

(*Comment@"The vector part of the spin equation.";*)
LinearSpinEquation2=SpinEquation2//LineariseQuantity;
(*DisplayEquation@LinearSpinEquation2;*)

(*Comment@"The axial vector part of the spin equation.";*)
LinearSpinEquation3=SpinEquation3//LineariseQuantity;
(*DisplayEquation@LinearSpinEquation3;*)
