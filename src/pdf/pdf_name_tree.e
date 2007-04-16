indexing
	description: "PDF Name trees."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_NAME_TREE

inherit
	DS_HASH_TABLE[PDF_SERIALIZABLE,STRING]
		rename
			make as make_table
		export
			{NONE} all;
			{ANY} put, has, item, force
		undefine
			is_equal, copy
		end

	PDF_OBJECT
		rename
			make as make_pdf_object
		redefine
			put_pdf
		end

create

	make

feature {NONE} -- Initialization

	make (pdf_document : PDF_DOCUMENT; initial_capacity : INTEGER) is
		require
			pdf_document_not_void: pdf_document /= Void
			initial_capacity_positive: initial_capacity >= 0
		local
			object_number : INTEGER
		do
			object_number := pdf_document.xref.count
			make_pdf_object (object_number)
			pdf_document.xref.add_entry (Current)
			make_table (initial_capacity)
			document := pdf_document
		ensure
			registered: pdf_document.xref.object (number) = Current
			document_set: document = pdf_document
		end

feature -- Access

	document : PDF_DOCUMENT

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

feature -- Obsolete

feature -- Conversion

	to_pdf : STRING is
		do
			Result := to_pdf_using_put_pdf
		end

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
		do
			create_leafs
			create_directories
			medium.put_string (object_header)
			medium.put_string (begin_dictionary)
			 if directories /= leafs then
				medium.put_string (dictionary_entry (names.kids, kids_array))
			else
				if leafs.count = 1 then
					medium.put_string (dictionary_entry (names.names,leafs.first.content_array))
				end
			end
			medium.put_string (end_dictionary)
			medium.put_string (object_footer)
		end

feature {NONE} -- Implementation

	leafs : DS_LIST [PDF_NAME_TREE_LEAF]

	directories : DS_LIST [PDF_NAME_TREE_NODE]

	create_leafs is
		local
			key_list : DS_ARRAYED_LIST [STRING]
			sorter : DS_HEAP_SORTER [STRING]
			leaf : PDF_NAME_TREE_LEAF
		do
			create key_list.make_from_linear (keys)
			create sorter.make (create {KL_COMPARABLE_COMPARATOR[STRING]}.make)
			sorter.sort (key_list)
			create {DS_LINKED_LIST[PDF_NAME_TREE_LEAF]}leafs.make
			from
				key_list.start
			until
				key_list.after
			loop
				from
					create leaf.make (document.xref.count)
					document.xref.add_entry (leaf)
				until
					key_list.after or else leaf.count = leaf.capacity
				loop
					leaf.add (key_list.item_for_iteration, item (key_list.item_for_iteration))
					key_list.forth
				end
				leafs.put_last (leaf)
			end
		end

	create_directories is
		require
			leafs_not_void: leafs /= Void
		do
			if leafs.count > 1 then
				directories := directory_list_for_list (leafs, 0)
			else
				directories := leafs
			end
		ensure
			directories_not_void: directories /= Void
		end

	directory_list_for_list (a_list : DS_LIST[PDF_NAME_TREE_NODE]; level : INTEGER) : DS_LIST[PDF_NAME_TREE_NODE] is
		local
			new_list : DS_LINKED_LIST[PDF_NAME_TREE_NODE]
			directory : PDF_NAME_TREE_DIRECTORY
			cursor : DS_LIST_CURSOR[PDF_NAME_TREE_NODE]
		do
			if level > 0 and then a_list.count <= a_list.first.capacity then
				Result := a_list
			else
				create new_list.make
				from
					cursor := a_list.new_cursor
					cursor.start
				until
					cursor.after
				loop
					from
						create directory.make (document.xref.count)
						document.xref.add_entry (directory)
					until
						cursor.after or else directory.count = directory.capacity
					loop
						directory.put (cursor.item)
						cursor.forth
					end
					new_list.put_last (directory)
				end
				Result := directory_list_for_list (new_list, level + 1)
			end
		end

	kids_array : STRING is
		do
			create Result.make (100)
			Result.append_string ("[%N")
			from
				directories.start
			until
				directories.after
			loop
				Result.append_string (directories.item_for_iteration.indirect_reference)
				Result.append_character ('%N')
				directories.forth
			end
			Result.append_string ("]%N")
		end

invariant
	invariant_clause: True -- Your invariant here

end
