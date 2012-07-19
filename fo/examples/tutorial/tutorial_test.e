indexing
	description: "FO tutorial tests."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	TUTORIAL_TEST

inherit

	FO_SHARED_FONT_FACTORY
	FO_MEASUREMENT_ROUTINES

feature -- Access

	document : FO_DOCUMENT is
		do
			Result := document_cell.item
		end

	writer : FO_DOCUMENT_WRITER

	chapter_title : FO_BLOCK

	section_title : FO_BLOCK

	section_text : FO_BLOCK

	chapter_outline : FO_OUTLINE_NODE
	section_outline : FO_OUTLINE_NODE
	outlines : FO_OUTLINES

	emphasized_inline (s : STRING) : FO_INLINE is
		do
			create Result.make_with_font (s, emphasis_text_font)
		end

	bolded_inline (s : STRING) : FO_INLINE is
		do
			create Result.make_with_font (s, bold_text_font)
		end

feature -- Color Constants

	color_red : FO_COLOR is once create Result.make_rgb (255,0,0) end
	color_black : FO_COLOR is once create Result.make_rgb (0,0,0) end
	color_green : FO_COLOR is once create Result.make_rgb (0,255,0) end
	color_blue : FO_COLOR is once create Result.make_rgb (0,0,255) end

feature -- Font Constants

	title_family : STRING is "Helvetica"
	title_font_height : INTEGER is 12

	text_family : STRING is "Times"
	text_font_height : INTEGER is 14

	chapter_family : STRING is "Helvetica"
	chapter_font_height : INTEGER is 14

	chapter_title_font : FO_FONT is
		once
			font_factory.find_font (chapter_family, font_factory.weigth_bold,font_factory.style_normal, pt (chapter_font_height))
			Result := font_factory.last_font
		end

	section_title_font : FO_FONT is
		once
			font_factory.find_font (title_family, font_factory.weigth_bold,font_factory.style_normal, pt (title_font_height))
			Result := font_factory.last_font
		end

	text_font : FO_FONT is
		once
			font_factory.find_font (text_family, font_factory.weigth_normal, font_factory.style_normal, pt (text_font_height))
			Result := font_factory.last_font
		end

	emphasis_text_font : FO_FONT is
		once
			font_factory.find_font (text_family, font_factory.weigth_normal, font_factory.style_italic, pt (text_font_height))
			Result := font_factory.last_font
		end

	bold_text_font : FO_FONT is
		once
			font_factory.find_font (text_family, font_factory.weigth_bold, font_factory.style_normal, pt (text_font_height))
			Result := font_factory.last_font
		end

feature -- Margin Constants


	title_margins : FO_MARGINS is
		once
			create Result.set (cm (0), cm (0.25), cm (0), cm (0.75))
		end
	text_margins : FO_MARGINS is
		once
			create Result.set (cm (0), cm (0), cm (0), cm (0.25))
		end

	chapter_margins : FO_MARGINS is
		once
			create Result.set (cm (0), cm (1), cm (0), cm (0.5))
		end

feature  -- Basic operations

	create_document (file_name : STRING) is
			-- create `document' for writing into `file_name'.
		require
			file_name_not_void: file_name /= Void
			document_void: document = Void
		local
			a_document : FO_DOCUMENT
		do
			create writer.make (file_name)
			create a_document.make (writer)
			document_cell.put (a_document)
			create outlines.make
			document.set_outlines (outlines)
			document.open
		ensure
			writer_not_void: writer /= Void
			document_not_void: document /= Void
		end

	append_section (title, text : STRING) is
			-- Append section with `title' and `text'.
		local
			inline : FO_INLINE
			target : FO_TARGET
		do
			create section_title.make (title_margins)
			create target.make (title)
			section_title.set_target (target)

			create inline.make_with_font (title, section_title_font)
			section_title.append (inline)
			section_title.enable_keep_with_next

			create section_outline.make_child (chapter_outline, title, create {FO_DESTINATION}.make (target.name))
			create section_text.make (text_margins)
			create inline.make_with_font (text, text_font)
			section_text.append (inline)
			section_text.enable_keep_with_next

			document.append_block (section_title)
			document.append_block (section_text)
		end

	append_chapter (title : STRING) is
		do
			create chapter_title.make_center (create {FO_MARGINS}.set (mm (10), mm (10), mm (10), mm (10)))
			chapter_title.append (create {FO_INLINE}.make_with_font (title, chapter_title_font))
			chapter_title.set_target (create {FO_TARGET}.make (title))

			if document.page_count > 1 then
				chapter_title.enable_page_break_before
			end
			document.append_block (chapter_title)

			create chapter_outline.make_root (title, create {FO_DESTINATION}.make (chapter_title.target.name))
			document.outlines.put_last (chapter_outline)
		end

feature {} -- Implementation

	document_cell : DS_CELL[FO_DOCUMENT] is
		once
			create Result.make (Void)
		end

end
