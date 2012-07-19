note
	description: "OpenType font header - 'head' table."
	documentation:"{
		Fixed 	Table version number 	0x00010000 for version 1.0.
		Fixed 	fontRevision 	Set by font manufacturer.
		ULONG 	checkSumAdjustment 	To compute: set it to 0, sum the entire font as ULONG, then store 0xB1B0AFBA - sum.
		ULONG 	magicNumber 	Set to 0x5F0F3CF5.
		USHORT 	flags 	Bit 0: Baseline for font at y=0;
			Bit 1: Left sidebearing point at x=0;
			Bit 2: Instructions may depend on point size;
			Bit 3: Force ppem to integer values for all internal scaler math; may use fractional ppem sizes if this bit is clear;
			Bit 4: Instructions may alter advance width (the advance widths might not scale linearly);
			Bits 5-10: These should be set according to Apple's specification . However, they are not implemented in OpenType.
			Bit 11: Font data is 'lossless,' as a result of having been compressed and decompressed with the Agfa MicroType Express engine.
			Bit 12: Font converted (produce compatible metrics)
			Bit 13: Font optimised for ClearType
			Bit 14: Reserved, set to 0
			Bit 15: Reserved, set to 0
		USHORT 	unitsPerEm 	Valid range is from 16 to 16384. This value should be a power of 2 for fonts that have TrueType outlines.
		LONGDATETIME 	created 	Number of seconds since 12:00 midnight, January 1, 1904. 64-bit integer
		LONGDATETIME 	modified 	Number of seconds since 12:00 midnight, January 1, 1904. 64-bit integer
		SHORT 	xMin 	For all glyph bounding boxes.
		SHORT 	yMin 	For all glyph bounding boxes.
		SHORT 	xMax 	For all glyph bounding boxes.
		SHORT 	yMax 	For all glyph bounding boxes.
		USHORT 	macStyle 	Bit 0: Bold (if set to 1);
			Bit 1: Italic (if set to 1)
			Bit 2: Underline (if set to 1)
			Bit 3: Outline (if set to 1)
			Bit 4: Shadow (if set to 1)
			Bit 5: Condensed (if set to 1)
			Bit 6: Extended (if set to 1)
			Bits 7-15: Reserved (set to 0).
		USHORT 	lowestRecPPEM 	Smallest readable size in pixels.
		SHORT 	fontDirectionHint 	0: Fully mixed directional glyphs;
			1: Only strongly left to right;
			2: Like 1 but also contains neutrals;
			-1: Only strongly right to left;
			-2: Like -1 but also contains neutrals. 1
		SHORT 	indexToLocFormat 	0 for short offsets, 1 for long.
		SHORT 	glyphDataFormat 	0 for current format.
	}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_HEADER_RECORD

create
	make_from_file

feature {} -- Initialization

	make_from_file (otf : OPEN_TYPE_FONT_FILE)
		do
					otf.read_integer_32 --Fixed 	Table version number 	0x00010000 for version 1.0.
					otf.read_integer_32 --Fixed 	fontRevision 	Set by font manufacturer.
					otf.read_natural_32 --ULONG 	checkSumAdjustment 	To compute: set it to 0, sum the entire font as ULONG, then store 0xB1B0AFBA - sum.
					otf.read_natural_32 --ULONG 	magicNumber 	Set to 0x5F0F3CF5.
					otf.read_natural_16 --USHORT 	flags 	Bit 0: Baseline for font at y=0;
					flags := otf.last_natural_16
					otf.read_natural_16 --USHORT 	unitsPerEm 	Valid range is from 16 to 16384. This value should be a power of 2 for fonts that have TrueType outlines.
					unitsPerEm := otf.last_natural_16
					otf.read_integer_64 --LONGDATETIME 	created 	Number of seconds since 12:00 midnight, January 1, 1904. 64-bit integer
					otf.read_integer_64 --LONGDATETIME 	modified 	Number of seconds since 12:00 midnight, January 1, 1904. 64-bit integer
					otf.read_integer_16 --SHORT 	xMin 	For all glyph bounding boxes.
					xMin := otf.last_integer_16
					otf.read_integer_16 --SHORT 	yMin 	For all glyph bounding boxes.
					yMin := otf.last_integer_16
					otf.read_integer_16 --SHORT 	xMax 	For all glyph bounding boxes.
					xMax := otf.last_integer_16
					otf.read_integer_16 --SHORT 	yMax 	For all glyph bounding boxes.
					yMax := otf.last_integer_16
					otf.read_natural_16 --USHORT 	macStyle 	Bit 0: Bold (if set to 1);
					macStyle := otf.last_natural_16
					otf.read_natural_16 --USHORT 	lowestRecPPEM 	Smallest readable size in pixels.
					otf.read_integer_16 --SHORT 	fontDirectionHint 	0: Fully mixed directional glyphs;
					otf.read_integer_16 --SHORT 	indexToLocFormat 	0 for short offsets, 1 for long.
					otf.read_integer_16 --SHORT 	glyphDataFormat 	0 for current format.
		end

feature -- Access

		flags : INTEGER

		unitsPerEm : NATURAL_16
     		--Valid range is from 16 to 16384. This value should be a power of 2 for fonts that have TrueType outlines.

		xMin : INTEGER_16
		yMin : INTEGER_16
		xMax : INTEGER_16
		yMax : INTEGER_16
		macStyle : INTEGER_32

end
