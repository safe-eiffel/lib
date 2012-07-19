indexing

	description: 
	
		"Page sizes."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_PAGE_SIZE

inherit
	FO_RECTANGLE
		rename
			make as make_rectangle
		end

create 
	make, 
	make_a4, 
	make_letter
	
create {FO_PAGE_SIZE}
	set

feature {NONE} -- Initialization

	make_a4 is	
			-- Make ("A4")
		do
			make ("A4")
		end

	make_letter is		
			-- Make "Letter".
		do
			make ("Letter")
		end
		
	make (name : STRING) is
			-- Make for `name'.
		local
			wh : DS_PAIR[FO_MEASUREMENT,FO_MEASUREMENT]
			zero : FO_MEASUREMENT
			canonic : STRING
		do
			create zero.points (0)
			canonic := canonic_name (name)
			if canonic /= Void then
				wh := media.item (canonic)
			else
				wh := media.item ("A4")
			end
			set (zero, zero, wh.first, wh.second)
		ensure
			known_name_set: media_names.has (name) implies width.is_equal (width_of (name)) and height.is_equal (height_of (name))
			unknown_a4: (not media_names.has (name)) implies width.is_equal (width_of ("A4")) and height.is_equal (height_of ("A4"))
		end
		
feature -- Access

	media_names : DS_LIST[STRING] is
			-- Available media names.
		do
			Result := media_names_impl
		ensure
			media_names_not_void: media_names /= Void
		end
	
	width_of (name : STRING) : FO_MEASUREMENT is
			-- Width of media `name'.
		require
			name_not_void: name /= Void
			media_names_has_name: media_names.has (name)
		do
			Result := media.item (canonic_name (name)).first
		ensure
			width_of_name_not_void: Result /= Void
		end

	height_of (name : STRING) : FO_MEASUREMENT is	
			-- Height of media `name'.
		require
			name_not_void: name /= Void
			media_names_has_name: media_names.has (name)
		do
			Result := media.item (canonic_name (name)).second
		ensure
			height_of_name_not_void: Result /= Void
		end

	rotated : FO_PAGE_SIZE is		
			-- Current rotated.
		do
			create Result.set (left, bottom, top, right)
		ensure
			rotated_not_void: Result /= Void
			current_rotated: Result.left.is_equal (left) and Result.bottom.is_equal (bottom)
							and Result.right.is_equal (top) and Result.top.is_equal (right)
		end
		
feature {NONE} -- Implementation

	canonic_name (a_name : STRING) : STRING is
			-- Canonic medium name.
		do
			media_names.start
			media_names.search_forth (a_name)
			if not media_names.off then
				Result := media_names.item_for_iteration
			end
		ensure
			not_void_if_has: media_names.has (a_name) implies Result /= Void
		end
		
	media_names_impl : DS_LIST[STRING] is
		local
			c : DS_HASH_TABLE_CURSOR[DS_PAIR[FO_MEASUREMENT, FO_MEASUREMENT], STRING]
			ci_tester : KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER
		once
			create {DS_LINKED_LIST[STRING]}Result.make
			create ci_tester
			Result.set_equality_tester (ci_tester)
			from
				c := media.new_cursor
				c.start
			until
				c.off
			loop
				Result.put_last (c.key)
				c.forth
			end
		end
		
	
	media : DS_HASH_TABLE [DS_PAIR[FO_MEASUREMENT, FO_MEASUREMENT], STRING] is
			-- Media table.
		local
			ci_tester: KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER
		once
			create Result.make (150)
			create ci_tester
			Result.set_key_equality_tester (ci_tester)
			media.force (pair_wh (720, 792), "10x11")
			media.force (pair_wh (720, 936), "10x13")
			media.force (pair_wh (720, 1008), "10x14")
			media.force (pair_wh (864, 792), "12x11")
			media.force (pair_wh (1080, 792), "15x11")
			media.force (pair_wh (504, 648), "7x9")
			media.force (pair_wh (576, 720), "8x10")
			media.force (pair_wh (648, 792), "9x11")
			media.force (pair_wh (648, 864), "9x12")
			media.force (pair_wh (2384, 3370), "A0")
			media.force (pair_wh (1684, 2384), "A1")
			media.force (pair_wh (1191, 1684), "A2")
			media.force (pair_wh (842, 1191), "A3")
			media.force (pair_wh (842, 1191), "A3.Transverse")
			media.force (pair_wh (913, 1262), "A3Extra")
			media.force (pair_wh (913, 1262), "A3Extra.Transverse")
			media.force (pair_wh (1191, 842), "A3Rotated")
			media.force (pair_wh (595, 842), "A4")
			media.force (pair_wh (595, 842), "A4.Transverse")
			media.force (pair_wh (667, 914), "A4Extra")
			media.force (pair_wh (595, 936), "A4Plus")
			media.force (pair_wh (842, 595), "A4Rotated")
			media.force (pair_wh (595, 842), "A4Small")
			media.force (pair_wh (420, 595), "A5")
			media.force (pair_wh (420, 595), "A5.Transverse")
			media.force (pair_wh (492, 668), "A5Extra")
			media.force (pair_wh (595, 420), "A5Rotated")
			media.force (pair_wh (297, 420), "A6")
			media.force (pair_wh (420, 297), "A6Rotated")
			media.force (pair_wh (210, 297), "A7")
			media.force (pair_wh (148, 210), "A8")
			media.force (pair_wh (105, 148), "A9")
			media.force (pair_wh (73, 105), "A10")
			media.force (pair_wh (1224, 1584), "AnsiC")
			media.force (pair_wh (1584, 2448), "AnsiD")
			media.force (pair_wh (2448, 3168), "AnsiE")
			media.force (pair_wh (648, 864), "ARCHA")
			media.force (pair_wh (864, 1296), "ARCHB")
			media.force (pair_wh (1296, 1728), "ARCHC")
			media.force (pair_wh (1728, 2592), "ARCHD")
			media.force (pair_wh (2592, 3456), "ARCHE")
			media.force (pair_wh (2920, 4127), "B0")
			media.force (pair_wh (2064, 2920), "B1")
			media.force (pair_wh (1460, 2064), "B2")
			media.force (pair_wh (1032, 1460), "B3")
			media.force (pair_wh (729, 1032), "B4")
			media.force (pair_wh (1032, 729), "B4Rotated")
			media.force (pair_wh (516, 729), "B5")
			media.force (pair_wh (516, 729), "B5.Transverse")
			media.force (pair_wh (729, 516), "B5Rotated")
			media.force (pair_wh (363, 516), "B6")
			media.force (pair_wh (516, 363), "B6Rotated")
			media.force (pair_wh (258, 363), "B7")
			media.force (pair_wh (181, 258), "B8")
			media.force (pair_wh (127, 181), "B9")
			media.force (pair_wh (91, 127), "B10")
			media.force (pair_wh (279, 639), "Env9")
			media.force (pair_wh (297, 684), "Env10")
			media.force (pair_wh (324, 747), "Env11")
			media.force (pair_wh (342, 792), "Env12")
			media.force (pair_wh (360, 828), "Env14")
			media.force (pair_wh (2599, 3676), "EnvC0")
			media.force (pair_wh (1837, 2599), "EnvC1")
			media.force (pair_wh (1298, 1837), "EnvC2")
			media.force (pair_wh (918, 1296), "EnvC3")
			media.force (pair_wh (649, 918), "EnvC4")
			media.force (pair_wh (459, 649), "EnvC5")
			media.force (pair_wh (323, 459), "EnvC6")
			media.force (pair_wh (324, 648), "EnvC65")
			media.force (pair_wh (230, 323), "EnvC7")
			media.force (pair_wh (340, 666), "EnvChou3")
			media.force (pair_wh (666, 340), "EnvChou3Rotated")
			media.force (pair_wh (255, 581), "EnvChou4")
			media.force (pair_wh (581, 255), "EnvChou4Rotated")
			media.force (pair_wh (312, 624), "EnvDL")
			media.force (pair_wh (624, 624), "EnvInvite")
			media.force (pair_wh (708, 1001), "EnvISOB4")
			media.force (pair_wh (499, 709), "EnvISOB5")
			media.force (pair_wh (499, 354), "EnvISOB6")
			media.force (pair_wh (312, 652), "EnvItalian")
			media.force (pair_wh (680, 941), "EnvKaku2")
			media.force (pair_wh (941, 680), "EnvKaku2Rotated")
			media.force (pair_wh (612, 785), "EnvKaku3")
			media.force (pair_wh (785, 612), "EnvKaku3Rotated")
			media.force (pair_wh (279, 540), "EnvMonarch")
			media.force (pair_wh (261, 468), "EnvPersonal")
			media.force (pair_wh (289, 468), "EnvPRC1")
			media.force (pair_wh (468, 289), "EnvPRC1Rotated")
			media.force (pair_wh (289, 499), "EnvPRC2")
			media.force (pair_wh (499, 289), "EnvPRC2Rotated")
			media.force (pair_wh (354, 499), "EnvPRC3")
			media.force (pair_wh (499, 354), "EnvPRC3Rotated")
			media.force (pair_wh (312, 590), "EnvPRC4")
			media.force (pair_wh (590, 312), "EnvPRC4Rotated")
			media.force (pair_wh (312, 624), "EnvPRC5")
			media.force (pair_wh (624, 312), "EnvPRC5Rotated")
			media.force (pair_wh (340, 652), "EnvPRC6")
			media.force (pair_wh (652, 340), "EnvPRC6Rotated")
			media.force (pair_wh (454, 652), "EnvPRC7")
			media.force (pair_wh (652, 454), "EnvPRC7Rotated")
			media.force (pair_wh (340, 876), "EnvPRC8")
			media.force (pair_wh (876, 340), "EnvPRC8Rotated")
			media.force (pair_wh (649, 918), "EnvPRC9")
			media.force (pair_wh (918, 649), "EnvPRC9Rotated")
			media.force (pair_wh (918, 1298), "EnvPRC10")
			media.force (pair_wh (1298, 918), "EnvPRC10Rotated")
			media.force (pair_wh (298, 666), "EnvYou4")
			media.force (pair_wh (666, 298), "EnvYou4Rotated")
			media.force (pair_wh (522, 756), "Executive")
			media.force (pair_wh (1071, 792), "FanFoldUS")
			media.force (pair_wh (612, 864), "FanFoldGerman")
			media.force (pair_wh (612, 936), "FanFoldGermanLegal")
			media.force (pair_wh (595, 935), "Folio")
			media.force (pair_wh (2835, 4008), "ISOB0")
			media.force (pair_wh (2004, 2835), "ISOB1")
			media.force (pair_wh (1417, 2004), "ISOB2")
			media.force (pair_wh (1001, 1417), "ISOB3")
			media.force (pair_wh (709, 1001), "ISOB4")
			media.force (pair_wh (499, 709), "ISOB5")
			media.force (pair_wh (354, 499), "ISOB6")
			media.force (pair_wh (249, 354), "ISOB7")
			media.force (pair_wh (176, 249), "ISOB8")
			media.force (pair_wh (125, 176), "ISOB9")
			media.force (pair_wh (88, 125), "ISOB10")
			media.force (pair_wh (1224, 792), "Ledger")
			media.force (pair_wh (612, 1008), "Legal")
			media.force (pair_wh (684, 1080), "LegalExtra")
			media.force (pair_wh (612, 792), "Letter")
			media.force (pair_wh (612, 792), "Letter.Transverse")
			media.force (pair_wh (684, 864), "LetterExtra")
			media.force (pair_wh (684, 864), "LetterExtra.Transverse")
			media.force (pair_wh (792, 612), "LetterRotated")
			media.force (pair_wh (612, 792), "LetterSmall")
			media.force (pair_wh (612, 792), "Note")
			media.force (pair_wh (284, 419), "Postcard")
			media.force (pair_wh (419, 284), "PostcardRotated")
			media.force (pair_wh (414, 610), "PRC16K")
			media.force (pair_wh (610, 414), "PRC16KRotated")
			media.force (pair_wh (275, 428), "PRC32K")
			media.force (pair_wh (275, 428), "PRC32KBig")
			media.force (pair_wh (428, 275), "PRC32KBigRotated")
			media.force (pair_wh (428, 275), "PRC32KRotated")
			media.force (pair_wh (610, 780), "Quarto")
			media.force (pair_wh (396, 612), "Statement")
			media.force (pair_wh (643, 1009), "SuperA")
			media.force (pair_wh (864, 1380), "SuperB")
			media.force (pair_wh (792, 1224), "Tabloid")
			media.force (pair_wh (864, 1296), "TabloidExtra")
		end
		
	pair_wh (a_width, a_height : INTEGER) : DS_PAIR[FO_MEASUREMENT, FO_MEASUREMENT] is
		local
			w, h : FO_MEASUREMENT
		do
			create w.points (a_width)
			create h.points (a_height)
			create Result.make (w, h)
		end
			
end
