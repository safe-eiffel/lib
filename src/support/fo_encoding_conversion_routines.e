indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_ENCODING_CONVERSION_ROUTINES

inherit
	
	KL_IMPORTED_INTEGER_ROUTINES
	
feature -- Access

	dos_to_ansi_character (input : CHARACTER) : CHARACTER is	
		do
			dos2pdf.search (input.code)
			if dos2pdf.found then
				Result := INTEGER_.to_character (dos2pdf.found_item)
			else
				Result := input
			end
		end

	dos_to_ansi_string (s : STRING) : STRING is
		local
			i : INTEGER
		do
			create Result.make (s.count)
			from
				i := 1
			until
				i > s.count
			loop
				Result.append_character (dos_to_ansi_character (s.item (i)))
				i := i + 1
			end
		end
		
feature {NONE} -- Implementation


	dos2pdf : HASH_TABLE[INTEGER,INTEGER] is
		once
			create Result.make (138)
			Result.put (100,100) --d
			Result.put (101,101) --e
			Result.put (102,102) --f
			Result.put (103,103) --g
			Result.put (104,104) --h
			Result.put (105,105) --i
			Result.put (106,106) --j
			Result.put (107,107) --k
			Result.put (108,108) --l
			Result.put (109,109) --m
			Result.put (110,110) --n
			Result.put (111,111) --o
			Result.put (112,112) --p
			Result.put (113,113) --q
			Result.put (114,114) --r
			Result.put (115,115) --s
			Result.put (116,116) --t
			Result.put (117,117) --u
			Result.put (118,118) --v
			Result.put (119,119) --w
			Result.put (120,120) --x
			Result.put (121,121) --y
			Result.put (122,122) --z
			Result.put (123,123) --braceleft
			Result.put (124,124) --bar
			Result.put (125,125) --braceright
			Result.put (126,126) --asciitilde
			Result.put (128,128) --Euro
			Result.put (252,129) --udieresis
			Result.put (233,130) --eacute
			Result.put (226,131) --acircumflex
			Result.put (228,132) --adieresis
			Result.put (224,133) --agrave
			Result.put (229,134) --aring
			Result.put (231,135) --ccedilla
			Result.put (234,136) --ecircumflex
			Result.put (235,137) --edieresis
			Result.put (232,138) --egrave
			Result.put (239,139) --idieresis
			Result.put (238,140) --icircumflex
			Result.put (236,141) --igrave
			Result.put (196,142) --Adieresis
			Result.put (197,143) --Aring
			Result.put (201,144) --Eacute
			Result.put (230,145) --ae
			Result.put (198,146) --AE
			Result.put (244,147) --ocircumflex
			Result.put (246,148) --odieresis
			Result.put (242,149) --ograve
			Result.put (251,150) --ucircumflex
			Result.put (249,151) --ugrave
			Result.put (255,152) --ydieresis
			Result.put (214,153) --Odieresis
			Result.put (220,154) --Udieresis
			Result.put (162,155) --cent
			Result.put (163,156) --sterling
			Result.put (165,157) --yen
			Result.put (225,160) --aacute
			Result.put (237,161) --iacute
			Result.put (243,162) --oacute
			Result.put (250,163) --uacute
			Result.put (241,164) --ntilde
			Result.put (170,166) --ordfeminine
			Result.put (186,167) --ordmasculine
			Result.put (191,168) --questiondown
			Result.put (172,170) --logicalnot
			Result.put (189,171) --onehalf
			Result.put (188,172) --onequarter
			Result.put (187,175) --guillemotright
			Result.put (247,246) --divide
			Result.put (32,32) --space
			Result.put (33,33) --exclam
			Result.put (34,34) --quotedbl
			Result.put (35,35) --numbersign
			Result.put (36,36) --dollar
			Result.put (37,37) --percent
			Result.put (38,38) --ampersand
			Result.put (39,39) --quotesingle
			Result.put (40,40) --parenleft
			Result.put (41,41) --parenright
			Result.put (42,42) --asterisk
			Result.put (43,43) --plus
			Result.put (44,44) --comma
			Result.put (45,45) --hyphen
			Result.put (46,46) --period
			Result.put (47,47) --slash
			Result.put (48,48) --zero
			Result.put (49,49) --one
			Result.put (50,50) --two
			Result.put (51,51) --three
			Result.put (52,52) --four
			Result.put (53,53) --five
			Result.put (54,54) --six
			Result.put (55,55) --seven
			Result.put (56,56) --eight
			Result.put (57,57) --nine
			Result.put (58,58) --colon
			Result.put (59,59) --semicolon
			Result.put (60,60) --less
			Result.put (61,61) --equal
			Result.put (62,62) --greater
			Result.put (63,63) --question
			Result.put (64,64) --at
			Result.put (65,65) --A
			Result.put (66,66) --B
			Result.put (67,67) --C
			Result.put (68,68) --D
			Result.put (69,69) --E
			Result.put (70,70) --F
			Result.put (71,71) --G
			Result.put (72,72) --H
			Result.put (73,73) --I
			Result.put (74,74) --J
			Result.put (75,75) --K
			Result.put (76,76) --L
			Result.put (77,77) --M
			Result.put (78,78) --N
			Result.put (79,79) --O
			Result.put (80,80) --P
			Result.put (81,81) --Q
			Result.put (82,82) --R
			Result.put (83,83) --S
			Result.put (84,84) --T
			Result.put (85,85) --U
			Result.put (86,86) --V
			Result.put (87,87) --W
			Result.put (88,88) --X
			Result.put (89,89) --Y
			Result.put (90,90) --Z
			Result.put (91,91) --bracketleft
			Result.put (92,92) --backslash
			Result.put (93,93) --bracketright
			Result.put (94,94) --asciicircum
			Result.put (95,95) --underscore
			Result.put (96,96) --grave
			Result.put (97,97) --a
			Result.put (98,98) --b
			Result.put (99,99) --c
		end
	
end

