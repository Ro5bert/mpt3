def beginglyph(expr name, c, w_sharp, h_sharp, d_sharp, usecolor) =
	beginchar(c, w_sharp, h_sharp, d_sharp);
	begingroup
		% To avoid repeating gstate initialization code in every glyph proc,
		% we force MetaPost to start every glyph in a certain gstate, which
		% we emit code for just once (in BuildGlyph).
		interim linejoin:=rounded;
		interim linecap:=rounded;
		interim miterlimit:=10;
		addto currentpicture doublepath (0,0)
			withpostscript "%BeginGlyph " & name
				& " " & decimal charcode
				& " " & decimal charwd
				& if usecolor: " 1" else: " 0" fi;
	endgroup;
enddef;

def endglyph =
	addto currentpicture doublepath (0,0) withprescript "%EndGlyph";
	endchar;
enddef;

endinput;
