indexing
	description: "Helvetica-Bold font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_HELVETICA_BOLD_FONT

inherit
	PDF_ADOBE14_FONT

create
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Helvetica-Bold")
		end

	full_name : STRING is
		do
			Result := "Helvetica Bold"
		end

	family_name : STRING is
		do
			Result := "Helvetica"
		end

	weight : STRING is
		do
			Result := "Bold"
		end

	italic_angle : INTEGER is
		do
			Result := 0
		end

	is_fixed_pitch : BOOLEAN is
		do
			Result := False
		end

	character_set : STRING is
		do
			Result := "ExtendedRoman"
		end

	font_b_box : PDF_RECTANGLE is
		do
			create Result.set (-170,-228,1003,962)
		end

	underline_position : INTEGER is
		do
			Result := -100
		end

	underline_thickness : INTEGER is
		do
			Result := 50
		end

	encoding_scheme : STRING is
		do
			Result := "AdobeStandardEncoding"
		end

	cap_height : INTEGER is
		do
			Result := 718
		end

	x_height : INTEGER is
		do
			Result := 532
		end

	ascender : INTEGER is
		do
			Result := 718
		end

	descender : INTEGER is
		do
			Result := -207
		end

	std_hw : INTEGER is
		do
			Result := 118
		end

	std_vw : INTEGER is
		do
			Result := 140
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (315)
			Result.force (278, "space")
			Result.force (333, "exclam")
			Result.force (474, "quotedbl")
			Result.force (556, "numbersign")
			Result.force (556, "dollar")
			Result.force (889, "percent")
			Result.force (722, "ampersand")
			Result.force (278, "quoteright")
			Result.force (333, "parenleft")
			Result.force (333, "parenright")
			Result.force (389, "asterisk")
			Result.force (584, "plus")
			Result.force (278, "comma")
			Result.force (333, "hyphen")
			Result.force (278, "period")
			Result.force (278, "slash")
			Result.force (556, "zero")
			Result.force (556, "one")
			Result.force (556, "two")
			Result.force (556, "three")
			Result.force (556, "four")
			Result.force (556, "five")
			Result.force (556, "six")
			Result.force (556, "seven")
			Result.force (556, "eight")
			Result.force (556, "nine")
			Result.force (333, "colon")
			Result.force (333, "semicolon")
			Result.force (584, "less")
			Result.force (584, "equal")
			Result.force (584, "greater")
			Result.force (611, "question")
			Result.force (975, "at")
			Result.force (722, "A")
			Result.force (722, "B")
			Result.force (722, "C")
			Result.force (722, "D")
			Result.force (667, "E")
			Result.force (611, "F")
			Result.force (778, "G")
			Result.force (722, "H")
			Result.force (278, "I")
			Result.force (556, "J")
			Result.force (722, "K")
			Result.force (611, "L")
			Result.force (833, "M")
			Result.force (722, "N")
			Result.force (778, "O")
			Result.force (667, "P")
			Result.force (778, "Q")
			Result.force (722, "R")
			Result.force (667, "S")
			Result.force (611, "T")
			Result.force (722, "U")
			Result.force (667, "V")
			Result.force (944, "W")
			Result.force (667, "X")
			Result.force (667, "Y")
			Result.force (611, "Z")
			Result.force (333, "bracketleft")
			Result.force (278, "backslash")
			Result.force (333, "bracketright")
			Result.force (584, "asciicircum")
			Result.force (556, "underscore")
			Result.force (278, "quoteleft")
			Result.force (556, "a")
			Result.force (611, "b")
			Result.force (556, "c")
			Result.force (611, "d")
			Result.force (556, "e")
			Result.force (333, "f")
			Result.force (611, "g")
			Result.force (611, "h")
			Result.force (278, "i")
			Result.force (278, "j")
			Result.force (556, "k")
			Result.force (278, "l")
			Result.force (889, "m")
			Result.force (611, "n")
			Result.force (611, "o")
			Result.force (611, "p")
			Result.force (611, "q")
			Result.force (389, "r")
			Result.force (556, "s")
			Result.force (333, "t")
			Result.force (611, "u")
			Result.force (556, "v")
			Result.force (778, "w")
			Result.force (556, "x")
			Result.force (556, "y")
			Result.force (500, "z")
			Result.force (389, "braceleft")
			Result.force (280, "bar")
			Result.force (389, "braceright")
			Result.force (584, "asciitilde")
			Result.force (333, "exclamdown")
			Result.force (556, "cent")
			Result.force (556, "sterling")
			Result.force (167, "fraction")
			Result.force (556, "yen")
			Result.force (556, "florin")
			Result.force (556, "section")
			Result.force (556, "currency")
			Result.force (238, "quotesingle")
			Result.force (500, "quotedblleft")
			Result.force (556, "guillemotleft")
			Result.force (333, "guilsinglleft")
			Result.force (333, "guilsinglright")
			Result.force (611, "fi")
			Result.force (611, "fl")
			Result.force (556, "endash")
			Result.force (556, "dagger")
			Result.force (556, "daggerdbl")
			Result.force (278, "periodcentered")
			Result.force (556, "paragraph")
			Result.force (350, "bullet")
			Result.force (278, "quotesinglbase")
			Result.force (500, "quotedblbase")
			Result.force (500, "quotedblright")
			Result.force (556, "guillemotright")
			Result.force (1000, "ellipsis")
			Result.force (1000, "perthousand")
			Result.force (611, "questiondown")
			Result.force (333, "grave")
			Result.force (333, "acute")
			Result.force (333, "circumflex")
			Result.force (333, "tilde")
			Result.force (333, "macron")
			Result.force (333, "breve")
			Result.force (333, "dotaccent")
			Result.force (333, "dieresis")
			Result.force (333, "ring")
			Result.force (333, "cedilla")
			Result.force (333, "hungarumlaut")
			Result.force (333, "ogonek")
			Result.force (333, "caron")
			Result.force (1000, "emdash")
			Result.force (1000, "AE")
			Result.force (370, "ordfeminine")
			Result.force (611, "Lslash")
			Result.force (778, "Oslash")
			Result.force (1000, "OE")
			Result.force (365, "ordmasculine")
			Result.force (889, "ae")
			Result.force (278, "dotlessi")
			Result.force (278, "lslash")
			Result.force (611, "oslash")
			Result.force (944, "oe")
			Result.force (611, "germandbls")
			Result.force (278, "Idieresis")
			Result.force (556, "eacute")
			Result.force (556, "abreve")
			Result.force (611, "uhungarumlaut")
			Result.force (556, "ecaron")
			Result.force (667, "Ydieresis")
			Result.force (584, "divide")
			Result.force (667, "Yacute")
			Result.force (722, "Acircumflex")
			Result.force (556, "aacute")
			Result.force (722, "Ucircumflex")
			Result.force (556, "yacute")
			Result.force (556, "scommaaccent")
			Result.force (556, "ecircumflex")
			Result.force (722, "Uring")
			Result.force (722, "Udieresis")
			Result.force (556, "aogonek")
			Result.force (722, "Uacute")
			Result.force (611, "uogonek")
			Result.force (667, "Edieresis")
			Result.force (722, "Dcroat")
			Result.force (250, "commaaccent")
			Result.force (737, "copyright")
			Result.force (667, "Emacron")
			Result.force (556, "ccaron")
			Result.force (556, "aring")
			Result.force (722, "Ncommaaccent")
			Result.force (278, "lacute")
			Result.force (556, "agrave")
			Result.force (611, "Tcommaaccent")
			Result.force (722, "Cacute")
			Result.force (556, "atilde")
			Result.force (667, "Edotaccent")
			Result.force (556, "scaron")
			Result.force (556, "scedilla")
			Result.force (278, "iacute")
			Result.force (494, "lozenge")
			Result.force (722, "Rcaron")
			Result.force (778, "Gcommaaccent")
			Result.force (611, "ucircumflex")
			Result.force (556, "acircumflex")
			Result.force (722, "Amacron")
			Result.force (389, "rcaron")
			Result.force (556, "ccedilla")
			Result.force (611, "Zdotaccent")
			Result.force (667, "Thorn")
			Result.force (778, "Omacron")
			Result.force (722, "Racute")
			Result.force (667, "Sacute")
			Result.force (743, "dcaron")
			Result.force (722, "Umacron")
			Result.force (611, "uring")
			Result.force (333, "threesuperior")
			Result.force (778, "Ograve")
			Result.force (722, "Agrave")
			Result.force (722, "Abreve")
			Result.force (584, "multiply")
			Result.force (611, "uacute")
			Result.force (611, "Tcaron")
			Result.force (494, "partialdiff")
			Result.force (556, "ydieresis")
			Result.force (722, "Nacute")
			Result.force (278, "icircumflex")
			Result.force (667, "Ecircumflex")
			Result.force (556, "adieresis")
			Result.force (556, "edieresis")
			Result.force (556, "cacute")
			Result.force (611, "nacute")
			Result.force (611, "umacron")
			Result.force (722, "Ncaron")
			Result.force (278, "Iacute")
			Result.force (584, "plusminus")
			Result.force (280, "brokenbar")
			Result.force (737, "registered")
			Result.force (778, "Gbreve")
			Result.force (278, "Idotaccent")
			Result.force (600, "summation")
			Result.force (667, "Egrave")
			Result.force (389, "racute")
			Result.force (611, "omacron")
			Result.force (611, "Zacute")
			Result.force (611, "Zcaron")
			Result.force (549, "greaterequal")
			Result.force (722, "Eth")
			Result.force (722, "Ccedilla")
			Result.force (278, "lcommaaccent")
			Result.force (389, "tcaron")
			Result.force (556, "eogonek")
			Result.force (722, "Uogonek")
			Result.force (722, "Aacute")
			Result.force (722, "Adieresis")
			Result.force (556, "egrave")
			Result.force (500, "zacute")
			Result.force (278, "iogonek")
			Result.force (778, "Oacute")
			Result.force (611, "oacute")
			Result.force (556, "amacron")
			Result.force (556, "sacute")
			Result.force (278, "idieresis")
			Result.force (778, "Ocircumflex")
			Result.force (722, "Ugrave")
			Result.force (612, "Delta")
			Result.force (611, "thorn")
			Result.force (333, "twosuperior")
			Result.force (778, "Odieresis")
			Result.force (611, "mu")
			Result.force (278, "igrave")
			Result.force (611, "ohungarumlaut")
			Result.force (667, "Eogonek")
			Result.force (611, "dcroat")
			Result.force (834, "threequarters")
			Result.force (667, "Scedilla")
			Result.force (400, "lcaron")
			Result.force (722, "Kcommaaccent")
			Result.force (611, "Lacute")
			Result.force (1000, "trademark")
			Result.force (556, "edotaccent")
			Result.force (278, "Igrave")
			Result.force (278, "Imacron")
			Result.force (611, "Lcaron")
			Result.force (834, "onehalf")
			Result.force (549, "lessequal")
			Result.force (611, "ocircumflex")
			Result.force (611, "ntilde")
			Result.force (722, "Uhungarumlaut")
			Result.force (667, "Eacute")
			Result.force (556, "emacron")
			Result.force (611, "gbreve")
			Result.force (834, "onequarter")
			Result.force (667, "Scaron")
			Result.force (667, "Scommaaccent")
			Result.force (778, "Ohungarumlaut")
			Result.force (400, "degree")
			Result.force (611, "ograve")
			Result.force (722, "Ccaron")
			Result.force (611, "ugrave")
			Result.force (549, "radical")
			Result.force (722, "Dcaron")
			Result.force (389, "rcommaaccent")
			Result.force (722, "Ntilde")
			Result.force (611, "otilde")
			Result.force (722, "Rcommaaccent")
			Result.force (611, "Lcommaaccent")
			Result.force (722, "Atilde")
			Result.force (722, "Aogonek")
			Result.force (722, "Aring")
			Result.force (778, "Otilde")
			Result.force (500, "zdotaccent")
			Result.force (667, "Ecaron")
			Result.force (278, "Iogonek")
			Result.force (556, "kcommaaccent")
			Result.force (584, "minus")
			Result.force (278, "Icircumflex")
			Result.force (611, "ncaron")
			Result.force (333, "tcommaaccent")
			Result.force (584, "logicalnot")
			Result.force (611, "odieresis")
			Result.force (611, "udieresis")
			Result.force (549, "notequal")
			Result.force (611, "gcommaaccent")
			Result.force (611, "eth")
			Result.force (500, "zcaron")
			Result.force (611, "ncommaaccent")
			Result.force (333, "onesuperior")
			Result.force (278, "imacron")
			Result.force (556, "Euro")
		end

end
