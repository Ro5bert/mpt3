# mpt3

Use `beginglyph` and `endglyph` from [mpt3.mp](mpt3.mp) in place of
`beginchar` and `endchar`, and then invoke the following:

	mpt3 name=<PS NAME> designsize=<POINT SIZE> <GLYPHS FILES ...>

mpt3 does not try to parse DSC comments for procsets and other resources;
it only extracts bounding box info and the procedures use to paint the glyphs.
If you need to copy anything else from the glyph files, it must be done
manually.

## Example

Let myfont.mp be the following file:

```metapost
input mpt3
mode_setup;
designsize := 10pt#;

% Arguments for beginglyph: PS name, code, wd, ht, dp, uses color
% (Whether or not a glyph uses color affects font caching.)

beginglyph("triangle", "A", 10pt#, 10pt#, 0pt#, true);
	fill (0,0)--(w,0)--((w,0) rotated 60)--cycle withcolor green;
endglyph;

beginglyph("square", "B", 10pt#, 10pt#, 0pt#, false);
	fill (0,0)--(w,0)--(w,h)--(0,h)--cycle;
endglyph;

bye;
```

Run `mpost '&mfplain \mode=lowres; input myfont.mp'` to produce `myfont.65`,
`myfont.66`, and `myfont.tfm`.

Convert the glyph files to a Type 3 font with `mpt3 name=MyFont designsize=10
myfont.65 myfont.66`.

We can test out the font using TeX+Dvips.
(PdfTeX does not support Type 3 fonts.)

Let `doc.tex` be the following file:

```tex
\font\myfont=myfont
\myfont ABABABAB
\bye
```

Dvips needs to be told what font (i.e., set of glyphs) to associate with
"myfont".
We do this with a map file.
Let `myfont.map` be the following file:

```
myfont MyFont <myfont.ps
```

Then run `tex doc.tex && dvips -u '+myfont.map' doc.dvi` to produce `doc.ps`.
(Make sure TeX can find myfont.tfm and Dvips can find myfont.map.)
With luck, this should produce something that looks like the following:

![alternating green triangles and black squares](doc.png)
