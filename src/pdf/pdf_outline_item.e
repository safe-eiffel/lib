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

create
	{PDF_DOCUMENT} make, make_with_destination

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
			create {PDF_DESTINATION_XY_ZOOM} destination.make (referenced_page, referenced_left, referenced_top, 0)
		ensure
			title_set: title /= Void
			destination_set: destination /= Void
			page_referenced: explicit_destination.page = referenced_page
		end

	make_with_destination (object_number : INTEGER; item_title : STRING; referenced_destination : PDF_DESTINATION) is
		require
			object_number_not_negative: object_number >= 0
			item_title_exists: item_title /= Void
			referenced_destination_exists: referenced_destination /= Void
		do
			make_node (object_number)
			create list.make
			title := item_title
			destination := referenced_destination
		ensure
			title_set: title = item_title
			object_number_set: number = object_number
			destination_set: destination = referenced_destination
		end

feature -- Access

	node_anchor : PDF_OUTLINE_ITEM

	destination : PDF_DESTINATION
			-- destination referenced by outline item

	explicit_destination : PDF_EXPLICIT_DESTINATION is
		do
			Result ?= destination
		ensure
			definition: Result /= Void implies Result = destination
		end

	title : STRING
			-- title appearing in the outline tree

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
			medium.put_string (" /Dest ")
			medium.put_string (destination.to_pdf)
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
	title_exists: title /= Void
	destination_exists: destination /= Void

end -- class PDF_OUTLINE_ITEM
