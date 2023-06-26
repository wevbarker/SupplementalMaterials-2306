(*================*)
(*  GeoCalibrate  *)
(*================*)

(*------------------------------------*)
(*  This function is not implemented  *)
(*------------------------------------*)

GeoCalibrate::unbuilt="The GeoHiGGS environment has not yet been built.";
GeoCalibrate[]:=Catch@Module[{Part},
If[!$GeoHiGGSBuilt,Throw@Message[GeoCalibrate::unbuilt]];
Begin["Global`"];
Print@" ** GeoCalibrate...";
Part=RiemannCd[-i,-j,-k,-l]-RiemannCD[-i,-j,-k,-l];
Print@" ** Torsionful part of the Riemann-Cartan tensor:";
Print@Part;
Part=Part//ToGeometric;
Print@" ** Same quantity after ToGeometric:";
Print@Part;
Part=R[-k,-l,-i,-j];
Print@" ** Corresponding configuration of rotational gauge field (note indices pair-swapped):";
Print@Part;
Part=Part//ToBasicForm;
Part=Part/.RotationToRicci//ToNewCanonical;
Part=Part/.RicciRotActivate/.ContorsionToTorsion//ToNewCanonical;
Part=Part//ToGeometric;
Part=Part//ToNewCanonical;
Print@" ** Same quantity after BasicForm and ToGeometric (note the torsion matches, the Riemann tensor from the Ricci rotation coefficients is lost in this process because we are abusing the ToGeometric function):";
Print@Part;
End[];
];

