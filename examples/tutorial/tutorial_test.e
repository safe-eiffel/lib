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

	document : FO_DOCUMENT
	writer : FO_DOCUMENT_WRITER

	section_title, section_text : FO_BLOCK

feature -- Constants

	color_red : FO_COLOR is once create Result.make_rgb (255,0,0) end
	color_black : FO_COLOR is once create Result.make_rgb (0,0,0) end
	color_green : FO_COLOR is once create Result.make_rgb (0,255,0) end
	color_blue : FO_COLOR is once create Result.make_rgb (0,0,255) end

feature  -- Basic operations

	create_document (file_name : STRING) is
			-- create `document' for writing into `file_name'.
		require
			file_name_not_void: file_name /= Void
		do
			create writer.make (file_name)
			create document.make (writer)
		ensure
			writer_not_void: writer /= Void
			document_not_void: document /= Void
		end

feature {NONE} -- Implementation

	append_section (title, text : STRING) is
			-- Append section with `title' and `text'.
		local
			title_font, text_font : FO_FONT
			inline : FO_INLINE
		do
			create section_title.make (title_margins)
			create section_text.make (text_margins)
			font_factory.find_font (title_family, font_factory.weigth_bold,font_factory.style_normal, pt (12))
			title_font := font_factory.last_font
			font_factory.find_font (text_family, font_factory.weigth_normal, font_factory.style_normal, pt (14))
			text_font := font_factory.last_font

			create inline.make_with_font (title, title_font)
			section_title.append (inline)
			section_title.enable_keep_with_next


			create inline.make_with_font (text, text_font)
			section_text.append (inline)
			section_text.enable_keep_with_next

			document.append_block (section_title)
			document.append_block (section_text)
		end

	title_family : STRING is "Helvetica"

	title_margins : FO_MARGINS is
		once
			create Result.set (cm (0), cm (0.25), cm (0), cm (0.75))
		end

	text_family : STRING is "Times"

	text_margins : FO_MARGINS is
		once
			create Result.set (cm (0), cm (0), cm (0), cm (0.25))
		end

end
