note
	description: "Summary description for {TTF_POSTSCRIPT_RECORD} 'post' table."
	documentation: "{
		Fixed 	Version 	0x00010000 for version 1.0
							0x00020000 for version 2.0
							0x00025000 for version 2.5 (deprecated)
							0x00030000 for version 3.0
		Fixed 	italicAngle 	Italic angle in counter-clockwise degrees from the vertical. Zero for upright text, negative for text that leans to the right (forward).
		FWord 	underlinePosition 	This is the suggested distance of the top of the underline from the baseline (negative values indicate below baseline).
									The PostScript definition of this FontInfo dictionary key (the y coordinate of the center of the stroke) is not used for historical reasons. The value of the PostScript key may be calculated by subtracting half the underlineThickness from the value of this field.
		FWord 	underlineThickness 	Suggested values for the underline thickness.
		ULONG 	isFixedPitch 	Set to 0 if the font is proportionally spaced, non-zero if the font is not proportionally spaced (i.e. monospaced).
		ULONG 	minMemType42 	Minimum memory usage when an OpenType font is downloaded.
		ULONG 	maxMemType42 	Maximum memory usage when an OpenType font is downloaded.
		ULONG 	minMemType1 	Minimum memory usage when an OpenType font is downloaded as a Type 1 font.
		ULONG 	maxMemType1 	Maximum memory usage when an OpenType font is downloaded as a Type 1 font.
	}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_POSTSCRIPT_RECORD
create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (otf : OPEN_TYPE_FONT_FILE)
		do
			otf.read_integer_32 --Fixed 	Version 	0x00010000 for version 1.0
			Version := otf.last_integer_32
			otf.read_integer_32 --Fixed 	italicAngle 	Italic angle in counter-clockwise degrees from the vertical. Zero for upright text, negative for text that leans to the right (forward).
			italicAngle := otf.last_integer_32
			otf.read_integer_32 --FWord 	underlinePosition 	This is the suggested distance of the top of the underline from the baseline (negative values indicate below baseline).
			underlinePosition := otf.last_integer_32
			otf.read_integer_32 --FWord 	underlineThickness 	Suggested values for the underline thickness.
			underlineThickness := otf.last_integer_32
			otf.read_natural_32 --ULONG 	isFixedPitch 	Set to 0 if the font is proportionally spaced, non-zero if the font is not proportionally spaced (i.e. monospaced).
			isFixedPitch := otf.last_natural_32
			otf.read_natural_32 --ULONG 	minMemType42 	Minimum memory usage when an OpenType font is downloaded.
			minMemType42 := otf.last_natural_32
			otf.read_natural_32 --ULONG 	maxMemType42 	Maximum memory usage when an OpenType font is downloaded.
			maxMemType42 := otf.last_natural_32
			otf.read_natural_32 --ULONG 	minMemType1 	Minimum memory usage when an OpenType font is downloaded as a Type 1 font.
			minMemType1 := otf.last_natural_32
			otf.read_natural_32 --ULONG 	maxMemType1 	Maximum memory usage when an OpenType font is downloaded as a Type 1 font.
			maxMemType1 := otf.last_natural_32
		end

feature -- Access

	Version : 	INTEGER_32
	italicAngle 	: INTEGER_32
	underlinePosition : INTEGER_32 -- FWord
	underlineThickness 	: INTEGER_32 -- FWord
	isFixedPitch : NATURAL_32
	minMemType42 : NATURAL_32
	maxMemType42 : NATURAL_32
	minMemType1 : NATURAL_32
	maxMemType1 : NATURAL_32

end
