indexing
	description: "Objects that show FO_SECTION capabilities."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class TUTORIAL_SHOW_SECTION

inherit

	TUTORIAL_TEST

create
	execute

feature {NONE} -- Initialization

	execute is
			-- Initialize `Current'.
		local
			a_writer : FO_DOCUMENT_WRITER
			margins : FO_MARGINS
			block : FO_BLOCK
			i : INTEGER
		do
			create margins.set (cm (1), cm (1), cm (1), cm (1))
			create section_1.make ("section1", create {FO_PAGE_SIZE}.make_a4, margins)
			section_1.set_columns (<<cm (3), cm (5), cm (6), cm (2) >>, << cm (1), cm(1), cm (1)>>)
			document.set_section (section_1)

			append_chapter ("Sections")

			create block.make_default
			block.margins := (create {FO_MARGINS}.set(cm(0.2),cm(1),cm(0.2),cm(1)))
			block.append_string ("Section1 : Paper A4; margins (1cm, 1cm, 1cm, 1cm); columns (3cm, 5cm, 6cm, 2cm) separated by (1cm, 1cm, 1cm)")
			from
				i := 1
			until
				i > 100
			loop
				if i \\ 10= 1 then
					block.append_string ("Ceci est un essai assez amusant; j'aimerais voir ce qui est possible.")
				end
				block.append_string (i.out+"%N")
				i := i + 1
			end

			document.append_block (block)

			create section_2.make ("section2", (create {FO_PAGE_SIZE}.make_a4).rotated, margins)
			section_2.set_orientation_landscape
			create header.make (create {FO_MARGINS}.make, points (0))
			header.center_justify
			header.append (create {FO_INLINE}.make ("This is a header page "))
			header.last_inline.append_string ("Section2 : Paper A4 - rotated - landscape; margins (1cm, 1cm, 1cm, 1cm)")
			header.append (create {FO_CURRENT_PAGE_NUMBER}.make)
			header.append (create {FO_INLINE}.make (" of "))
			header.append (create {FO_PAGE_COUNT}.make)
			section_2.set_header (header)
			document.set_section (section_2)
			document.append_page_break
			document.append_block (block)
		end

feature -- Access

	header : FO_HEADER_FOOTER

	section_1 : FO_SECTION

	section_2 : FO_SECTION

	section_3 : FO_SECTION

end

