indexing
	description: "Courier-BoldOblique font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_COURIER_BOLDOBLIQUE_FONT

inherit
	PDF_ADOBE14_FONT

create
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Courier-BoldOblique")
		end

	full_name : STRING is
		do
			Result := "Courier Bold Oblique"
		end

	family_name : STRING is
		do
			Result := "Courier"
		end

	weight : STRING is
		do
			Result := "Bold"
		end

	italic_angle : INTEGER is
		do
			Result := -12
		end

	is_fixed_pitch : BOOLEAN is
		do
			Result := True
		end

	character_set : STRING is
		do
			Result := "ExtendedRoman"
		end

	font_b_box : PDF_RECTANGLE is
		do
			create Result.set (-57,-250,869,801)
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
			Result := 562
		end

	x_height : INTEGER is
		do
			Result := 439
		end

	ascender : INTEGER is
		do
			Result := 629
		end

	descender : INTEGER is
		do
			Result := -157
		end

	std_hw : INTEGER is
		do
			Result := 84
		end

	std_vw : INTEGER is
		do
			Result := 106
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (315)
			Result.force (600, "space")
			Result.force (600, "exclam")
			Result.force (600, "quotedbl")
			Result.force (600, "numbersign")
			Result.force (600, "dollar")
			Result.force (600, "percent")
			Result.force (600, "ampersand")
			Result.force (600, "quoteright")
			Result.force (600, "parenleft")
			Result.force (600, "parenright")
			Result.force (600, "asterisk")
			Result.force (600, "plus")
			Result.force (600, "comma")
			Result.force (600, "hyphen")
			Result.force (600, "period")
			Result.force (600, "slash")
			Result.force (600, "zero")
			Result.force (600, "one")
			Result.force (600, "two")
			Result.force (600, "three")
			Result.force (600, "four")
			Result.force (600, "five")
			Result.force (600, "six")
			Result.force (600, "seven")
			Result.force (600, "eight")
			Result.force (600, "nine")
			Result.force (600, "colon")
			Result.force (600, "semicolon")
			Result.force (600, "less")
			Result.force (600, "equal")
			Result.force (600, "greater")
			Result.force (600, "question")
			Result.force (600, "at")
			Result.force (600, "A")
			Result.force (600, "B")
			Result.force (600, "C")
			Result.force (600, "D")
			Result.force (600, "E")
			Result.force (600, "F")
			Result.force (600, "G")
			Result.force (600, "H")
			Result.force (600, "I")
			Result.force (600, "J")
			Result.force (600, "K")
			Result.force (600, "L")
			Result.force (600, "M")
			Result.force (600, "N")
			Result.force (600, "O")
			Result.force (600, "P")
			Result.force (600, "Q")
			Result.force (600, "R")
			Result.force (600, "S")
			Result.force (600, "T")
			Result.force (600, "U")
			Result.force (600, "V")
			Result.force (600, "W")
			Result.force (600, "X")
			Result.force (600, "Y")
			Result.force (600, "Z")
			Result.force (600, "bracketleft")
			Result.force (600, "backslash")
			Result.force (600, "bracketright")
			Result.force (600, "asciicircum")
			Result.force (600, "underscore")
			Result.force (600, "quoteleft")
			Result.force (600, "a")
			Result.force (600, "b")
			Result.force (600, "c")
			Result.force (600, "d")
			Result.force (600, "e")
			Result.force (600, "f")
			Result.force (600, "g")
			Result.force (600, "h")
			Result.force (600, "i")
			Result.force (600, "j")
			Result.force (600, "k")
			Result.force (600, "l")
			Result.force (600, "m")
			Result.force (600, "n")
			Result.force (600, "o")
			Result.force (600, "p")
			Result.force (600, "q")
			Result.force (600, "r")
			Result.force (600, "s")
			Result.force (600, "t")
			Result.force (600, "u")
			Result.force (600, "v")
			Result.force (600, "w")
			Result.force (600, "x")
			Result.force (600, "y")
			Result.force (600, "z")
			Result.force (600, "braceleft")
			Result.force (600, "bar")
			Result.force (600, "braceright")
			Result.force (600, "asciitilde")
			Result.force (600, "exclamdown")
			Result.force (600, "cent")
			Result.force (600, "sterling")
			Result.force (600, "fraction")
			Result.force (600, "yen")
			Result.force (600, "florin")
			Result.force (600, "section")
			Result.force (600, "currency")
			Result.force (600, "quotesingle")
			Result.force (600, "quotedblleft")
			Result.force (600, "guillemotleft")
			Result.force (600, "guilsinglleft")
			Result.force (600, "guilsinglright")
			Result.force (600, "fi")
			Result.force (600, "fl")
			Result.force (600, "endash")
			Result.force (600, "dagger")
			Result.force (600, "daggerdbl")
			Result.force (600, "periodcentered")
			Result.force (600, "paragraph")
			Result.force (600, "bullet")
			Result.force (600, "quotesinglbase")
			Result.force (600, "quotedblbase")
			Result.force (600, "quotedblright")
			Result.force (600, "guillemotright")
			Result.force (600, "ellipsis")
			Result.force (600, "perthousand")
			Result.force (600, "questiondown")
			Result.force (600, "grave")
			Result.force (600, "acute")
			Result.force (600, "circumflex")
			Result.force (600, "tilde")
			Result.force (600, "macron")
			Result.force (600, "breve")
			Result.force (600, "dotaccent")
			Result.force (600, "dieresis")
			Result.force (600, "ring")
			Result.force (600, "cedilla")
			Result.force (600, "hungarumlaut")
			Result.force (600, "ogonek")
			Result.force (600, "caron")
			Result.force (600, "emdash")
			Result.force (600, "AE")
			Result.force (600, "ordfeminine")
			Result.force (600, "Lslash")
			Result.force (600, "Oslash")
			Result.force (600, "OE")
			Result.force (600, "ordmasculine")
			Result.force (600, "ae")
			Result.force (600, "dotlessi")
			Result.force (600, "lslash")
			Result.force (600, "oslash")
			Result.force (600, "oe")
			Result.force (600, "germandbls")
			Result.force (600, "Idieresis")
			Result.force (600, "eacute")
			Result.force (600, "abreve")
			Result.force (600, "uhungarumlaut")
			Result.force (600, "ecaron")
			Result.force (600, "Ydieresis")
			Result.force (600, "divide")
			Result.force (600, "Yacute")
			Result.force (600, "Acircumflex")
			Result.force (600, "aacute")
			Result.force (600, "Ucircumflex")
			Result.force (600, "yacute")
			Result.force (600, "scommaaccent")
			Result.force (600, "ecircumflex")
			Result.force (600, "Uring")
			Result.force (600, "Udieresis")
			Result.force (600, "aogonek")
			Result.force (600, "Uacute")
			Result.force (600, "uogonek")
			Result.force (600, "Edieresis")
			Result.force (600, "Dcroat")
			Result.force (600, "commaaccent")
			Result.force (600, "copyright")
			Result.force (600, "Emacron")
			Result.force (600, "ccaron")
			Result.force (600, "aring")
			Result.force (600, "Ncommaaccent")
			Result.force (600, "lacute")
			Result.force (600, "agrave")
			Result.force (600, "Tcommaaccent")
			Result.force (600, "Cacute")
			Result.force (600, "atilde")
			Result.force (600, "Edotaccent")
			Result.force (600, "scaron")
			Result.force (600, "scedilla")
			Result.force (600, "iacute")
			Result.force (600, "lozenge")
			Result.force (600, "Rcaron")
			Result.force (600, "Gcommaaccent")
			Result.force (600, "ucircumflex")
			Result.force (600, "acircumflex")
			Result.force (600, "Amacron")
			Result.force (600, "rcaron")
			Result.force (600, "ccedilla")
			Result.force (600, "Zdotaccent")
			Result.force (600, "Thorn")
			Result.force (600, "Omacron")
			Result.force (600, "Racute")
			Result.force (600, "Sacute")
			Result.force (600, "dcaron")
			Result.force (600, "Umacron")
			Result.force (600, "uring")
			Result.force (600, "threesuperior")
			Result.force (600, "Ograve")
			Result.force (600, "Agrave")
			Result.force (600, "Abreve")
			Result.force (600, "multiply")
			Result.force (600, "uacute")
			Result.force (600, "Tcaron")
			Result.force (600, "partialdiff")
			Result.force (600, "ydieresis")
			Result.force (600, "Nacute")
			Result.force (600, "icircumflex")
			Result.force (600, "Ecircumflex")
			Result.force (600, "adieresis")
			Result.force (600, "edieresis")
			Result.force (600, "cacute")
			Result.force (600, "nacute")
			Result.force (600, "umacron")
			Result.force (600, "Ncaron")
			Result.force (600, "Iacute")
			Result.force (600, "plusminus")
			Result.force (600, "brokenbar")
			Result.force (600, "registered")
			Result.force (600, "Gbreve")
			Result.force (600, "Idotaccent")
			Result.force (600, "summation")
			Result.force (600, "Egrave")
			Result.force (600, "racute")
			Result.force (600, "omacron")
			Result.force (600, "Zacute")
			Result.force (600, "Zcaron")
			Result.force (600, "greaterequal")
			Result.force (600, "Eth")
			Result.force (600, "Ccedilla")
			Result.force (600, "lcommaaccent")
			Result.force (600, "tcaron")
			Result.force (600, "eogonek")
			Result.force (600, "Uogonek")
			Result.force (600, "Aacute")
			Result.force (600, "Adieresis")
			Result.force (600, "egrave")
			Result.force (600, "zacute")
			Result.force (600, "iogonek")
			Result.force (600, "Oacute")
			Result.force (600, "oacute")
			Result.force (600, "amacron")
			Result.force (600, "sacute")
			Result.force (600, "idieresis")
			Result.force (600, "Ocircumflex")
			Result.force (600, "Ugrave")
			Result.force (600, "Delta")
			Result.force (600, "thorn")
			Result.force (600, "twosuperior")
			Result.force (600, "Odieresis")
			Result.force (600, "mu")
			Result.force (600, "igrave")
			Result.force (600, "ohungarumlaut")
			Result.force (600, "Eogonek")
			Result.force (600, "dcroat")
			Result.force (600, "threequarters")
			Result.force (600, "Scedilla")
			Result.force (600, "lcaron")
			Result.force (600, "Kcommaaccent")
			Result.force (600, "Lacute")
			Result.force (600, "trademark")
			Result.force (600, "edotaccent")
			Result.force (600, "Igrave")
			Result.force (600, "Imacron")
			Result.force (600, "Lcaron")
			Result.force (600, "onehalf")
			Result.force (600, "lessequal")
			Result.force (600, "ocircumflex")
			Result.force (600, "ntilde")
			Result.force (600, "Uhungarumlaut")
			Result.force (600, "Eacute")
			Result.force (600, "emacron")
			Result.force (600, "gbreve")
			Result.force (600, "onequarter")
			Result.force (600, "Scaron")
			Result.force (600, "Scommaaccent")
			Result.force (600, "Ohungarumlaut")
			Result.force (600, "degree")
			Result.force (600, "ograve")
			Result.force (600, "Ccaron")
			Result.force (600, "ugrave")
			Result.force (600, "radical")
			Result.force (600, "Dcaron")
			Result.force (600, "rcommaaccent")
			Result.force (600, "Ntilde")
			Result.force (600, "otilde")
			Result.force (600, "Rcommaaccent")
			Result.force (600, "Lcommaaccent")
			Result.force (600, "Atilde")
			Result.force (600, "Aogonek")
			Result.force (600, "Aring")
			Result.force (600, "Otilde")
			Result.force (600, "zdotaccent")
			Result.force (600, "Ecaron")
			Result.force (600, "Iogonek")
			Result.force (600, "kcommaaccent")
			Result.force (600, "minus")
			Result.force (600, "Icircumflex")
			Result.force (600, "ncaron")
			Result.force (600, "tcommaaccent")
			Result.force (600, "logicalnot")
			Result.force (600, "odieresis")
			Result.force (600, "udieresis")
			Result.force (600, "notequal")
			Result.force (600, "gcommaaccent")
			Result.force (600, "eth")
			Result.force (600, "zcaron")
			Result.force (600, "ncommaaccent")
			Result.force (600, "onesuperior")
			Result.force (600, "imacron")
			Result.force (600, "Euro")
		end

end
