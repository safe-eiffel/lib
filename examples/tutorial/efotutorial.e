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

creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			test_hyphen
			test_chapter_1
			test_tables
			test_show_section
			test_labels
		end

	test_labels is
		local
			test : TUTORIAL_TEST_LABELS
		do
			create test.execute
		end

	test_chapter_1 is
		do
			test_hello_world
			test_block
		end

	test_hello_world is
		local
			test : TUTORIAL_HELLO_WORLD
		do
			create test.execute
		end

	test_block is
		local
			test : TUTORIAL_TEST_BLOCK
		do
			create test.execute
		end

	test_tables is
		local
			test : TUTORIAL_SHOW_TABLES
		do
			create test.execute
		end

	test_show_section is
		local
			test : TUTORIAL_SHOW_SECTION
		do
			create test.execute
		end


	factory : FO_CONFIGURABLE_FACTORY

	test_hyphen is
		local
			h : FO_HYPHENATION
			file : FO_TEX_HYPHEN_FILE
			env : KL_EXECUTION_ENVIRONMENT
		do
			create env
			create file.make (env.interpreted_string ("$SAFE/lib/fo/src/support/hyphen/frhyph.tex"))
			create h.make ('-', 2, 2, file)
			h.hyphenate ("Cyrille")
		end

end -- class EFOTUTORIAL
