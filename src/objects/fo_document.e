indexing

	description: 
	
		"Documents"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_DOCUMENT

create
	make

feature {NONE} -- Initialization

	make (new_page_rectangle: FO_RECTANGLE; new_writer : FO_DOCUMENT_WRITER) is
			-- Initialize `Current'.
		require
			new_writer_exists: new_writer /= Void
			new_writer_not_open: not new_writer.is_open
			new_page_rectangle_exists: new_page_rectangle /= Void
		do
			writer := new_writer
			page_rectangle := new_page_rectangle
			create margins.make
			create {DS_LINKED_LIST[FO_PAGE]}pages.make
			pages_cursor := pages.new_cursor
		ensure
			writer_set: writer = new_writer
			page_rectangle_set: page_rectangle = new_page_rectangle
		end

feature -- Access

	page_rectangle : FO_RECTANGLE
			-- Page rectangle.
	
	margins : FO_MARGINS
			-- Document margins.
	
	title : STRING
			-- Title.
		
	author : STRING
			-- Author.
		
	subject : STRING
			-- Subject.
		
	keywords : STRING
			-- Keywords.
		
	creator : STRING
			-- Creator.
		
	producer : STRING
			-- Producer.
		
	creation_date : DT_DATE_TIME
			-- Creation date.
		
	modification_date : DT_DATE_TIME
			-- Modification date.

	available_render_region : FO_RECTANGLE
			-- Currently available rendering region.

	header : FO_HEADER_FOOTER is
		do
			Result := current_section.header
		ensure
			definition: Result = current_section.header
		end
		
	
	footer : FO_HEADER_FOOTER is
		do
			Result := current_section.footer
		ensure
			definition: Result = current_section.footer
		end
		
	
	current_section : FO_SECTION
	
feature -- Measurement

	page_count : INTEGER is			
		do
			Result := pages.count
		end
		
feature -- Element change

	set_section (new_section: FO_SECTION) is
			-- Set `current_section' to `new_section'.
		require
			new_section_not_void: new_section /= Void
		do
			current_section := new_section
		ensure
			current_section_set: current_section = new_section
		end

	set_title (new_title : STRING) is
			-- Set `title' to `new_title'
		require
			new_title_exists: new_title /= Void
			not_open: not is_open
		do
			title := new_title
		ensure
			title_set: title = new_title
		end
		
	set_author (new_author : STRING) is
			-- Set `author' to `new_author'
		require
			new_author_exists: new_author /= Void
			not_open: not is_open
		do
			author := new_author
		ensure
			author_set: author = new_author
		end
		
	set_subject (new_subject : STRING) is
			-- Set `subject' to `new_subject'
		require
			new_subject_exists: new_subject /= Void
			not_open: not is_open
		do
			subject := new_subject
		ensure
			subject_set: subject = new_subject
		end
		
	set_keywords (new_keywords : STRING) is
			-- Set `keywords' to `new_keywords'
		require
			new_keywords_exist: new_keywords /= Void
			not_open: not is_open
		do
			keywords := new_keywords
		ensure
			keywords_set: keywords = new_keywords
		end
		
	set_creator (new_creator : STRING) is
			-- Set `creator' to `new_creator'
		require
			new_creator_exists: new_creator /= Void
			not_open: not is_open
		do
			creator := new_creator
		ensure
			creator_set: creator = new_creator
		end
		
	set_producer (new_producer : STRING) is
			-- Set `producer' to `new_producer'
		require
			new_producer_exists: new_producer /= Void
			not_open: not is_open
		do
			producer := new_producer
		ensure
			producer_set: producer = new_producer
		end
		
	set_creation_date (new_creation_date : DT_DATE_TIME) is
			-- Set `creation_date' to `new_creation_date'
		require
			new_creation_date_exists: new_creation_date /= Void
			not_open: not is_open
		do
			creation_date := new_creation_date
		ensure
			creation_date_set: creation_date = new_creation_date
		end
	
	set_modification_date (new_modification_date : DT_DATE_TIME) is
			-- Set `modification_date' to `new_modification_date'
		require
			new_modification_date_exists: new_modification_date /= Void
			not_open: not is_open
		do
			modification_date := new_modification_date
		ensure
			modification_date_set: modification_date = new_modification_date
		end
	
	set_margins (new_margins : FO_MARGINS) is
			-- Set `margins' to `new_margins'
		require
			new_margins_exist: new_margins /= Void
			not_open: not is_open
		do
			margins := new_margins
		ensure
			margins_set: margins = new_margins
		end
		

feature -- Access

	writer : FO_DOCUMENT_WRITER
			-- Writer
	
feature -- Measurement

feature -- Status report

	is_open : BOOLEAN
			-- Is the document open ?
					
feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_header (a_header : FO_HEADER_FOOTER) is	
			-- Set `header' to `a_header'.
		require
			a_header_not_void: a_header /= Void
			is_open: is_open
		do
			current_section.set_header (a_header)
		end
		
	set_footer (a_footer : FO_HEADER_FOOTER) is
			-- Set `footer' to `a_footer'.
		require
			a_footer_not_void: a_footer /= Void
			is_open: is_open
		do
			current_section.set_footer (a_footer)
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	do_page_break is
			-- Break current page.
		local
			page : FO_PAGE
		do
			pages_cursor.item.set_rendered_region (available_render_region)
			if current_page.is_text_mode then
				current_page.end_text
			end
			show_page_margins
			pdf_document.add_page
			create page.make (pdf_document.last_page, current_section)
			pages.put_last (page)
			pages_cursor.finish
			available_render_region := margins.content_region (page_rectangle)
--			if not current_page.is_text_mode then
--				current_page.begin_text
--			end
		end
		
	append_block (block : FO_BLOCK) is
			-- Append `block' of text.
		do
--			if block.is_keep_with_next then
--				if last_unbreakable = Void then
--					create last_unbreakable.make
--				end
--				last_unbreakable.unbreakables.put_last (block)
--			else
--				if last_unbreakable /= Void then
--					last_unbreakable.unbreakables.put_last (block)
--					last_unbreakable.pre_render (available_render_region)
--					if last_unbreakable.height > available_render_region then
--						do_page_break
--					end
--					last_unbreakable.render_start (current, available_render_region)
--					last_unbreakable := Void
--				else
--					render_renderable (block)
--				end	
--			end
			render_renderable (block)
		end

	append_image (image : FO_IMAGE) is
		do
			render_renderable (image)
		end
		
	append_row (row : FO_ROW) is	
			-- Append `row'.
		do
			render_renderable (row)
		end

	open is
			-- Open.
		local
			page : FO_PAGE
		do
			writer.open
			if writer.is_open then
				is_open := True
				if title /= Void then
					writer.document.information.set_title (title)
				end
				if author /= Void then
					writer.document.information.set_author (author)
				end
				if subject /= Void then
					writer.document.information.set_subject (subject)
				end
				if keywords /= Void  then
					writer.document.information.set_keywords (keywords)
				end
				if creator /= Void then
					writer.document.information.set_creator (creator)
				end
				if producer /= Void then
					writer.document.information.set_producer (producer)
				end
				if creation_date /= Void then
					writer.document.information.set_creation_date (creation_date)
				end
				if modification_date /= Void then
					writer.document.information.set_modification_date (modification_date)
				end
				available_render_region := margins.content_region (page_rectangle)
				create current_section.make ("default", page_rectangle, margins)
				create page.make (writer.current_page, current_section)
				pages.put_last (page)
				pages_cursor.finish
				pdf_document.set_default_mediabox (page_rectangle.as_pdf)
				current_page.set_mediabox (page_rectangle.as_pdf)
			end
		end
		
	close is
			-- Close.
		require
			is_open: is_open
		do
			show_page_margins
			render_header_footer
			writer.close
			if not writer.is_open then
				is_open := False
			end
		ensure
			closed: not is_open
		end
	
feature {FO_RENDERABLE} -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {FO_RENDERABLE} -- Access

	pdf_document : PDF_DOCUMENT is do Result := writer.document end

	current_page : PDF_PAGE is
		do
			Result := pages_cursor.item.page
		end
		
feature {NONE} -- Implementation

	render_renderable (renderable : FO_RENDERABLE) is		
		local
			borderable : FO_BORDER_ABLE
			unbreakable : FO_UNBREAKABLE
		do
			if renderable.is_keep_with_next then
				if last_unbreakable = Void then
					create last_unbreakable.make
				end
				last_unbreakable.unbreakables.put_last (renderable)
			else
				if last_unbreakable /= Void then
					unbreakable := last_unbreakable
					last_unbreakable := Void
					unbreakable.unbreakables.put_last (renderable)
					unbreakable.pre_render (available_render_region)
					if unbreakable.height > available_render_region.height then
						do_page_break
					end
					render_renderable (unbreakable) --unbreakable.render_start (current, available_render_region)
				else
					borderable ?= renderable
					if renderable.is_page_break_before then
						do_page_break
					end
					from
						renderable.render_start(Current, available_render_region)
						if borderable /= Void and then renderable.last_rendered_region /= Void then
							borderable.render_borders (Current, renderable.last_rendered_region)
						end
					until
						renderable.is_render_off
					loop
						do_page_break
						renderable.render_forth (Current, margins.content_region (page_rectangle))
						if borderable /= Void then
							borderable.render_borders (Current, renderable.last_rendered_region)
						end
					end
					available_render_region := available_render_region.shrinked_top (renderable.last_rendered_region.height)
				end
			end
		end
	
	render_header_footer is
			-- Render header and footers on rendered pages.
		local
			header_region, footer_region : FO_RECTANGLE
			page_section : FO_SECTION
		do
			from	
				pages_cursor.start
				current_page_number := 1
			until
				pages_cursor.off
			loop
				page_section := pages_cursor.item.section
				--| render header
				if page_section.header /= Void then
					--| header region
					create header_region.make
					header_region.set (
						page_section.page_rectangle.left + page_section.margins.left,
						page_section.page_rectangle.top - page_section.margins.top , -- + header.separation,
						page_section.page_rectangle.right - page_section.margins.right,
						page_section.page_rectangle.top)
					header.render_start (Current, header_region)
					header.render_borders (Current, header.last_rendered_region)
				end
				--| render footer
				if page_section.footer /= Void then
					--| footer region
					create footer_region.make
					footer_region.set (
						page_section.page_rectangle.left + page_section.margins.left,
						page_section.page_rectangle.bottom,
						page_section.page_rectangle.right - page_section.margins.right,
						page_section.page_rectangle.bottom + page_section.margins.bottom - page_section.footer.separation)

					footer.render_start (Current, footer_region)
					footer.render_borders (Current, footer.last_rendered_region)
				end
				current_page_number := current_page_number + 1
				pages_cursor.forth
			end
		end

	show_page_margins is		
		local
			r : FO_RECTANGLE
		do
			debug ("fo_show_page_margins")
				if current_page.is_text_mode then
					current_page.end_text
				end
				current_page.gsave
				current_page.set_line_dash (<<1, 3, 3, 3>>, 0)
				r := margins.content_region (page_rectangle)
				current_page.rectangle (r.left.as_points, r.bottom.as_points, r.width.as_points, r.height.as_points)
				current_page.stroke
				current_page.grestore
			end
		end

	pages : DS_LIST[FO_PAGE]
	
	pages_cursor : DS_LIST_CURSOR[FO_PAGE]
		
	last_unbreakable : FO_UNBREAKABLE
	
feature {FO_SPECIAL_INLINE} -- Implementation

	current_page_number : INTEGER
				
invariant
	writer_exists: writer /= Void

end
