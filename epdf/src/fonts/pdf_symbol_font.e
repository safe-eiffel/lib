indexing
	description: "Symbol font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_SYMBOL_FONT

inherit
	PDF_ADOBE14_FONT

create
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("Symbol")
		end

	full_name : STRING is
		do
			Result := "Symbol"
		end

	family_name : STRING is
		do
			Result := "Symbol"
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
			Result := "Special"
		end

	font_b_box : PDF_RECTANGLE is
		do
			create Result.set (-180,-293,1090,1010)
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
			Result := "FontSpecific"
		end

	cap_height : INTEGER is
		do
			Result := 0
		end

	x_height : INTEGER is
		do
			Result := 0
		end

	ascender : INTEGER is
		do
			Result := 0
		end

	descender : INTEGER is
		do
			Result := 0
		end

	std_hw : INTEGER is
		do
			Result := 92
		end

	std_vw : INTEGER is
		do
			Result := 85
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (190)
			Result.force (250, "space")
			Result.force (333, "exclam")
			Result.force (713, "universal")
			Result.force (500, "numbersign")
			Result.force (549, "existential")
			Result.force (833, "percent")
			Result.force (778, "ampersand")
			Result.force (439, "suchthat")
			Result.force (333, "parenleft")
			Result.force (333, "parenright")
			Result.force (500, "asteriskmath")
			Result.force (549, "plus")
			Result.force (250, "comma")
			Result.force (549, "minus")
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
			Result.force (549, "less")
			Result.force (549, "equal")
			Result.force (549, "greater")
			Result.force (444, "question")
			Result.force (549, "congruent")
			Result.force (722, "Alpha")
			Result.force (667, "Beta")
			Result.force (722, "Chi")
			Result.force (612, "Delta")
			Result.force (611, "Epsilon")
			Result.force (763, "Phi")
			Result.force (603, "Gamma")
			Result.force (722, "Eta")
			Result.force (333, "Iota")
			Result.force (631, "theta1")
			Result.force (722, "Kappa")
			Result.force (686, "Lambda")
			Result.force (889, "Mu")
			Result.force (722, "Nu")
			Result.force (722, "Omicron")
			Result.force (768, "Pi")
			Result.force (741, "Theta")
			Result.force (556, "Rho")
			Result.force (592, "Sigma")
			Result.force (611, "Tau")
			Result.force (690, "Upsilon")
			Result.force (439, "sigma1")
			Result.force (768, "Omega")
			Result.force (645, "Xi")
			Result.force (795, "Psi")
			Result.force (611, "Zeta")
			Result.force (333, "bracketleft")
			Result.force (863, "therefore")
			Result.force (333, "bracketright")
			Result.force (658, "perpendicular")
			Result.force (500, "underscore")
			Result.force (500, "radicalex")
			Result.force (631, "alpha")
			Result.force (549, "beta")
			Result.force (549, "chi")
			Result.force (494, "delta")
			Result.force (439, "epsilon")
			Result.force (521, "phi")
			Result.force (411, "gamma")
			Result.force (603, "eta")
			Result.force (329, "iota")
			Result.force (603, "phi1")
			Result.force (549, "kappa")
			Result.force (549, "lambda")
			Result.force (576, "mu")
			Result.force (521, "nu")
			Result.force (549, "omicron")
			Result.force (549, "pi")
			Result.force (521, "theta")
			Result.force (549, "rho")
			Result.force (603, "sigma")
			Result.force (439, "tau")
			Result.force (576, "upsilon")
			Result.force (713, "omega1")
			Result.force (686, "omega")
			Result.force (493, "xi")
			Result.force (686, "psi")
			Result.force (494, "zeta")
			Result.force (480, "braceleft")
			Result.force (200, "bar")
			Result.force (480, "braceright")
			Result.force (549, "similar")
			Result.force (750, "Euro")
			Result.force (620, "Upsilon1")
			Result.force (247, "minute")
			Result.force (549, "lessequal")
			Result.force (167, "fraction")
			Result.force (713, "infinity")
			Result.force (500, "florin")
			Result.force (753, "club")
			Result.force (753, "diamond")
			Result.force (753, "heart")
			Result.force (753, "spade")
			Result.force (1042, "arrowboth")
			Result.force (987, "arrowleft")
			Result.force (603, "arrowup")
			Result.force (987, "arrowright")
			Result.force (603, "arrowdown")
			Result.force (400, "degree")
			Result.force (549, "plusminus")
			Result.force (411, "second")
			Result.force (549, "greaterequal")
			Result.force (549, "multiply")
			Result.force (713, "proportional")
			Result.force (494, "partialdiff")
			Result.force (460, "bullet")
			Result.force (549, "divide")
			Result.force (549, "notequal")
			Result.force (549, "equivalence")
			Result.force (549, "approxequal")
			Result.force (1000, "ellipsis")
			Result.force (603, "arrowvertex")
			Result.force (1000, "arrowhorizex")
			Result.force (658, "carriagereturn")
			Result.force (823, "aleph")
			Result.force (686, "Ifraktur")
			Result.force (795, "Rfraktur")
			Result.force (987, "weierstrass")
			Result.force (768, "circlemultiply")
			Result.force (768, "circleplus")
			Result.force (823, "emptyset")
			Result.force (768, "intersection")
			Result.force (768, "union")
			Result.force (713, "propersuperset")
			Result.force (713, "reflexsuperset")
			Result.force (713, "notsubset")
			Result.force (713, "propersubset")
			Result.force (713, "reflexsubset")
			Result.force (713, "element")
			Result.force (713, "notelement")
			Result.force (768, "angle")
			Result.force (713, "gradient")
			Result.force (790, "registerserif")
			Result.force (790, "copyrightserif")
			Result.force (890, "trademarkserif")
			Result.force (823, "product")
			Result.force (549, "radical")
			Result.force (250, "dotmath")
			Result.force (713, "logicalnot")
			Result.force (603, "logicaland")
			Result.force (603, "logicalor")
			Result.force (1042, "arrowdblboth")
			Result.force (987, "arrowdblleft")
			Result.force (603, "arrowdblup")
			Result.force (987, "arrowdblright")
			Result.force (603, "arrowdbldown")
			Result.force (494, "lozenge")
			Result.force (329, "angleleft")
			Result.force (790, "registersans")
			Result.force (790, "copyrightsans")
			Result.force (786, "trademarksans")
			Result.force (713, "summation")
			Result.force (384, "parenlefttp")
			Result.force (384, "parenleftex")
			Result.force (384, "parenleftbt")
			Result.force (384, "bracketlefttp")
			Result.force (384, "bracketleftex")
			Result.force (384, "bracketleftbt")
			Result.force (494, "bracelefttp")
			Result.force (494, "braceleftmid")
			Result.force (494, "braceleftbt")
			Result.force (494, "braceex")
			Result.force (329, "angleright")
			Result.force (274, "integral")
			Result.force (686, "integraltp")
			Result.force (686, "integralex")
			Result.force (686, "integralbt")
			Result.force (384, "parenrighttp")
			Result.force (384, "parenrightex")
			Result.force (384, "parenrightbt")
			Result.force (384, "bracketrighttp")
			Result.force (384, "bracketrightex")
			Result.force (384, "bracketrightbt")
			Result.force (494, "bracerighttp")
			Result.force (494, "bracerightmid")
			Result.force (494, "bracerightbt")
			Result.force (790, "apple")
		end

end
