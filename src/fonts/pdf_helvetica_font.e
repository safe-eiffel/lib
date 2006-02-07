indexing
	description: "Helvetica font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_HELVETICA_FONT

inherit
	PDF_ADOBE14_FONT

creation
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Helvetica")
		end

	full_name : STRING is
		do
			Result := "Helvetica"
		end

	family_name : STRING is
		do
			Result := "Helvetica"
		end

	weight : STRING is
		do
			Result := "Medium"
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
			create Result.set (-166,-225,1000,931)
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
			Result := 523
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
			Result := 76
		end

	std_vw : INTEGER is
		do
			Result := 88
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (315)
			Result.force (278, "space")
			Result.force (278, "exclam")
			Result.force (355, "quotedbl")
			Result.force (556, "numbersign")
			Result.force (556, "dollar")
			Result.force (889, "percent")
			Result.force (667, "ampersand")
			Result.force (222, "quoteright")
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
			Result.force (278, "colon")
			Result.force (278, "semicolon")
			Result.force (584, "less")
			Result.force (584, "equal")
			Result.force (584, "greater")
			Result.force (556, "question")
			Result.force (1015, "at")
			Result.force (667, "A")
			Result.force (667, "B")
			Result.force (722, "C")
			Result.force (722, "D")
			Result.force (667, "E")
			Result.force (611, "F")
			Result.force (778, "G")
			Result.force (722, "H")
			Result.force (278, "I")
			Result.force (500, "J")
			Result.force (667, "K")
			Result.force (556, "L")
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
			Result.force (278, "bracketleft")
			Result.force (278, "backslash")
			Result.force (278, "bracketright")
			Result.force (469, "asciicircum")
			Result.force (556, "underscore")
			Result.force (222, "quoteleft")
			Result.force (556, "a")
			Result.force (556, "b")
			Result.force (500, "c")
			Result.force (556, "d")
			Result.force (556, "e")
			Result.force (278, "f")
			Result.force (556, "g")
			Result.force (556, "h")
			Result.force (222, "i")
			Result.force (222, "j")
			Result.force (500, "k")
			Result.force (222, "l")
			Result.force (833, "m")
			Result.force (556, "n")
			Result.force (556, "o")
			Result.force (556, "p")
			Result.force (556, "q")
			Result.force (333, "r")
			Result.force (500, "s")
			Result.force (278, "t")
			Result.force (556, "u")
			Result.force (500, "v")
			Result.force (722, "w")
			Result.force (500, "x")
			Result.force (500, "y")
			Result.force (500, "z")
			Result.force (334, "braceleft")
			Result.force (260, "bar")
			Result.force (334, "braceright")
			Result.force (584, "asciitilde")
			Result.force (333, "exclamdown")
			Result.force (556, "cent")
			Result.force (556, "sterling")
			Result.force (167, "fraction")
			Result.force (556, "yen")
			Result.force (556, "florin")
			Result.force (556, "section")
			Result.force (556, "currency")
			Result.force (191, "quotesingle")
			Result.force (333, "quotedblleft")
			Result.force (556, "guillemotleft")
			Result.force (333, "guilsinglleft")
			Result.force (333, "guilsinglright")
			Result.force (500, "fi")
			Result.force (500, "fl")
			Result.force (556, "endash")
			Result.force (556, "dagger")
			Result.force (556, "daggerdbl")
			Result.force (278, "periodcentered")
			Result.force (537, "paragraph")
			Result.force (350, "bullet")
			Result.force (222, "quotesinglbase")
			Result.force (333, "quotedblbase")
			Result.force (333, "quotedblright")
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
			Result.force (556, "Lslash")
			Result.force (778, "Oslash")
			Result.force (1000, "OE")
			Result.force (365, "ordmasculine")
			Result.force (889, "ae")
			Result.force (278, "dotlessi")
			Result.force (222, "lslash")
			Result.force (611, "oslash")
			Result.force (944, "oe")
			Result.force (611, "germandbls")
			Result.force (278, "Idieresis")
			Result.force (556, "eacute")
			Result.force (556, "abreve")
			Result.force (556, "uhungarumlaut")
			Result.force (556, "ecaron")
			Result.force (667, "Ydieresis")
			Result.force (584, "divide")
			Result.force (667, "Yacute")
			Result.force (667, "Acircumflex")
			Result.force (556, "aacute")
			Result.force (722, "Ucircumflex")
			Result.force (500, "yacute")
			Result.force (500, "scommaaccent")
			Result.force (556, "ecircumflex")
			Result.force (722, "Uring")
			Result.force (722, "Udieresis")
			Result.force (556, "aogonek")
			Result.force (722, "Uacute")
			Result.force (556, "uogonek")
			Result.force (667, "Edieresis")
			Result.force (722, "Dcroat")
			Result.force (250, "commaaccent")
			Result.force (737, "copyright")
			Result.force (667, "Emacron")
			Result.force (500, "ccaron")
			Result.force (556, "aring")
			Result.force (722, "Ncommaaccent")
			Result.force (222, "lacute")
			Result.force (556, "agrave")
			Result.force (611, "Tcommaaccent")
			Result.force (722, "Cacute")
			Result.force (556, "atilde")
			Result.force (667, "Edotaccent")
			Result.force (500, "scaron")
			Result.force (500, "scedilla")
			Result.force (278, "iacute")
			Result.force (471, "lozenge")
			Result.force (722, "Rcaron")
			Result.force (778, "Gcommaaccent")
			Result.force (556, "ucircumflex")
			Result.force (556, "acircumflex")
			Result.force (667, "Amacron")
			Result.force (333, "rcaron")
			Result.force (500, "ccedilla")
			Result.force (611, "Zdotaccent")
			Result.force (667, "Thorn")
			Result.force (778, "Omacron")
			Result.force (722, "Racute")
			Result.force (667, "Sacute")
			Result.force (643, "dcaron")
			Result.force (722, "Umacron")
			Result.force (556, "uring")
			Result.force (333, "threesuperior")
			Result.force (778, "Ograve")
			Result.force (667, "Agrave")
			Result.force (667, "Abreve")
			Result.force (584, "multiply")
			Result.force (556, "uacute")
			Result.force (611, "Tcaron")
			Result.force (476, "partialdiff")
			Result.force (500, "ydieresis")
			Result.force (722, "Nacute")
			Result.force (278, "icircumflex")
			Result.force (667, "Ecircumflex")
			Result.force (556, "adieresis")
			Result.force (556, "edieresis")
			Result.force (500, "cacute")
			Result.force (556, "nacute")
			Result.force (556, "umacron")
			Result.force (722, "Ncaron")
			Result.force (278, "Iacute")
			Result.force (584, "plusminus")
			Result.force (260, "brokenbar")
			Result.force (737, "registered")
			Result.force (778, "Gbreve")
			Result.force (278, "Idotaccent")
			Result.force (600, "summation")
			Result.force (667, "Egrave")
			Result.force (333, "racute")
			Result.force (556, "omacron")
			Result.force (611, "Zacute")
			Result.force (611, "Zcaron")
			Result.force (549, "greaterequal")
			Result.force (722, "Eth")
			Result.force (722, "Ccedilla")
			Result.force (222, "lcommaaccent")
			Result.force (317, "tcaron")
			Result.force (556, "eogonek")
			Result.force (722, "Uogonek")
			Result.force (667, "Aacute")
			Result.force (667, "Adieresis")
			Result.force (556, "egrave")
			Result.force (500, "zacute")
			Result.force (222, "iogonek")
			Result.force (778, "Oacute")
			Result.force (556, "oacute")
			Result.force (556, "amacron")
			Result.force (500, "sacute")
			Result.force (278, "idieresis")
			Result.force (778, "Ocircumflex")
			Result.force (722, "Ugrave")
			Result.force (612, "Delta")
			Result.force (556, "thorn")
			Result.force (333, "twosuperior")
			Result.force (778, "Odieresis")
			Result.force (556, "mu")
			Result.force (278, "igrave")
			Result.force (556, "ohungarumlaut")
			Result.force (667, "Eogonek")
			Result.force (556, "dcroat")
			Result.force (834, "threequarters")
			Result.force (667, "Scedilla")
			Result.force (299, "lcaron")
			Result.force (667, "Kcommaaccent")
			Result.force (556, "Lacute")
			Result.force (1000, "trademark")
			Result.force (556, "edotaccent")
			Result.force (278, "Igrave")
			Result.force (278, "Imacron")
			Result.force (556, "Lcaron")
			Result.force (834, "onehalf")
			Result.force (549, "lessequal")
			Result.force (556, "ocircumflex")
			Result.force (556, "ntilde")
			Result.force (722, "Uhungarumlaut")
			Result.force (667, "Eacute")
			Result.force (556, "emacron")
			Result.force (556, "gbreve")
			Result.force (834, "onequarter")
			Result.force (667, "Scaron")
			Result.force (667, "Scommaaccent")
			Result.force (778, "Ohungarumlaut")
			Result.force (400, "degree")
			Result.force (556, "ograve")
			Result.force (722, "Ccaron")
			Result.force (556, "ugrave")
			Result.force (453, "radical")
			Result.force (722, "Dcaron")
			Result.force (333, "rcommaaccent")
			Result.force (722, "Ntilde")
			Result.force (556, "otilde")
			Result.force (722, "Rcommaaccent")
			Result.force (556, "Lcommaaccent")
			Result.force (667, "Atilde")
			Result.force (667, "Aogonek")
			Result.force (667, "Aring")
			Result.force (778, "Otilde")
			Result.force (500, "zdotaccent")
			Result.force (667, "Ecaron")
			Result.force (278, "Iogonek")
			Result.force (500, "kcommaaccent")
			Result.force (584, "minus")
			Result.force (278, "Icircumflex")
			Result.force (556, "ncaron")
			Result.force (278, "tcommaaccent")
			Result.force (584, "logicalnot")
			Result.force (556, "odieresis")
			Result.force (556, "udieresis")
			Result.force (549, "notequal")
			Result.force (556, "gcommaaccent")
			Result.force (556, "eth")
			Result.force (500, "zcaron")
			Result.force (556, "ncommaaccent")
			Result.force (333, "onesuperior")
			Result.force (278, "imacron")
			Result.force (556, "Euro")
		end

end
