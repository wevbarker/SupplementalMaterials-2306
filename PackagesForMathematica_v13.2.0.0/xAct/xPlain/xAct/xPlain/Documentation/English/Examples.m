(*============*)
(*  Examples  *)
(*============*)

<<xAct`xPlain`;

Title@"Welcome to the xPlain package: here is a title!";
Chapter@"And here is a chapter!";
Section@"And here is a section!";
Subsection@"And here is a subsection!";
DisplayExpression[x,EqnLabel->"Eq1"];
DisplayEquation[x,EqnLabel->"Eq2"];
Comment@{"Here is a comment refering to",Cref@"Eq1"," and containing",Inline@x," inline. We can also refer to multiple equations as",Cref@{"Eq1","Eq2"}," you see..."};
Comment@{"Here is a comment refering to",Cref@"Eq1"," and multiple equations as",Cref@{"Eq1","Eq2"},". You can see that this is a pretty long comment so it will be interesting to see how the line break works!"};
Supercomment@{"Here is a comment refering to",Cref@"Eq1"," and multiple equations as",Cref@{"Eq1","Eq2"},". You can see that this is a pretty long comment so it will be interesting to see how the line break works!"};

Quit[];
