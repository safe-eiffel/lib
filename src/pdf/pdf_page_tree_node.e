indexing
	description: "Page-tree node."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_PAGE_TREE_NODE

inherit
	PDF_OBJECT
		rename
		export
		undefine
			make, is_equal, copy
		redefine
		select
		end

feature {PDF_OBJECT} -- Access

	parent : PDF_PAGES

feature {PDF_OBJECT} -- Measurement

	count : INTEGER is
			-- count of leafs
		deferred
		end

	kids : DS_LIST [PDF_PAGE_TREE_NODE] is
			-- kids of this node
		require
			not_leaf: not is_page
		deferred
		end

feature {PDF_DOCUMENT} -- Element change

	empty_kids is
		do
			kids.wipe_out
		end
		
feature -- Status report

	is_page : BOOLEAN is
			-- is this a page (leaf)
		deferred
		end
		
feature {PDF_DOCUMENT, PDF_PAGE_TREE_NODE} -- Element change

	set_parent (a_parent : PDF_PAGES) is
			-- 
		require
			exists: a_parent /= Void
			acyclic: a_parent.to_tree_node /= Current
		do
			parent := a_parent
		ensure
			parent = a_parent
		end

	add_kid (a_kid : PDF_PAGE_TREE_NODE) is
			-- add `a_page' page as last kid
		require
			a_kid /= Void
			not_leaf: not is_page
		local
			current_pages : PDF_PAGES
		do
			current_pages ?= Current
			check
				current_pages /= Void
			end
			a_kid.set_parent (current_pages)
			kids.put_last (a_kid)
		ensure
			kids.has (a_kid) and a_kid.parent = Current
		end

feature  {PDF_OBJECT} -- Conversion

	to_tree_node : PDF_PAGE_TREE_NODE is
			-- 
		do
			Result := Current
		end
		
end -- class PDF_PAGE_TREE_NODE
