indexing
	description: "Objects that behave like a text printer"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_TEXT_WRITER

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	PDF_TEXT_RENDERER
		rename
		export
		undefine
		redefine
		select
		end

-- The following Creation_clause can be removed if you need no other
-- procedure than `default_create':

creation
	make

feature -- Initialization

	make (a_document : PDF_DOCUMENT) is
			-- 
		require
			a_document /= Void
		do
			current_document := a_document		
		end
		
feature -- Access

	current_font : PDF_FONT
	
	current_font_size : DOUBLE
	
	current_document : PDF_DOCUMENT
	
feature -- Measurement

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

	find_font (a_font_name : STRING; an_encoding_name : STRING) is
			--
		require
			a_font_name /= Void
			an_encoding_name /= Void
		do
			current_document.find_font (a_font_name, an_encoding_name)
			current_font := current_document.last_font
		end
		
	set_font (a_font : PDF_FONT; a_size : DOUBLE) is
			-- 
		require
			a_font /= Void
			a_size > 0
		do
			current_document.last_page.set_font (a_font, a_size)
			a_font_size := current_document.last_page.font_size
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_TEXT_WRITER
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
