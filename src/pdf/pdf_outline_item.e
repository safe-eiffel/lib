indexing
	description: "Objects that are outline items"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_OUTLINE_ITEM

inherit

	PDF_OBJECT
		rename
			make as make_node
		redefine
			put_pdf
		end
		
	PDF_OUTLINE_NODE
		rename
			make as make_node
		end
		
creation
	{PDF_DOCUMENT} make

feature {NONE} -- Initialization

	make (object_number : INTEGER; item_title : STRING; referenced_page : PDF_PAGE; referenced_left, referenced_top : DOUBLE) is
			-- create `object_number' item, referencing `referenced_page' at (`referenced_left', `referenced_top') position
		require
			object_number_not_negative: object_number >= 0
			item_title_exists: item_title /= Void
			referenced_page_exists: referenced_page /= Void
			referenced_position_within_page_mediabox: referenced_page.mediabox.has_point (referenced_left.truncated_to_integer, referenced_top.truncated_to_integer)
		do
			make_node (object_number)
			create list.make
			title := item_title
			page := referenced_page
			left := referenced_left
			top := referenced_top
		ensure
			page_set: page = referenced_page
			left_set: left = referenced_left
			top_set: top = referenced_top
		end
		
feature -- Access

	node_anchor : PDF_OUTLINE_ITEM
	
	page : PDF_PAGE
	
	left : DOUBLE
			-- left position in page corresponding to this outline item
			
	top : DOUBLE
			-- top position in page corresponding to this outline item
			
	title : STRING
			-- title of outline item
			
feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	put_pdf (medium: PDF_OUTPUT_MEDIUM) is
			-- put Current on `medium'
		local
			parent_cursor : DS_LIST_CURSOR[PDF_OUTLINE_NODE]
			has_previous : BOOLEAN
		do
			medium.put_string (object_header)
			medium.put_string (Begin_dictionary)
			--
			medium.put_string ("/Title (")
			medium.put_string (title)
			medium.put_string (")")
			--
			medium.put_string (" /Parent ")
			medium.put_string (parent.indirect_reference)
			-- First
			-- Last
			parent_cursor := parent.new_cursor
			parent_cursor.start
			parent_cursor.search_forth (Current)
			-- Prev ?
			if not parent_cursor.is_first then
				parent_cursor.back
				medium.put_string (" /Prev ")
				medium.put_string (parent_cursor.item.indirect_reference)
				has_previous := True
			end
			-- Next ?
			if has_previous then
				parent_cursor.forth
			end
			if not parent_cursor.is_last then
				parent_cursor.forth
				medium.put_string ("/Next ")
				medium.put_string (parent_cursor.item.indirect_reference)
			end
			if not list.is_empty then
				medium.put_string (" /First ")
				medium.put_string (list.first.indirect_reference)
				medium.put_string ("/Last ")
				medium.put_string (list.last.indirect_reference)
				medium.put_string (" /Count ")
				medium.put_string (recursive_open_count.out)
			end
			-- dest
			medium.put_string (" /Dest [ ")
			medium.put_string (page.indirect_reference)
			medium.put_string (" /XYZ ")
			medium.put_double (left)
			medium.put_string (" ")
			medium.put_double (top)
			medium.put_string (" null ]")
			medium.put_string (End_dictionary)
			medium.put_string (Object_footer)
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_OUTLINE_ITEM
