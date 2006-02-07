indexing
	description: "Times-Italic font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_TIMES_ITALIC_FONT

inherit
	PDF_ADOBE14_FONT

creation
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Times-Italic")
		end

	full_name : STRING is
		do
			Result := "Times Italic"
		end

	family_name : STRING is
		do
			Result := "Times"
		end

	weight : STRING is
		do
			Result := "Medium"
		end

	italic_angle : INTEGER is
		do
			Result := -15
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
			create Result.set (-169,-217,1010,883)
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
			Result := 653
		end

	x_height : INTEGER is
		do
			Result := 441
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
			Result := 32
		end

	std_vw : INTEGER is
		do
			Result := 76
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (315)
			Result.force (250, "space")
			Result.force (333, "exclam")
			Result.force (420, "quotedbl")
			Result.force (500, "numbersign")
			Result.force (500, "dollar")
			Result.force (833, "percent")
			Result.force (778, "ampersand")
			Result.force (333, "quoteright")
			Result.force (333, "parenleft")
			Result.force (333, "parenright")
			Result.force (500, "asterisk")
			Result.force (675, "plus")
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
			Result.force (675, "less")
			Result.force (675, "equal")
			Result.force (675, "greater")
			Result.force (500, "question")
			Result.force (920, "at")
			Result.force (611, "A")
			Result.force (611, "B")
			Result.force (667, "C")
			Result.force (722, "D")
			Result.force (611, "E")
			Result.force (611, "F")
			Result.force (722, "G")
			Result.force (722, "H")
			Result.force (333, "I")
			Result.force (444, "J")
			Result.force (667, "K")
			Result.force (556, "L")
			Result.force (833, "M")
			Result.force (667, "N")
			Result.force (722, "O")
			Result.force (611, "P")
			Result.force (722, "Q")
			Result.force (611, "R")
			Result.force (500, "S")
			Result.force (556, "T")
			Result.force (722, "U")
			Result.force (611, "V")
			Result.force (833, "W")
			Result.force (611, "X")
			Result.force (556, "Y")
			Result.force (556, "Z")
			Result.force (389, "bracketleft")
			Result.force (278, "backslash")
			Result.force (389, "bracketright")
			Result.force (422, "asciicircum")
			Result.force (500, "underscore")
			Result.force (333, "quoteleft")
			Result.force (500, "a")
			Result.force (500, "b")
			Result.force (444, "c")
			Result.force (500, "d")
			Result.force (444, "e")
			Result.force (278, "f")
			Result.force (500, "g")
			Result.force (500, "h")
			Result.force (278, "i")
			Result.force (278, "j")
			Result.force (444, "k")
			Result.force (278, "l")
			Result.force (722, "m")
			Result.force (500, "n")
			Result.force (500, "o")
			Result.force (500, "p")
			Result.force (500, "q")
			Result.force (389, "r")
			Result.force (389, "s")
			Result.force (278, "t")
			Result.force (500, "u")
			Result.force (444, "v")
			Result.force (667, "w")
			Result.force (444, "x")
			Result.force (444, "y")
			Result.force (389, "z")
			Result.force (400, "braceleft")
			Result.force (275, "bar")
			Result.force (400, "braceright")
			Result.force (541, "asciitilde")
			Result.force (389, "exclamdown")
			Result.force (500, "cent")
			Result.force (500, "sterling")
			Result.force (167, "fraction")
			Result.force (500, "yen")
			Result.force (500, "florin")
			Result.force (500, "section")
			Result.force (500, "currency")
			Result.force (214, "quotesingle")
			Result.force (556, "quotedblleft")
			Result.force (500, "guillemotleft")
			Result.force (333, "guilsinglleft")
			Result.force (333, "guilsinglright")
			Result.force (500, "fi")
			Result.force (500, "fl")
			Result.force (500, "endash")
			Result.force (500, "dagger")
			Result.force (500, "daggerdbl")
			Result.force (250, "periodcentered")
			Result.force (523, "paragraph")
			Result.force (350, "bullet")
			Result.force (333, "quotesinglbase")
			Result.force (556, "quotedblbase")
			Result.force (556, "quotedblright")
			Result.force (500, "guillemotright")
			Result.force (889, "ellipsis")
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
			Result.force (889, "emdash")
			Result.force (889, "AE")
			Result.force (276, "ordfeminine")
			Result.force (556, "Lslash")
			Result.force (722, "Oslash")
			Result.force (944, "OE")
			Result.force (310, "ordmasculine")
			Result.force (667, "ae")
			Result.force (278, "dotlessi")
			Result.force (278, "lslash")
			Result.force (500, "oslash")
			Result.force (667, "oe")
			Result.force (500, "germandbls")
			Result.force (333, "Idieresis")
			Result.force (444, "eacute")
			Result.force (500, "abreve")
			Result.force (500, "uhungarumlaut")
			Result.force (444, "ecaron")
			Result.force (556, "Ydieresis")
			Result.force (675, "divide")
			Result.force (556, "Yacute")
			Result.force (611, "Acircumflex")
			Result.force (500, "aacute")
			Result.force (722, "Ucircumflex")
			Result.force (444, "yacute")
			Result.force (389, "scommaaccent")
			Result.force (444, "ecircumflex")
			Result.force (722, "Uring")
			Result.force (722, "Udieresis")
			Result.force (500, "aogonek")
			Result.force (722, "Uacute")
			Result.force (500, "uogonek")
			Result.force (611, "Edieresis")
			Result.force (722, "Dcroat")
			Result.force (250, "commaaccent")
			Result.force (760, "copyright")
			Result.force (611, "Emacron")
			Result.force (444, "ccaron")
			Result.force (500, "aring")
			Result.force (667, "Ncommaaccent")
			Result.force (278, "lacute")
			Result.force (500, "agrave")
			Result.force (556, "Tcommaaccent")
			Result.force (667, "Cacute")
			Result.force (500, "atilde")
			Result.force (611, "Edotaccent")
			Result.force (389, "scaron")
			Result.force (389, "scedilla")
			Result.force (278, "iacute")
			Result.force (471, "lozenge")
			Result.force (611, "Rcaron")
			Result.force (722, "Gcommaaccent")
			Result.force (500, "ucircumflex")
			Result.force (500, "acircumflex")
			Result.force (611, "Amacron")
			Result.force (389, "rcaron")
			Result.force (444, "ccedilla")
			Result.force (556, "Zdotaccent")
			Result.force (611, "Thorn")
			Result.force (722, "Omacron")
			Result.force (611, "Racute")
			Result.force (500, "Sacute")
			Result.force (544, "dcaron")
			Result.force (722, "Umacron")
			Result.force (500, "uring")
			Result.force (300, "threesuperior")
			Result.force (722, "Ograve")
			Result.force (611, "Agrave")
			Result.force (611, "Abreve")
			Result.force (675, "multiply")
			Result.force (500, "uacute")
			Result.force (556, "Tcaron")
			Result.force (476, "partialdiff")
			Result.force (444, "ydieresis")
			Result.force (667, "Nacute")
			Result.force (278, "icircumflex")
			Result.force (611, "Ecircumflex")
			Result.force (500, "adieresis")
			Result.force (444, "edieresis")
			Result.force (444, "cacute")
			Result.force (500, "nacute")
			Result.force (500, "umacron")
			Result.force (667, "Ncaron")
			Result.force (333, "Iacute")
			Result.force (675, "plusminus")
			Result.force (275, "brokenbar")
			Result.force (760, "registered")
			Result.force (722, "Gbreve")
			Result.force (333, "Idotaccent")
			Result.force (600, "summation")
			Result.force (611, "Egrave")
			Result.force (389, "racute")
			Result.force (500, "omacron")
			Result.force (556, "Zacute")
			Result.force (556, "Zcaron")
			Result.force (549, "greaterequal")
			Result.force (722, "Eth")
			Result.force (667, "Ccedilla")
			Result.force (278, "lcommaaccent")
			Result.force (300, "tcaron")
			Result.force (444, "eogonek")
			Result.force (722, "Uogonek")
			Result.force (611, "Aacute")
			Result.force (611, "Adieresis")
			Result.force (444, "egrave")
			Result.force (389, "zacute")
			Result.force (278, "iogonek")
			Result.force (722, "Oacute")
			Result.force (500, "oacute")
			Result.force (500, "amacron")
			Result.force (389, "sacute")
			Result.force (278, "idieresis")
			Result.force (722, "Ocircumflex")
			Result.force (722, "Ugrave")
			Result.force (612, "Delta")
			Result.force (500, "thorn")
			Result.force (300, "twosuperior")
			Result.force (722, "Odieresis")
			Result.force (500, "mu")
			Result.force (278, "igrave")
			Result.force (500, "ohungarumlaut")
			Result.force (611, "Eogonek")
			Result.force (500, "dcroat")
			Result.force (750, "threequarters")
			Result.force (500, "Scedilla")
			Result.force (300, "lcaron")
			Result.force (667, "Kcommaaccent")
			Result.force (556, "Lacute")
			Result.force (980, "trademark")
			Result.force (444, "edotaccent")
			Result.force (333, "Igrave")
			Result.force (333, "Imacron")
			Result.force (611, "Lcaron")
			Result.force (750, "onehalf")
			Result.force (549, "lessequal")
			Result.force (500, "ocircumflex")
			Result.force (500, "ntilde")
			Result.force (722, "Uhungarumlaut")
			Result.force (611, "Eacute")
			Result.force (444, "emacron")
			Result.force (500, "gbreve")
			Result.force (750, "onequarter")
			Result.force (500, "Scaron")
			Result.force (500, "Scommaaccent")
			Result.force (722, "Ohungarumlaut")
			Result.force (400, "degree")
			Result.force (500, "ograve")
			Result.force (667, "Ccaron")
			Result.force (500, "ugrave")
			Result.force (453, "radical")
			Result.force (722, "Dcaron")
			Result.force (389, "rcommaaccent")
			Result.force (667, "Ntilde")
			Result.force (500, "otilde")
			Result.force (611, "Rcommaaccent")
			Result.force (556, "Lcommaaccent")
			Result.force (611, "Atilde")
			Result.force (611, "Aogonek")
			Result.force (611, "Aring")
			Result.force (722, "Otilde")
			Result.force (389, "zdotaccent")
			Result.force (611, "Ecaron")
			Result.force (333, "Iogonek")
			Result.force (444, "kcommaaccent")
			Result.force (675, "minus")
			Result.force (333, "Icircumflex")
			Result.force (500, "ncaron")
			Result.force (278, "tcommaaccent")
			Result.force (675, "logicalnot")
			Result.force (500, "odieresis")
			Result.force (500, "udieresis")
			Result.force (549, "notequal")
			Result.force (500, "gcommaaccent")
			Result.force (500, "eth")
			Result.force (389, "zcaron")
			Result.force (500, "ncommaaccent")
			Result.force (300, "onesuperior")
			Result.force (278, "imacron")
			Result.force (500, "Euro")
		end

end
