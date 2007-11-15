indexing
	description: "Times-Bold font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_TIMES_BOLD_FONT

inherit
	PDF_ADOBE14_FONT

create
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Times-Bold")
		end

	full_name : STRING is
		do
			Result := "Times Bold"
		end

	family_name : STRING is
		do
			Result := "Times"
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
			create Result.set (-168,-218,1000,935)
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
			Result := 676
		end

	x_height : INTEGER is
		do
			Result := 461
		end

	ascender : INTEGER is
		do
			Result := 683
		end

	descender : INTEGER is
		do
			Result := -217
		end

	std_hw : INTEGER is
		do
			Result := 44
		end

	std_vw : INTEGER is
		do
			Result := 139
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (315)
			Result.force (250, "space")
			Result.force (333, "exclam")
			Result.force (555, "quotedbl")
			Result.force (500, "numbersign")
			Result.force (500, "dollar")
			Result.force (1000, "percent")
			Result.force (833, "ampersand")
			Result.force (333, "quoteright")
			Result.force (333, "parenleft")
			Result.force (333, "parenright")
			Result.force (500, "asterisk")
			Result.force (570, "plus")
			Result.force (250, "comma")
			Result.force (333, "hyphen")
			Result.force (250, "period")
			Result.force (278, "slash")
			Result.force (500, "zero")
			Result.force (500, "one")
			Result.force (500, "two")
			Result.force (500, "three")
			Result.force (500, "four")
			Result.force (500, "five")
			Result.force (500, "six")
			Result.force (500, "seven")
			Result.force (500, "eight")
			Result.force (500, "nine")
			Result.force (333, "colon")
			Result.force (333, "semicolon")
			Result.force (570, "less")
			Result.force (570, "equal")
			Result.force (570, "greater")
			Result.force (500, "question")
			Result.force (930, "at")
			Result.force (722, "A")
			Result.force (667, "B")
			Result.force (722, "C")
			Result.force (722, "D")
			Result.force (667, "E")
			Result.force (611, "F")
			Result.force (778, "G")
			Result.force (778, "H")
			Result.force (389, "I")
			Result.force (500, "J")
			Result.force (778, "K")
			Result.force (667, "L")
			Result.force (944, "M")
			Result.force (722, "N")
			Result.force (778, "O")
			Result.force (611, "P")
			Result.force (778, "Q")
			Result.force (722, "R")
			Result.force (556, "S")
			Result.force (667, "T")
			Result.force (722, "U")
			Result.force (722, "V")
			Result.force (1000, "W")
			Result.force (722, "X")
			Result.force (722, "Y")
			Result.force (667, "Z")
			Result.force (333, "bracketleft")
			Result.force (278, "backslash")
			Result.force (333, "bracketright")
			Result.force (581, "asciicircum")
			Result.force (500, "underscore")
			Result.force (333, "quoteleft")
			Result.force (500, "a")
			Result.force (556, "b")
			Result.force (444, "c")
			Result.force (556, "d")
			Result.force (444, "e")
			Result.force (333, "f")
			Result.force (500, "g")
			Result.force (556, "h")
			Result.force (278, "i")
			Result.force (333, "j")
			Result.force (556, "k")
			Result.force (278, "l")
			Result.force (833, "m")
			Result.force (556, "n")
			Result.force (500, "o")
			Result.force (556, "p")
			Result.force (556, "q")
			Result.force (444, "r")
			Result.force (389, "s")
			Result.force (333, "t")
			Result.force (556, "u")
			Result.force (500, "v")
			Result.force (722, "w")
			Result.force (500, "x")
			Result.force (500, "y")
			Result.force (444, "z")
			Result.force (394, "braceleft")
			Result.force (220, "bar")
			Result.force (394, "braceright")
			Result.force (520, "asciitilde")
			Result.force (333, "exclamdown")
			Result.force (500, "cent")
			Result.force (500, "sterling")
			Result.force (167, "fraction")
			Result.force (500, "yen")
			Result.force (500, "florin")
			Result.force (500, "section")
			Result.force (500, "currency")
			Result.force (278, "quotesingle")
			Result.force (500, "quotedblleft")
			Result.force (500, "guillemotleft")
			Result.force (333, "guilsinglleft")
			Result.force (333, "guilsinglright")
			Result.force (556, "fi")
			Result.force (556, "fl")
			Result.force (500, "endash")
			Result.force (500, "dagger")
			Result.force (500, "daggerdbl")
			Result.force (250, "periodcentered")
			Result.force (540, "paragraph")
			Result.force (350, "bullet")
			Result.force (333, "quotesinglbase")
			Result.force (500, "quotedblbase")
			Result.force (500, "quotedblright")
			Result.force (500, "guillemotright")
			Result.force (1000, "ellipsis")
			Result.force (1000, "perthousand")
			Result.force (500, "questiondown")
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
			Result.force (300, "ordfeminine")
			Result.force (667, "Lslash")
			Result.force (778, "Oslash")
			Result.force (1000, "OE")
			Result.force (330, "ordmasculine")
			Result.force (722, "ae")
			Result.force (278, "dotlessi")
			Result.force (278, "lslash")
			Result.force (500, "oslash")
			Result.force (722, "oe")
			Result.force (556, "germandbls")
			Result.force (389, "Idieresis")
			Result.force (444, "eacute")
			Result.force (500, "abreve")
			Result.force (556, "uhungarumlaut")
			Result.force (444, "ecaron")
			Result.force (722, "Ydieresis")
			Result.force (570, "divide")
			Result.force (722, "Yacute")
			Result.force (722, "Acircumflex")
			Result.force (500, "aacute")
			Result.force (722, "Ucircumflex")
			Result.force (500, "yacute")
			Result.force (389, "scommaaccent")
			Result.force (444, "ecircumflex")
			Result.force (722, "Uring")
			Result.force (722, "Udieresis")
			Result.force (500, "aogonek")
			Result.force (722, "Uacute")
			Result.force (556, "uogonek")
			Result.force (667, "Edieresis")
			Result.force (722, "Dcroat")
			Result.force (250, "commaaccent")
			Result.force (747, "copyright")
			Result.force (667, "Emacron")
			Result.force (444, "ccaron")
			Result.force (500, "aring")
			Result.force (722, "Ncommaaccent")
			Result.force (278, "lacute")
			Result.force (500, "agrave")
			Result.force (667, "Tcommaaccent")
			Result.force (722, "Cacute")
			Result.force (500, "atilde")
			Result.force (667, "Edotaccent")
			Result.force (389, "scaron")
			Result.force (389, "scedilla")
			Result.force (278, "iacute")
			Result.force (494, "lozenge")
			Result.force (722, "Rcaron")
			Result.force (778, "Gcommaaccent")
			Result.force (556, "ucircumflex")
			Result.force (500, "acircumflex")
			Result.force (722, "Amacron")
			Result.force (444, "rcaron")
			Result.force (444, "ccedilla")
			Result.force (667, "Zdotaccent")
			Result.force (611, "Thorn")
			Result.force (778, "Omacron")
			Result.force (722, "Racute")
			Result.force (556, "Sacute")
			Result.force (672, "dcaron")
			Result.force (722, "Umacron")
			Result.force (556, "uring")
			Result.force (300, "threesuperior")
			Result.force (778, "Ograve")
			Result.force (722, "Agrave")
			Result.force (722, "Abreve")
			Result.force (570, "multiply")
			Result.force (556, "uacute")
			Result.force (667, "Tcaron")
			Result.force (494, "partialdiff")
			Result.force (500, "ydieresis")
			Result.force (722, "Nacute")
			Result.force (278, "icircumflex")
			Result.force (667, "Ecircumflex")
			Result.force (500, "adieresis")
			Result.force (444, "edieresis")
			Result.force (444, "cacute")
			Result.force (556, "nacute")
			Result.force (556, "umacron")
			Result.force (722, "Ncaron")
			Result.force (389, "Iacute")
			Result.force (570, "plusminus")
			Result.force (220, "brokenbar")
			Result.force (747, "registered")
			Result.force (778, "Gbreve")
			Result.force (389, "Idotaccent")
			Result.force (600, "summation")
			Result.force (667, "Egrave")
			Result.force (444, "racute")
			Result.force (500, "omacron")
			Result.force (667, "Zacute")
			Result.force (667, "Zcaron")
			Result.force (549, "greaterequal")
			Result.force (722, "Eth")
			Result.force (722, "Ccedilla")
			Result.force (278, "lcommaaccent")
			Result.force (416, "tcaron")
			Result.force (444, "eogonek")
			Result.force (722, "Uogonek")
			Result.force (722, "Aacute")
			Result.force (722, "Adieresis")
			Result.force (444, "egrave")
			Result.force (444, "zacute")
			Result.force (278, "iogonek")
			Result.force (778, "Oacute")
			Result.force (500, "oacute")
			Result.force (500, "amacron")
			Result.force (389, "sacute")
			Result.force (278, "idieresis")
			Result.force (778, "Ocircumflex")
			Result.force (722, "Ugrave")
			Result.force (612, "Delta")
			Result.force (556, "thorn")
			Result.force (300, "twosuperior")
			Result.force (778, "Odieresis")
			Result.force (556, "mu")
			Result.force (278, "igrave")
			Result.force (500, "ohungarumlaut")
			Result.force (667, "Eogonek")
			Result.force (556, "dcroat")
			Result.force (750, "threequarters")
			Result.force (556, "Scedilla")
			Result.force (394, "lcaron")
			Result.force (778, "Kcommaaccent")
			Result.force (667, "Lacute")
			Result.force (1000, "trademark")
			Result.force (444, "edotaccent")
			Result.force (389, "Igrave")
			Result.force (389, "Imacron")
			Result.force (667, "Lcaron")
			Result.force (750, "onehalf")
			Result.force (549, "lessequal")
			Result.force (500, "ocircumflex")
			Result.force (556, "ntilde")
			Result.force (722, "Uhungarumlaut")
			Result.force (667, "Eacute")
			Result.force (444, "emacron")
			Result.force (500, "gbreve")
			Result.force (750, "onequarter")
			Result.force (556, "Scaron")
			Result.force (556, "Scommaaccent")
			Result.force (778, "Ohungarumlaut")
			Result.force (400, "degree")
			Result.force (500, "ograve")
			Result.force (722, "Ccaron")
			Result.force (556, "ugrave")
			Result.force (549, "radical")
			Result.force (722, "Dcaron")
			Result.force (444, "rcommaaccent")
			Result.force (722, "Ntilde")
			Result.force (500, "otilde")
			Result.force (722, "Rcommaaccent")
			Result.force (667, "Lcommaaccent")
			Result.force (722, "Atilde")
			Result.force (722, "Aogonek")
			Result.force (722, "Aring")
			Result.force (778, "Otilde")
			Result.force (444, "zdotaccent")
			Result.force (667, "Ecaron")
			Result.force (389, "Iogonek")
			Result.force (556, "kcommaaccent")
			Result.force (570, "minus")
			Result.force (389, "Icircumflex")
			Result.force (556, "ncaron")
			Result.force (333, "tcommaaccent")
			Result.force (570, "logicalnot")
			Result.force (500, "odieresis")
			Result.force (556, "udieresis")
			Result.force (549, "notequal")
			Result.force (500, "gcommaaccent")
			Result.force (500, "eth")
			Result.force (444, "zcaron")
			Result.force (556, "ncommaaccent")
			Result.force (300, "onesuperior")
			Result.force (278, "imacron")
			Result.force (500, "Euro")
		end

end
