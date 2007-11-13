indexing

	description:

		"Factories of fonts."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_FONT_FACTORY

inherit
	PDF_ENCODING_CONSTANTS
		export
			{ANY} Encoding_mac, Encoding_pdf, Encoding_standard, Encoding_winansi
		end

	FO_SHARED_DEFAULTS

creation
	make

feature {NONE} -- Initialization

	make is
		local
			key : STRING
			equality_tester : KL_EQUALITY_TESTER[STRING]
		do
			create font_table.make (10)
			create families.make (10)
			create equality_tester
			families.set_equality_tester (equality_tester)
			create dummy_document.make

			key := font_key ("Helvetica", "", "")
			add_font ("Helvetica", "Helvetica", "","")
			add_font ("Helvetica-Bold", "Helvetica", "bold", "")
			add_font ("Helvetica-Oblique", "Helvetica", "", "italic")
			add_font ("Helvetica-BoldOblique", "Helvetica", "bold", "italic")

			add_font ("Times-Roman", "Times", "","")
			add_font ("Times-Bold", "Times", "bold", "")
			add_font ("Times-Italic", "Times", "", "italic")
			add_font ("Times-BoldItalic", "Helvetica", "bold", "italic")

			add_font ("Courier", "Courier", "","")
			add_font ("Courier-Bold", "Courier", "bold", "")
			add_font ("Courier-Oblique", "Courier", "", "italic")
			add_font ("Courier-BoldOblique", "Courier", "bold", "italic")
		end

feature -- Access

	last_font : FO_FONT
			-- Last font found.

	default_font : FO_FONT is
			-- Default font.
		do
			if default_font_impl = Void then
				find_font (shared_defaults.font_family, "", "", shared_defaults.font_size)
				default_font_impl := last_font
			end
			Result := default_font_impl
		ensure
			default_font_not_void: Result /= Void
		end

feature -- Status report

	is_default (a_font : FO_FONT) : BOOLEAN is
			-- Is `a_font' same as `default_font'?
		require
			a_font_not_void: a_font /= Void
		do
			Result := default_font.is_equal (a_font)
		end

	found : BOOLEAN
			-- Has last `find_font' or `find_font_weight_style_encoding' operation succeeded?

	valid_family (family : STRING) : BOOLEAN is
			-- is `family' a valid font family ?
		do
			if family /= Void then
				Result := families.has (family)
			end
		ensure
			definition: Result implies family /= Void
		end

	valid_weight (weight : STRING) : BOOLEAN is
			-- is `weight' a valid font weight ?
		do
			if weight /= Void then
				Result := weight.is_equal (Weigth_normal)
				Result := Result or else weight.is_equal (Weigth_bold)
			end
		ensure
			definition: Result implies weight /= Void
		end

	valid_style (style : STRING) : BOOLEAN is
			-- is `style' a valid font style ?
		do
			if style /= Void then
				Result := style.is_equal (Style_normal)
				Result := Result or else style.is_equal (Style_italic)
			end
		ensure
			definition: Result implies style /= Void
		end

feature -- Element change

	set_default_font (new_font: FO_FONT) is
			-- Set `default_font' to `new_font'.
		require
			new_font_not_void: new_font /= Void
		do
			default_font_impl := new_font
		ensure
			default_font_set: default_font = new_font
		end

feature -- Constants

	weigth_normal : STRING is
			-- Normal weight.
		once
			create Result.make(0)
		ensure
			weight_normal_not_void: weigth_normal /= Void
			weight_normal_empty: weigth_normal.is_empty
		end

	style_normal : STRING is
		once
			Result := weigth_normal
		ensure
			style_normal_not_void: style_normal /= Void
			style_normal_is_empty: style_normal.is_empty
		end

	weigth_bold : STRING is
		once
			Result := "bold"
		ensure
			weight_bold_not_void: weigth_bold /= Void
		end

	style_italic : STRING is
		once
			Result := "italic"
		ensure
			style_italic_not_void: style_italic /= Void
		end

	supported_encodings : DS_LINKED_LIST[STRING] is
			-- List of supported encodings.
		local
			tester : KL_EQUALITY_TESTER[STRING]
		once
			create Result.make
			create tester
			Result.set_equality_tester (tester)
			Result.put_last (dummy_document.encoding_mac)
			Result.put_last (dummy_document.encoding_pdf)
			Result.put_last (dummy_document.encoding_standard)
			Result.put_last (dummy_document.encoding_winansi)
		ensure
			supported_encodings_not_void: Result /= Void
			not_void_encoding: not Result.has (Void)
		end

feature -- Basic operations

	find_font (family, weight, style : STRING; size : FO_MEASUREMENT) is
			-- Find font with `family', `weight', `style', and shared_defaults.font_encoding.
		require
			family_not_void: family /= Void
			weight_not_void: weight /= Void
			style_not_void: style /= Void
			size_not_void: size /= Void
		do
			find_font_weight_style_encoding (family, weight, style, shared_defaults.font_encoding, size)
		ensure
			last_font_not_void: last_font /= Void
			last_font_size: last_font.size.is_equal (size)
			default_font_when_not_found: not found implies is_default (last_font)
			valid_attributes: found implies (valid_family (family) and valid_style (style) and valid_weight (weight))
			default_font_encoding: last_font.encoding.is_equal (shared_defaults.font_encoding)
		end

	find_font_weight_style_encoding (family, weight, style, encoding : STRING; size : FO_MEASUREMENT) is
			-- Find font with `name', `weight', `style', `encoding'.
		require
			family_not_void: family /= Void
			weight_not_void: weight /= Void
			style_not_void: style /= Void
			encoding_not_void: encoding /= Void
			size_not_void: size /= Void
		do
			last_font := Void
			found := False
			font_table.search (font_key (family, weight, style))
			if font_table.found then
				if supported_encodings.has (encoding) then
					dummy_document.find_font (font_table.found_item, encoding)
					if dummy_document.last_font /= Void then
						create last_font.make (family, weight, style, dummy_document.last_font, size)
						found := True
					end
				end
			end
			if last_font = Void then
				find_font_weight_style_encoding (default_font.name, default_font.weight, default_font.style, default_font.encoding,size)
			end
		ensure
			last_font_not_void: last_font /= Void
			last_font_size: last_font.size.is_equal (size)
			default_font_when_not_found: not found implies is_default (last_font)
			valid_attributes: found implies (valid_family (family) and valid_style (style) and valid_weight (weight))
		end

feature {NONE} -- Implementation

	add_font (actual_name, family_name, weight, style : STRING) is
		require
			actual_name_exists: actual_name /= Void
			family_name_exists: family_name /= Void
			weight_exists: weight /= Void
			style_exists: style /= Void
		do
			font_table.force (actual_name, font_key (family_name, weight, style))
			families.force (family_name)
		end

	font_table : DS_HASH_TABLE [STRING, STRING]

	font_key (name, weight, style : STRING) : STRING is
		do
			create Result.make (name.count + weight.count + style.count + 2)
			Result.append_string (name)
			Result.append_character ('-')
			Result.append_string (weight)
			Result.append_character ('-')
			Result.append_string (style)
		end

	families : DS_HASH_SET [STRING]

	dummy_document : PDF_DOCUMENT

	default_font_impl : FO_FONT

end
