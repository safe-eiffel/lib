indexing

	description:

		"EFOTUTORIAL System's root class"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	EFOTUTORIAL

inherit

	KL_SHARED_EXECUTION_ENVIRONMENT
	KL_SHARED_FILE_SYSTEM

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			test_hyphen
			test_open_type_font
			create test
			test.create_document ("FO_Tutorial.pdf")
			test_chapter_1
			test_tables
			test_show_section
			test.document.close
--			test_labels
		end

feature -- Access

	test : TUTORIAL_TEST

feature -- Basic operations

	test_chapter_1 is
		do
--			test_hello_world
			test_block
		end

	test_hello_world is
		local
			chapter : TUTORIAL_HELLO_WORLD
		do
			create chapter.execute
		end

	test_block is
		local
			chapter : TUTORIAL_TEST_BLOCK
		do
			create chapter.execute
		end

	test_tables is
		local
			chapter : TUTORIAL_SHOW_TABLES
		do
			create chapter.execute
		end

	test_show_section is
		local
			chapter : TUTORIAL_SHOW_SECTION
		do
			create chapter.execute
		end

	factory : FO_CONFIGURABLE_FACTORY

	test_hyphen is
		local
			h : FO_HYPHENATION
			file : FO_TEX_HYPHEN_FILE
			env : KL_EXECUTION_ENVIRONMENT
		do
			create env
--			create file.make (env.interpreted_string ("$SAFE/lib/fo/src/support/hyphen/hyph-de-1996.tex"))
--			create h.make ('-', 2, 2, file)
			create file.make (env.interpreted_string ("$SAFE/lib/fo/src/support/hyphen/frhyph.tex"))
			create h.make ('-', 2, 2, file)
			h.hyphenate ("Cyrille")
		end

	test_open_type_font
		local
			arial : OPEN_TYPE_FONT_FILE
		do
			create arial.make ("c:\windows\fonts\arial.ttf")
			arial.open_read
		end
end -- class EFOTUTORIAL
