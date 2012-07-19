indexing

	description: "PDF Pages tree node. Sort of pages directory."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_PAGES

inherit

	PDF_OBJECT

	PDF_PAGE_TREE_NODE

create

	make

feature -- Initialization

feature -- Access

	kids : DS_LIST [PDF_PAGE_TREE_NODE] is
			-- kids -- must be PDF_PAGES or PDF_PAGE
		do
			if kids_impl = Void then
				create {DS_LINKED_LIST[PDF_PAGE_TREE_NODE]}kids_impl.make
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
			create stype.make ("Type")
			create skids.make ("Kids")
			create scount.make ("Count")
			create sparent.make ("Parent")
			create Result.make (256)
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

feature {PDF_DOCUMENT} -- Basic operations

	build_pages_tree (document : PDF_DOCUMENT; page_list : DS_LIST[PDF_PAGE]) is
			-- Build pages tree using PDF_PAGE_TREE_NODEs, hierachical organization
			-- of pages; Each PDF_PAGES_TREE_NODE having at most 'kids_count' kids.
		require
			document_exists: document /= Void
			page_list_exists: page_list /= Void
		local
			nodes_count : INTEGER
			nodes_list : DS_LIST[PDF_PAGE_TREE_NODE]
			nodes_list_cursor : DS_LIST_CURSOR [PDF_PAGE_TREE_NODE]
		do
			from
				nodes_count := ((page_list.count - 1)/kids_count).truncated_to_integer + 1
				nodes_list := page_list
				last_parent_list := Void
			until
				nodes_count < kids_count
			loop
				give_a_parent (document, nodes_list)
				nodes_count := ((nodes_count - 1)/kids_count).truncated_to_integer + 1
			end
			-- add those nodes to root node
			if last_parent_list /= Void then
				nodes_list := last_parent_list
			else
				nodes_list := page_list
			end
			from
				nodes_list_cursor := nodes_list.new_cursor
				nodes_list_cursor.start
				empty_kids
			until
				nodes_list_cursor.off
			loop
				add_kid (nodes_list_cursor.item)
				nodes_list_cursor.forth
			end
		end

	give_a_parent (document : PDF_DOCUMENT; nodes : DS_LIST[PDF_PAGE_TREE_NODE]) is
			-- Give a parent to 'nodes'; parent can be found in 'last_parent'
		require
			document_exists: document /= Void
			nodes_exist: nodes /= Void
		local
			node_count : INTEGER
			nodes_list_cursor : DS_LIST_CURSOR [PDF_PAGE_TREE_NODE]
		do
			from
				nodes_list_cursor := nodes.new_cursor
				nodes_list_cursor.start
				node_count := 0
				!DS_LINKED_LIST[PDF_PAGE_TREE_NODE]!last_parent_list.make
			variant
				nodes.count - node_count
			until
				nodes_list_cursor.off
			loop
				if node_count \\ kids_count = 0 then
					-- create a parent
					document.create_pages
					-- add it to the DS_LIST
					last_parent_list.put_last (document.last_pages)
				end
				-- add kids up-to the kids_count
				document.last_pages.add_kid (nodes_list_cursor.item)
				node_count := node_count + 1
				nodes_list_cursor.forth
			end
		ensure
			result_in_last_parent_list: last_parent_list /= Void
				-- and each parent p in last_parent_list
				-- has at most 'kids_count' kids from nodes
				-- foreach n in nodes : n.parent /= Void : each node in nodes has a parent
		end

	last_parent_list : DS_LIST[PDF_PAGE_TREE_NODE]

	kids_count : INTEGER is 10

invariant
	kids_exist: kids /= Void

end -- class PDF_PAGES
