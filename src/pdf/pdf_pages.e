indexing

	description: "PDF Pages tree node. Sort of pages directory."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_PAGES

inherit

	PDF_OBJECT

	PDF_PAGE_TREE_NODE
	
creation
	
	make

feature -- Initialization

feature -- Access
	
	kids : DS_LIST [PDF_PAGE_TREE_NODE] is
			-- kids -- must be PDF_PAGES or PDF_PAGE
		do
			if kids_impl = Void then
				!DS_LINKED_LIST[PDF_PAGE_TREE_NODE]!kids_impl.make
			end
			Result := kids_impl
		end
		
	
feature -- Measurement

	count : INTEGER is
			-- deep number of kids
		local
			kids_cursor : DS_LIST_CURSOR [PDF_PAGE_TREE_NODE]
		do
			from
				kids_cursor := kids.new_cursor
				kids_cursor.start
				Result := 0
			until
				kids_cursor.off
			loop
				Result := Result + kids_cursor.item.count
				kids_cursor.forth
			end
		end

feature -- Status Report

	is_page : BOOLEAN is False
	
feature -- Element change

--	add_pages (a_pages : PDF_PAGES) is
--			-- add `a_pages' tree node as last kid
--		require
--			a_pages /= Void
--		do
--			a_pages.set_parent (Current)
--			kids.extend (a_pages)
--		ensure
--			kids.has (a_pages) and a_pages.parent = Current
--		end
--	
--	add_page (a_page : PDF_PAGE) is
--			-- add `a_page' page as last kid
--		require
--			a_page /= Void
--		do
--			a_page.set_parent (Current)
--			kids.extend (a_page)
--		ensure
--			kids.has (a_page) and a_page.parent = Current
--		end

feature -- Conversion

	to_pdf : STRING is
			-- 
		local
			stype, skids, scount : PDF_NAME
			sparent : PDF_NAME
			kids_cursor : DS_LIST_CURSOR [PDF_OBJECT]
		do
			!!stype.make ("Type")
			!!skids.make ("Kids")
			!!scount.make ("Count")
			!!sparent.make ("Parent")
			!!Result.make (256)
			Result.append_string (object_header)
			Result.append_string (begin_dictionary)
			-- Type
			Result.append_string (dictionary_entry (stype, "/Pages"))
			-- Parent
			if parent /= Void then
				Result.append_string (dictionary_entry (sparent, parent.indirect_reference))
			end
			-- Kids (array of object references)
			Result.append_string (skids.to_pdf)
			Result.append_string (" [%N")
			from 
				kids_cursor := kids.new_cursor
				kids_cursor.start
			until
				kids_cursor.off
			loop
				Result.append_string (kids_cursor.item.indirect_reference)
				Result.append_character ('%N')
				kids_cursor.forth
			end
			Result.append_string ("]%N")
			-- Count
			Result.append_string (dictionary_entry (scount, count.out))
			Result.append_string (end_dictionary)
			Result.append_string (object_footer)
		end

feature {NONE} -- Implementation

	kids_impl : DS_LIST [PDF_PAGE_TREE_NODE]
	
invariant
	invariant_clause: -- Your invariant here

end -- class PDF_PAGES
