note
	description: "Summary description for {TTF_HORIZONTAL_HEADER_RECORD} 'head' OpenType table."
	documentation: "{
			Fixed 	Table version number 	0x00010000 for version 1.0.
			FWORD 	Ascender 	Typographic ascent. (Distance from baseline of highest ascender)
			FWORD 	Descender 	Typographic descent. (Distance from baseline of lowest descender)
			FWORD 	LineGap 	Typographic line gap.
					Negative LineGap values are treated as zero
					in Windows 3.1, System 6, and
					System 7.
			UFWORD 	advanceWidthMax 	Maximum advance width value in 'hmtx' table.
			FWORD 	minLeftSideBearing 	Minimum left sidebearing value in 'hmtx' table.
			FWORD 	minRightSideBearing 	Minimum right sidebearing value; calculated as Min(aw - lsb - (xMax - xMin)).
			FWORD 	xMaxExtent 	Max(lsb + (xMax - xMin)).
			SHORT 	caretSlopeRise 	Used to calculate the slope of the cursor (rise/run); 1 for vertical.
			SHORT 	caretSlopeRun 	0 for vertical.
			SHORT 	caretOffset 	The amount by which a slanted highlight on a glyph needs to be shifted to produce the best appearance. Set to 0 for non-slanted fonts
			SHORT 	(reserved) 	set to 0
			SHORT 	(reserved) 	set to 0
			SHORT 	(reserved) 	set to 0
			SHORT 	(reserved) 	set to 0
			SHORT 	metricDataFormat 	0 for current format.
			USHORT 	numberOfHMetrics 	Number of hMetric entries in 'hmtx' table	
	}"

	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_HORIZONTAL_HEADER_RECORD

create
	make_from_file

feature {} -- Initialization

	make_from_file (otf : OPEN_TYPE_FONT_FILE)
		do
				otf.read_natural_32 --Fixed 	Table version number 	0x00010000 for version 1.0.
				otf.read_integer_16 --FWORD 	Ascender 	Typographic ascent. (Distance from baseline of highest ascender)
				ascender := otf.last_integer_16
				otf.read_integer_16 --FWORD 	Descender 	Typographic descent. (Distance from baseline of lowest descender)
				descender := otf.last_integer_16
				otf.read_integer_16 --FWORD 	LineGap 	Typographic line gap.
				linegap := otf.last_integer_16
				otf.read_natural_16 --UFWORD 	advanceWidthMax 	Maximum advance width value in 'hmtx' table.
				advanceWidthMax := otf.last_natural_16
				otf.read_integer_16 --FWORD 	minLeftSideBearing 	Minimum left sidebearing value in 'hmtx' table.
				minLeftSideBearing := otf.last_integer_16
				otf.read_integer_16 --FWORD 	minRightSideBearing 	Minimum right sidebearing value; calculated as Min(aw - lsb - (xMax - xMin)).
				minRightSideBearing  := otf.last_integer_16
				otf.read_integer_16 --FWORD 	xMaxExtent 	Max(lsb + (xMax - xMin)).
				xMaxExtent  := otf.last_integer_16
				otf.read_integer_16 --SHORT 	caretSlopeRise 	Used to calculate the slope of the cursor (rise/run); 1 for vertical.
				caretSlopeRise  := otf.last_integer_16
				otf.read_integer_16 --SHORT 	caretSlopeRun 	0 for vertical.
				caretSlopeRun  := otf.last_integer_16
				otf.read_integer_16 --SHORT 	caretOffset 	The amount by which a slanted highlight on a glyph needs to be shifted to produce the best appearance. Set to 0 for non-slanted fonts
				otf.read_integer_16 --SHORT 	(reserved) 	set to 0
				otf.read_integer_16 --SHORT 	(reserved) 	set to 0
				otf.read_integer_16 --SHORT 	(reserved) 	set to 0
				otf.read_integer_16 --SHORT 	(reserved) 	set to 0
				otf.read_integer_16 --SHORT 	metricDataFormat 	0 for current format.
				otf.read_natural_16 --USHORT 	numberOfHMetrics 	Number of hMetric entries in 'hmtx' table	
				numberOfHMetrics  := otf.last_natural_16
		end

feature -- Access

        Ascender : INTEGER_16
        Descender : INTEGER_16
        LineGap : INTEGER_16
        advanceWidthMax : NATURAL_16
        minLeftSideBearing : INTEGER_16
        minRightSideBearing : INTEGER_16
        xMaxExtent : INTEGER_16
        caretSlopeRise : INTEGER_16
        caretSlopeRun : INTEGER_16
        numberOfHMetrics : NATURAL_16

end
