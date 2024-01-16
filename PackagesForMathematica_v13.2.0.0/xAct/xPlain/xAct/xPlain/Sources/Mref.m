(*========*)
(*  Mref  *)
(*========*)

Options@Mref={
	Kind->"Equation"
};
Mref[ManuscriptEquationLabel_?StringQ,OptionsPattern[]]:=Module[{},{" ",KindAbbr@OptionValue@Kind," (",ToString@(Mlabel@ManuscriptEquationLabel),")"}];
