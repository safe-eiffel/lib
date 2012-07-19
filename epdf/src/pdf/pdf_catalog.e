indexing

	description: "PDF Catalog object. Root of document objects hierarchy. %
		% The catalog gathers the various components of the structure of a document.%
		% The most important (and mandatory) is the Page tree root.%
		% Other are : The outline hierarchy, article threads, named destinations and%
		% interactive forms.  They are not implemented in this version."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_CATALOG

inherit
	PDF_OBJECT
		rename
			make as make_object,
			names as pdf_names
		end

create
	make

feature {NONE} -- Initialization

	make (pages_root : PDF_PAGES; object_number : INTEGER) is
			-- make a catalog with `pages_root', known as `object_number'
		require
			pages_root_exists: pages_root /= Void
			object_number_valid: object_number >= 0
		do
			pages := pages_root
			make_object (object_number)
		end

feature -- Access

	pages : PDF_PAGES
			-- Root of page tree
			-- The pages of a document are accessed through a structure known as the page tree,
			-- which defines their ordering within the document. The tree structure allows PDF
			-- viewer applications to quickly open a document containing thousands of pages
			--- using only limited memory.

	outlines : PDF_OUTLINES
			-- PDF optional

	page_layout : PDF_NAME
			-- PDF optional

	page_mode : PDF_NAME
			-- PDF optional

	viewer_preferences : PDF_VIEWER_PREFERENCES

	names : PDF_DICTIONARY

feature {PDF_DOCUMENT} -- Element change

	set_pages (a_pages : PDF_PAGES) is
			--
		require
			a_pages /= Void
		do
			pages := a_pages
		ensure
			pages = a_pages
		end

	set_page_layout (p : PDF_NAME) is
			-- set page_layout
		require
			p_exists: p /= Void
		do
			page_layout := p
		ensure
			page_layout_set: page_layout = p
		end

	set_outlines (document_outlines : PDF_OUTLINES) is
			--
		require
			document_outlines_exists: document_outlines /= Void
		do
			outlines := document_outlines
		ensure
			outlines_set: outlines = document_outlines
		end

	set_page_mode (new_mode : PDF_NAME) is
			--
		require
			new_mode_exists: new_mode /= Void
		do
			page_mode := new_mode
		ensure
			page_mode_set: page_mode = new_mode
		end

	set_viewer_preferences (new_viewer_preferences : PDF_VIEWER_PREFERENCES) is
			--
		require
			new_viewer_preferences_exists: new_viewer_preferences /= Void
		do
			viewer_preferences := new_viewer_preferences
		ensure
			viewer_preferences_set: viewer_preferences = new_viewer_preferences
		end

	set_names (new_names : like names) is
			--
		require
			new_names_not_void: new_names /= Void
		do
			names := new_names
		ensure
			names_preferences_set: names = new_names
		end

feature -- Conversion

	to_pdf : STRING is
			--
		local
			ntype, npages, nlayout, noutlines, npagemode, nviewerpreferences : PDF_NAME
		do
			create Result.make (0)
			create ntype.make ("Type")
			create npages.make ("Pages")
			create nlayout.make ("PageLayout")
			create noutlines.make ("Outlines")
			create npagemode.make ("PageMode")
			create nviewerpreferences.make ("ViewerPreferences")
			Result.append_string (object_header)
			Result.append_string (begin_dictionary)
			Result.append_string (dictionary_entry (ntype, "/Catalog"))
			Result.append_string (dictionary_entry (npages, pages.indirect_reference))
			if page_layout /= Void and then not page_layout.value.is_empty then
				Result.append_string (dictionary_entry (nlayout, page_layout.to_pdf))
			end
			if outlines /= Void then
				Result.append_string (dictionary_entry (noutlines, outlines.indirect_reference))
			end
			if page_mode /= Void then
				Result.append_string (dictionary_entry (npagemode, page_mode.to_pdf))
			end
			if viewer_preferences /= Void then
				Result.append_string (dictionary_entry (nviewerpreferences, viewer_preferences.indirect_reference))
			end
			if names /= Void then
				Result.append_string (dictionary_entry (pdf_names.names, names.indirect_reference))
			end
			Result.append_string (end_dictionary)
			Result.append_string (object_footer)
		end

feature {NONE} -- Implementation

invariant
	pages_exist: pages /= Void

end -- class PDF_CATALOG
