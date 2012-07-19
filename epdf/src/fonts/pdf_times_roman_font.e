indexing
	description: "Times-Roman font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_TIMES_ROMAN_FONT

inherit
	PDF_ADOBE14_FONT

create
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Times-Roman")
		end

	full_name : STRING is
		do
			Result := "Times Roman"
		end

	family_name : STRING is
		do
			Result := "Times"
		end

	weight : STRING is
		do
			Result := "Roman"
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
			create Result.set (-168,-218,1000,898)
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
			Result := 662
		end

	x_height : INTEGER is
		do
			Result := 450
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
			Result := 28
		end

	std_vw : INTEGER is
		do
			Result := 84
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (315)
			Result.force (250, "space")
			Result.force (333, "exclam")
			Result.force (408, "quotedbl")
			Result.force (500, "numbersign")
			Result.force (500, "dollar")
			Result.force (833, "percent")
			Result.force (778, "ampersand")
			Result.force (333, "quoteright")
			Result.force (333, "parenleft")
			Result.force (333, "parenright")
			Result.force (500, "asterisk")
			Result.force (564, "plus")
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
			Result.force (278, "colon")
			Result.force (278, "semicolon")
			Result.force (564, "less")
			Result.force (564, "equal")
			Result.force (564, "greater")
			Result.force (444, "question")
			Result.force (921, "at")
			Result.force (722, "A")
			Result.force (667, "B")
			Result.force (667, "C")
			Result.force (722, "D")
			Result.force (611, "E")
			Result.force (556, "F")
			Result.force (722, "G")
			Result.force (722, "H")
			Result.force (333, "I")
			Result.force (389, "J")
			Result.force (722, "K")
			Result.force (611, "L")
			Result.force (889, "M")
			Result.force (722, "N")
			Result.force (722, "O")
			Result.force (556, "P")
			Result.force (722, "Q")
			Result.force (667, "R")
			Result.force (556, "S")
			Result.force (611, "T")
			Result.force (722, "U")
			Result.force (722, "V")
			Result.force (944, "W")
			Result.force (722, "X")
			Result.force (722, "Y")
			Result.force (611, "Z")
			Result.force (333, "bracketleft")
			Result.force (278, "backslash")
			Result.force (333, "bracketright")
			Result.force (469, "asciicircum")
			Result.force (500, "underscore")
			Result.force (333, "quoteleft")
			Result.force (444, "a")
			Result.force (500, "b")
			Result.force (444, "c")
			Result.force (500, "d")
			Result.force (444, "e")
			Result.force (333, "f")
			Result.force (500, "g")
			Result.force (500, "h")
			Result.force (278, "i")
			Result.force (278, "j")
			Result.force (500, "k")
			Result.force (278, "l")
			Result.force (778, "m")
			Result.force (500, "n")
			Result.force (500, "o")
			Result.force (500, "p")
			Result.force (500, "q")
			Result.force (333, "r")
			Result.force (389, "s")
			Result.force (278, "t")
			Result.force (500, "u")
			Result.force (500, "v")
			Result.force (722, "w")
			Result.force (500, "x")
			Result.force (500, "y")
			Result.force (444, "z")
			Result.force (480, "braceleft")
			Result.force (200, "bar")
			Result.force (480, "braceright")
			Result.force (541, "asciitilde")
			Result.force (333, "exclamdown")
			Result.force (500, "cent")
			Result.force (500, "sterling")
			Result.force (167, "fraction")
			Result.force (500, "yen")
			Result.force (500, "florin")
			Result.force (500, "section")
			Result.force (500, "currency")
			Result.force (180, "quotesingle")
			Result.force (444, "quotedblleft")
			Result.force (500, "guillemotleft")
			Result.force (333, "guilsinglleft")
			Result.force (333, "guilsinglright")
			Result.force (556, "fi")
			Result.force (556, "fl")
			Result.force (500, "endash")
			Result.force (500, "dagger")
			Result.force (500, "daggerdbl")
			Result.force (250, "periodcentered")
			Result.force (453, "paragraph")
			Result.force (350, "bullet")
			Result.force (333, "quotesinglbase")
			Result.force (444, "quotedblbase")
			Result.force (444, "quotedblright")
			Result.force (500, "guillemotright")
			Result.force (1000, "ellipsis")
			Result.force (1000, "perthousand")
			Result.force (444, "questiondown")
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
			Result.force (889, "AE")
			Result.force (276, "ordfeminine")
			Result.force (611, "Lslash")
			Result.force (722, "Oslash")
			Result.force (889, "OE")
			Result.force (310, "ordmasculine")
			Result.force (667, "ae")
			Result.force (278, "dotlessi")
			Result.force (278, "lslash")
			Result.force (500, "oslash")
			Result.force (722, "oe")
			Result.force (500, "germandbls")
			Result.force (333, "Idieresis")
			Result.force (444, "eacute")
			Result.force (444, "abreve")
			Result.force (500, "uhungarumlaut")
			Result.force (444, "ecaron")
			Result.force (722, "Ydieresis")
			Result.force (564, "divide")
			Result.force (722, "Yacute")
			Result.force (722, "Acircumflex")
			Result.force (444, "aacute")
			Result.force (722, "Ucircumflex")
			Result.force (500, "yacute")
			Result.force (389, "scommaaccent")
			Result.force (444, "ecircumflex")
			Result.force (722, "Uring")
			Result.force (722, "Udieresis")
			Result.force (444, "aogonek")
			Result.force (722, "Uacute")
			Result.force (500, "uogonek")
			Result.force (611, "Edieresis")
			Result.force (722, "Dcroat")
			Result.force (250, "commaaccent")
			Result.force (760, "copyright")
			Result.force (611, "Emacron")
			Result.force (444, "ccaron")
			Result.force (444, "aring")
			Result.force (722, "Ncommaaccent")
			Result.force (278, "lacute")
			Result.force (444, "agrave")
			Result.force (611, "Tcommaaccent")
			Result.force (667, "Cacute")
			Result.force (444, "atilde")
			Result.force (611, "Edotaccent")
			Result.force (389, "scaron")
			Result.force (389, "scedilla")
			Result.force (278, "iacute")
			Result.force (471, "lozenge")
			Result.force (667, "Rcaron")
			Result.force (722, "Gcommaaccent")
			Result.force (500, "ucircumflex")
			Result.force (444, "acircumflex")
			Result.force (722, "Amacron")
			Result.force (333, "rcaron")
			Result.force (444, "ccedilla")
			Result.force (611, "Zdotaccent")
			Result.force (556, "Thorn")
			Result.force (722, "Omacron")
			Result.force (667, "Racute")
			Result.force (556, "Sacute")
			Result.force (588, "dcaron")
			Result.force (722, "Umacron")
			Result.force (500, "uring")
			Result.force (300, "threesuperior")
			Result.force (722, "Ograve")
			Result.force (722, "Agrave")
			Result.force (722, "Abreve")
			Result.force (564, "multiply")
			Result.force (500, "uacute")
			Result.force (611, "Tcaron")
			Result.force (476, "partialdiff")
			Result.force (500, "ydieresis")
			Result.force (722, "Nacute")
			Result.force (278, "icircumflex")
			Result.force (611, "Ecircumflex")
			Result.force (444, "adieresis")
			Result.force (444, "edieresis")
			Result.force (444, "cacute")
			Result.force (500, "nacute")
			Result.force (500, "umacron")
			Result.force (722, "Ncaron")
			Result.force (333, "Iacute")
			Result.force (564, "plusminus")
			Result.force (200, "brokenbar")
			Result.force (760, "registered")
			Result.force (722, "Gbreve")
			Result.force (333, "Idotaccent")
			Result.force (600, "summation")
			Result.force (611, "Egrave")
			Result.force (333, "racute")
			Result.force (500, "omacron")
			Result.force (611, "Zacute")
			Result.force (611, "Zcaron")
			Result.force (549, "greaterequal")
			Result.force (722, "Eth")
			Result.force (667, "Ccedilla")
			Result.force (278, "lcommaaccent")
			Result.force (326, "tcaron")
			Result.force (444, "eogonek")
			Result.force (722, "Uogonek")
			Result.force (722, "Aacute")
			Result.force (722, "Adieresis")
			Result.force (444, "egrave")
			Result.force (444, "zacute")
			Result.force (278, "iogonek")
			Result.force (722, "Oacute")
			Result.force (500, "oacute")
			Result.force (444, "amacron")
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
			Result.force (556, "Scedilla")
			Result.force (344, "lcaron")
			Result.force (722, "Kcommaaccent")
			Result.force (611, "Lacute")
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
			Result.force (556, "Scaron")
			Result.force (556, "Scommaaccent")
			Result.force (722, "Ohungarumlaut")
			Result.force (400, "degree")
			Result.force (500, "ograve")
			Result.force (667, "Ccaron")
			Result.force (500, "ugrave")
			Result.force (453, "radical")
			Result.force (722, "Dcaron")
			Result.force (333, "rcommaaccent")
			Result.force (722, "Ntilde")
			Result.force (500, "otilde")
			Result.force (667, "Rcommaaccent")
			Result.force (611, "Lcommaaccent")
			Result.force (722, "Atilde")
			Result.force (722, "Aogonek")
			Result.force (722, "Aring")
			Result.force (722, "Otilde")
			Result.force (444, "zdotaccent")
			Result.force (611, "Ecaron")
			Result.force (333, "Iogonek")
			Result.force (500, "kcommaaccent")
			Result.force (564, "minus")
			Result.force (333, "Icircumflex")
			Result.force (500, "ncaron")
			Result.force (278, "tcommaaccent")
			Result.force (564, "logicalnot")
			Result.force (500, "odieresis")
			Result.force (500, "udieresis")
			Result.force (549, "notequal")
			Result.force (500, "gcommaaccent")
			Result.force (500, "eth")
			Result.force (444, "zcaron")
			Result.force (500, "ncommaaccent")
			Result.force (300, "onesuperior")
			Result.force (278, "imacron")
			Result.force (500, "Euro")
		end

end
