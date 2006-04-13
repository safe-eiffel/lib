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
	
	FO_SHARED_FONT_FACTORY
	FO_MEASUREMENT_ROUTINES
	
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
			
			create a_writer.make ("show_sections.pdf")
			create document.make (a_writer)
			document.set_section (section_1)
			
			create block.make_default
			block.set_margins (create {FO_MARGINS}.set(cm(0.2),cm(1),cm(0.2),cm(1)))
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
			
			document.open
			document.append_block (block)
			
			create section_2.make ("section2", (create {FO_PAGE_SIZE}.make_a4).rotated, margins)
			section_2.set_orientation_landscape
			create header.make (create {FO_MARGINS}.make, points (0))
			header.center_justify
			header.append (create {FO_INLINE}.make ("This is a header page "))
			header.append (create {FO_CURRENT_PAGE_NUMBER}.make)
			header.append (create {FO_INLINE}.make (" of "))
			header.append (create {FO_PAGE_COUNT}.make)
			section_2.set_header (header)
			document.set_section (section_2)
			document.append_page_break
			document.append_block (block)
			document.close
			
		end
		
feature -- Access

	document : FO_DOCUMENT
	
	header : FO_HEADER_FOOTER
	
	section_1 : FO_SECTION
	
	section_2 : FO_SECTION
	
	section_3 : FO_SECTION
	
feature -- Measurement

feature -- Comparison

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation


end

