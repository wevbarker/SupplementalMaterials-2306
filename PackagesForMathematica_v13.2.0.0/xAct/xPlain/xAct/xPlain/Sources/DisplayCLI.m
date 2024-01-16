(*===============*)
(*  DisplpayCLI  *)
(*===============*)

StyleString@"Comment":="\e[1;33;40m";
StyleString@"Supercomment":="\e[1;30;43m";
StyleString@"Expression":="\e[3;30;46m";

Options@DisplayCLI={
	StyleCLI->"Comment"
};
DisplayCLI[Expr_?StringQ,OptionsPattern[]]:=Module[{},	
	Run@("echo -e \"\n\n"<>StyleString@OptionValue@StyleCLI<>Expr<>"\e[0m\n\n\"");
];
