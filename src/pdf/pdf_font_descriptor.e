indexing

	description: "Font Descriptor.  Required attributes."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_FONT_DESCRIPTOR
	
feature

	type : PDF_NAME	is
		-- Type name (Required) The type of PDF object that this dictionary describes; must be
		-- FontDescriptor for a font descriptor.
		once
			create Result.make ("FontDescriptor")
		end
		
	ascent : INTEGER
		-- Ascent number (Required) The maximum height above the baseline reached by glyphs in this
		-- font, excluding the height of glyphs for accented characters.

	cap_height : INTEGER
		-- CapHeight number (Required) The y coordinate of the top of flat capital letters, measured from
		-- the baseline.

	descent : INTEGER
		-- Descent number (Required) The maximum depth below the baseline reached by glyphs in this
		-- font. The value is a negative number.

	flags : INTEGER
		-- Flags integer (Required) A collection of flags defining various characteristics of the font
		-- (see Section 5.7.1, “Font Descriptor Flags”).

	font_b_box : PDF_RECTANGLE
		-- FontBBox rectangle (Required) A rectangle (see Section 3.8.3, “Rectangles”), expressed in the
		-- glyph coordinate system, specifying the font bounding box. This is the smallest
		-- rectangle enclosing the shape that would result if all of the glyphs of the
		-- font were placed with their origins coincident and then filled.

	font_name : PDF_NAME
		-- FontName name (Required) The PostScript name of the font. This should be the same as the
		-- value of BaseFont in the font or CIDFont dictionary that refers to this font
		-- descriptor.

	italic_angle : INTEGER
		-- ItalicAngle number (Required) The angle, expressed in degrees counterclockwise from the vertical,
		-- of the dominant vertical strokes of the font. (For example, the 9-o’clock
		-- position is 90 degrees, and the 3-o’clock position is –90 degrees.) The value is
		-- negative for fonts that slope to the right, as almost all italic fonts do.

	stem_v : INTEGER
		-- StemV number (Required) The width, measured in the x direction, of the dominant vertical
		-- stems of glyphs in the font.
		

end -- class PDF_FONT_DESCRIPTOR
