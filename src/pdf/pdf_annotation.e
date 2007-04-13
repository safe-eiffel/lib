indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_ANNOTATION

inherit
	PDF_OBJECT
		redefine
			put_pdf
		end

feature -- Access

	type : PDF_NAME is
		once
			Result := names.annot
		end

	subtype : PDF_NAME is
		deferred
		end

	rect : PDF_RECTANGLE

	border_dash : ARRAY[INTEGER]

feature -- Measurement

	 border_width : INTEGER

feature -- Status report

	is_border_beveled : BOOLEAN is
		do
			Result := border_style = border_style_solid
		end


	is_border_dashed : BOOLEAN is
		do
			Result := border_style = border_style_dashed
		end

	is_border_inset : BOOLEAN is
		do
			Result := border_style = border_style_inset
		end

	is_border_none : BOOLEAN is
		do
			Result := border_style = border_style_none
		end

	is_border_solid : BOOLEAN is
		do
			Result := border_style = border_style_solid
		end

	is_border_underline : BOOLEAN is
		do
			Result := border_style = border_style_underline
		end

feature -- Element change

	set_border_width (a_width : INTEGER) is
			-- Set `border_width' to `a_width'
		require
			a_width_positive: a_width >= 0
		do
			border_width := a_width
		ensure
			border_width_set: border_width = a_width
		end

	set_border_solid is
			-- Set a solid rectangle surrounding the annotation.
		do
			border_style := border_style_solid
			border_width := 1
		ensure
			is_border_solid: is_border_solid
			border_width_one: border_width = 1
		end

	set_border_dashed (dash_pattern : ARRAY[INTEGER]) is
			-- Set a dashed rectangle wrt `dash_pattern' surrounding the annotation.
		require
			dash_pattern_not_void: dash_pattern /= Void
			dash_pattern_one_element: dash_pattern.count > 0
		do
			border_style := border_style_dashed
			border_dash := dash_pattern
			border_width := 1
		ensure
			is_border_dashed: is_border_dashed
			border_dash_set: border_dash = dash_pattern
			border_width_one: border_width = 1
		end

	set_border_beveled is
			-- Set a simulated embossed rectangle that appears to be raised above the surface of the page.
		do
			border_style :=  border_style_beveled
			border_width := 1
		ensure
			is_border_beveled: is_border_beveled
			border_width_one: border_width = 1
		end

	set_border_inset is
			-- Set a simulated engraved rectangle that appears to be recessed below the surface of the page.
		do
			border_style :=  border_style_inset
			border_width := 1
		ensure
			is_border_inset: is_border_inset
			border_width_one: border_width = 1
		end

	set_border_underline is
			-- Set a single line along the bottom of the annotation rectangle.
		do
			border_style :=  border_style_underline
			border_width := 1
		ensure
			is_border_underline: is_border_underline
			border_width_one: border_width = 1
		end

	set_border_none is
		do
			border_style :=  border_style_none
			border_width := 0
		ensure
			is_border_none: is_border_none
			border_width_zero: border_width = 0
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	to_pdf : STRING is
		do
			Result := to_pdf_using_put_pdf
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	put_pdf (medium: PDF_OUTPUT_MEDIUM) is
		do
			-- Setup border_dictionary
			if not dictionary.has_key (names.bs.value) then
				dictionary.add_entry (names.bs.value, border_style_dictionary)
			else
				dictionary.replace_entry (names.bs.value, border_style_dictionary)
			end
			medium.put_string (object_header)
			dictionary.put_pdf (medium)
			medium.put_new_line
			medium.put_string (object_footer)
		end

	put_content (medium : PDF_OUTPUT_MEDIUM) is
		do
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	dictionary : PDF_DICTIONARY

	setup_dictionary is
		do
			create dictionary.make
			dictionary.add_entry (names.type.value, type)
			dictionary.add_entry (names.subtype.value, subtype)
			dictionary.add_entry (names.rect.value, rect)
		end

	border_style_dictionary : PDF_DICTIONARY is
		do
			create Result.make
			Result.add_entry (names.type.value, names.border)
			Result.add_entry (names.w.value, create {PDF_NUMBER}.from_integer (border_width))
			if not is_border_none then
				Result.add_entry (names.s.value, border_style_name)
				if is_border_dashed then
					Result.add_entry (names.d.value, create {PDF_ARRAY[INTEGER]}.make_from_array (border_dash))
				end
			end
		end

	border_style : INTEGER

	border_style_solid : INTEGER is 1
	border_style_dashed : INTEGER is 2
	border_style_beveled : INTEGER is 3
	border_style_inset : INTEGER is 4
	border_style_underline : INTEGER is 5
	border_style_none : INTEGER is 0

	border_style_name : PDF_NAME is
		require
			not_border_none: not is_border_none
		do
			inspect border_style
			when border_style_solid then
				Result := names.s
			when border_style_dashed then
				Result := names.d
			when border_style_beveled then
				Result := names.b
			when border_style_inset then
				Result := names.i
			when border_style_underline then
				Result := names.u
			else
			end
		ensure
			result_not_void: Result /= Void
		end

--S name (Optional) The border style:
--S (Solid) A solid rectangle surrounding the annotation.
--D (Dashed) A dashed rectangle surrounding the annotation. The dash pattern
--is specified by the D entry (see below).
--B (Beveled) A simulated embossed rectangle that appears to be raised above the
--surface of the page.
--I (Inset) A simulated engraved rectangle that appears to be recessed below the
--surface of the page.
--U (Underline) A single line along the bottom of the annotation rectangle.

invariant

	dictionary_not_void: dictionary /= Void

end
