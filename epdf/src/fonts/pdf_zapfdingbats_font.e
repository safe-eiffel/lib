indexing
	description: "ZapfDingbats font definition."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_ZAPFDINGBATS_FONT

inherit
	PDF_ADOBE14_FONT

create
	make

feature -- Access

	basefont : PDF_NAME is
		once
			create Result.make ("ZapfDingbats")
		end

	full_name : STRING is
		do
			Result := "ITC Zapf Dingbats"
		end

	family_name : STRING is
		do
			Result := "ZapfDingbats"
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
			create Result.set (-1,-143,981,820)
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
			Result := 28
		end

	std_vw : INTEGER is
		do
			Result := 90
		end

feature {NONE} -- Implementation

	name_to_width : DS_HASH_TABLE[INTEGER,STRING] is
		once
			create Result.make (202)
			Result.force (278, "space")
			Result.force (974, "a1")
			Result.force (961, "a2")
			Result.force (974, "a202")
			Result.force (980, "a3")
			Result.force (719, "a4")
			Result.force (789, "a5")
			Result.force (790, "a119")
			Result.force (791, "a118")
			Result.force (690, "a117")
			Result.force (960, "a11")
			Result.force (939, "a12")
			Result.force (549, "a13")
			Result.force (855, "a14")
			Result.force (911, "a15")
			Result.force (933, "a16")
			Result.force (911, "a105")
			Result.force (945, "a17")
			Result.force (974, "a18")
			Result.force (755, "a19")
			Result.force (846, "a20")
			Result.force (762, "a21")
			Result.force (761, "a22")
			Result.force (571, "a23")
			Result.force (677, "a24")
			Result.force (763, "a25")
			Result.force (760, "a26")
			Result.force (759, "a27")
			Result.force (754, "a28")
			Result.force (494, "a6")
			Result.force (552, "a7")
			Result.force (537, "a8")
			Result.force (577, "a9")
			Result.force (692, "a10")
			Result.force (786, "a29")
			Result.force (788, "a30")
			Result.force (788, "a31")
			Result.force (790, "a32")
			Result.force (793, "a33")
			Result.force (794, "a34")
			Result.force (816, "a35")
			Result.force (823, "a36")
			Result.force (789, "a37")
			Result.force (841, "a38")
			Result.force (823, "a39")
			Result.force (833, "a40")
			Result.force (816, "a41")
			Result.force (831, "a42")
			Result.force (923, "a43")
			Result.force (744, "a44")
			Result.force (723, "a45")
			Result.force (749, "a46")
			Result.force (790, "a47")
			Result.force (792, "a48")
			Result.force (695, "a49")
			Result.force (776, "a50")
			Result.force (768, "a51")
			Result.force (792, "a52")
			Result.force (759, "a53")
			Result.force (707, "a54")
			Result.force (708, "a55")
			Result.force (682, "a56")
			Result.force (701, "a57")
			Result.force (826, "a58")
			Result.force (815, "a59")
			Result.force (789, "a60")
			Result.force (789, "a61")
			Result.force (707, "a62")
			Result.force (687, "a63")
			Result.force (696, "a64")
			Result.force (689, "a65")
			Result.force (786, "a66")
			Result.force (787, "a67")
			Result.force (713, "a68")
			Result.force (791, "a69")
			Result.force (785, "a70")
			Result.force (791, "a71")
			Result.force (873, "a72")
			Result.force (761, "a73")
			Result.force (762, "a74")
			Result.force (762, "a203")
			Result.force (759, "a75")
			Result.force (759, "a204")
			Result.force (892, "a76")
			Result.force (892, "a77")
			Result.force (788, "a78")
			Result.force (784, "a79")
			Result.force (438, "a81")
			Result.force (138, "a82")
			Result.force (277, "a83")
			Result.force (415, "a84")
			Result.force (392, "a97")
			Result.force (392, "a98")
			Result.force (668, "a99")
			Result.force (668, "a100")
			Result.force (390, "a89")
			Result.force (390, "a90")
			Result.force (317, "a93")
			Result.force (317, "a94")
			Result.force (276, "a91")
			Result.force (276, "a92")
			Result.force (509, "a205")
			Result.force (509, "a85")
			Result.force (410, "a206")
			Result.force (410, "a86")
			Result.force (234, "a87")
			Result.force (234, "a88")
			Result.force (334, "a95")
			Result.force (334, "a96")
			Result.force (732, "a101")
			Result.force (544, "a102")
			Result.force (544, "a103")
			Result.force (910, "a104")
			Result.force (667, "a106")
			Result.force (760, "a107")
			Result.force (760, "a108")
			Result.force (776, "a112")
			Result.force (595, "a111")
			Result.force (694, "a110")
			Result.force (626, "a109")
			Result.force (788, "a120")
			Result.force (788, "a121")
			Result.force (788, "a122")
			Result.force (788, "a123")
			Result.force (788, "a124")
			Result.force (788, "a125")
			Result.force (788, "a126")
			Result.force (788, "a127")
			Result.force (788, "a128")
			Result.force (788, "a129")
			Result.force (788, "a130")
			Result.force (788, "a131")
			Result.force (788, "a132")
			Result.force (788, "a133")
			Result.force (788, "a134")
			Result.force (788, "a135")
			Result.force (788, "a136")
			Result.force (788, "a137")
			Result.force (788, "a138")
			Result.force (788, "a139")
			Result.force (788, "a140")
			Result.force (788, "a141")
			Result.force (788, "a142")
			Result.force (788, "a143")
			Result.force (788, "a144")
			Result.force (788, "a145")
			Result.force (788, "a146")
			Result.force (788, "a147")
			Result.force (788, "a148")
			Result.force (788, "a149")
			Result.force (788, "a150")
			Result.force (788, "a151")
			Result.force (788, "a152")
			Result.force (788, "a153")
			Result.force (788, "a154")
			Result.force (788, "a155")
			Result.force (788, "a156")
			Result.force (788, "a157")
			Result.force (788, "a158")
			Result.force (788, "a159")
			Result.force (894, "a160")
			Result.force (838, "a161")
			Result.force (1016, "a163")
			Result.force (458, "a164")
			Result.force (748, "a196")
			Result.force (924, "a165")
			Result.force (748, "a192")
			Result.force (918, "a166")
			Result.force (927, "a167")
			Result.force (928, "a168")
			Result.force (928, "a169")
			Result.force (834, "a170")
			Result.force (873, "a171")
			Result.force (828, "a172")
			Result.force (924, "a173")
			Result.force (924, "a162")
			Result.force (917, "a174")
			Result.force (930, "a175")
			Result.force (931, "a176")
			Result.force (463, "a177")
			Result.force (883, "a178")
			Result.force (836, "a179")
			Result.force (836, "a193")
			Result.force (867, "a180")
			Result.force (867, "a199")
			Result.force (696, "a181")
			Result.force (696, "a200")
			Result.force (874, "a182")
			Result.force (874, "a201")
			Result.force (760, "a183")
			Result.force (946, "a184")
			Result.force (771, "a197")
			Result.force (865, "a185")
			Result.force (771, "a194")
			Result.force (888, "a198")
			Result.force (967, "a186")
			Result.force (888, "a195")
			Result.force (831, "a187")
			Result.force (873, "a188")
			Result.force (927, "a189")
			Result.force (970, "a190")
			Result.force (918, "a191")
		end

end
