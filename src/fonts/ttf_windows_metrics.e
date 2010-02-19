indexing
	description: "[
	
	Summary description for {TTF_WINDOWS_METRICS}.
	
	Type	Name of Entry	Comments
	NATURAL_16	version	0x0004
	INTEGER_16	xAvgCharWidth	 
	NATURAL_16	usWeightClass	 
	NATURAL_16	usWidthClass	 
	NATURAL_16	fsType	 
	INTEGER_16	ySubscriptXSize	 
	INTEGER_16	ySubscriptYSize	 
	INTEGER_16	ySubscriptXOffset	 
	INTEGER_16	ySubscriptYOffset	 
	INTEGER_16	ySuperscriptXSize	 
	INTEGER_16	ySuperscriptYSize	 
	INTEGER_16	ySuperscriptXOffset	 
	INTEGER_16	ySuperscriptYOffset	 
	INTEGER_16	yStrikeoutSize	 
	INTEGER_16	yStrikeoutPosition	 
	INTEGER_16	sFamilyClass	 
	BYTE	panose[10]
	NATURAL_32	ulUnicodeRange1	Bits 0-31
	NATURAL_32	ulUnicodeRange2	Bits 32-63
	NATURAL_32	ulUnicodeRange3	Bits 64-95
	NATURAL_32	ulUnicodeRange4	Bits 96-127
	CHAR	achVendID[4]	 
	NATURAL_16	fsSelection	 
	NATURAL_16	usFirstCharIndex	 
	NATURAL_16	usLastCharIndex	 
	INTEGER_16	sTypoAscender	 
	INTEGER_16	sTypoDescender	 
	INTEGER_16	sTypoLineGap	 
	NATURAL_16	usWinAscent	 
	NATURAL_16	usWinDescent	 
	NATURAL_32	ulCodePageRange1	Bits 0-31
	NATURAL_32	ulCodePageRange2	Bits 32-63
	INTEGER_16	sxHeight	 
	INTEGER_16	sCapHeight	 
	NATURAL_16	usDefaultChar	 
	NATURAL_16	usBreakChar	 
	NATURAL_16	usMaxContext

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_WINDOWS_METRICS

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (otf : OPEN_TYPE_FONT_FILE)
		local
			i : INTEGER
		do
	otf.read_natural_16
	version := otf.last_natural_16
	otf.read_integer_16
	xavgcharwidth := otf.last_integer_16
	otf.read_natural_16
	usweightclass := otf.last_natural_16
	otf.read_natural_16
	uswidthclass := otf.last_natural_16
	otf.read_natural_16
	fstype := otf.last_natural_16
	otf.read_integer_16
	ysubscriptxsize := otf.last_integer_16
	otf.read_integer_16
	ysubscriptysize := otf.last_integer_16
	otf.read_integer_16
	ysubscriptxoffset := otf.last_integer_16
	otf.read_integer_16
	ysubscriptyoffset := otf.last_integer_16
	otf.read_integer_16
	ysuperscriptxsize := otf.last_integer_16
	otf.read_integer_16
	ysuperscriptysize := otf.last_integer_16
	otf.read_integer_16
	ysuperscriptxoffset := otf.last_integer_16
	otf.read_integer_16
	ysuperscriptyoffset := otf.last_integer_16
	otf.read_integer_16
	ystrikeoutsize := otf.last_integer_16
	otf.read_integer_16
	ystrikeoutposition := otf.last_integer_16
	otf.read_integer_16
	sfamilyclass := otf.last_integer_16
	create panose.make (1,10)
	from
		i := 1
	until
		i > panose.upper
	loop
		otf.read_natural_8
		panose[i] := otf.last_natural_8
		i := i + 1
	end
	otf.read_natural_32
	ulunicoderange1 := otf.last_natural_32
	otf.read_natural_32
	ulunicoderange2 := otf.last_natural_32
	otf.read_natural_32
	ulunicoderange3 := otf.last_natural_32
	otf.read_natural_32
	ulunicoderange4 := otf.last_natural_32
	otf.read_string (4)
	achvendid := otf.last_string.twin
	otf.read_natural_16
	fsselection := otf.last_natural_16
	otf.read_natural_16
	usfirstcharindex := otf.last_natural_16
	otf.read_natural_16
	uslastcharindex := otf.last_natural_16
	otf.read_integer_16
	stypoascender := otf.last_integer_16
	otf.read_integer_16
	stypodescender := otf.last_integer_16
	otf.read_integer_16
	stypolinegap := otf.last_integer_16
	otf.read_natural_16
	uswinascent := otf.last_natural_16
	otf.read_natural_16
	uswindescent := otf.last_natural_16
	otf.read_natural_32
	ulcodepagerange1 := otf.last_natural_32
	otf.read_natural_32
	ulcodepagerange2 := otf.last_natural_32
	otf.read_integer_16
	sxheight := otf.last_integer_16
	otf.read_integer_16
	scapheight := otf.last_integer_16
	otf.read_natural_16
	usdefaultchar := otf.last_natural_16
	otf.read_natural_16
	usbreakchar := otf.last_natural_16
	otf.read_natural_16
	usmaxcontext := otf.last_natural_16
		end

feature -- Access

	version : NATURAL_16
			--0x0004
	xAvgCharWidth : INTEGER_16
			--
	usWeightClass : NATURAL_16
			--
	usWidthClass : NATURAL_16
			--
	fsType : NATURAL_16
			--
	ySubscriptXSize : INTEGER_16
			--
	ySubscriptYSize : INTEGER_16
			--
	ySubscriptXOffset : INTEGER_16
			--
	ySubscriptYOffset : INTEGER_16
			--
	ySuperscriptXSize : INTEGER_16
			--
	ySuperscriptYSize : INTEGER_16
			--
	ySuperscriptXOffset : INTEGER_16
			--
	ySuperscriptYOffset : INTEGER_16
			--
	yStrikeoutSize : INTEGER_16
			--
	yStrikeoutPosition : INTEGER_16
			--
	sFamilyClass : INTEGER_16
			--
	panose : ARRAY[NATURAL_8]
			--
	ulUnicodeRange1 : NATURAL_32
			--Bits 0-31
	ulUnicodeRange2 : NATURAL_32
			--Bits 32-63
	ulUnicodeRange3 : NATURAL_32
			--Bits 64-95
	ulUnicodeRange4 : NATURAL_32
			--Bits 96-127
	achVendID : STRING
			--
	fsSelection : NATURAL_16
			--
	usFirstCharIndex : NATURAL_16
			--
	usLastCharIndex : NATURAL_16
			--
	sTypoAscender : INTEGER_16
			--
	sTypoDescender : INTEGER_16
			--
	sTypoLineGap : INTEGER_16
			--
	usWinAscent : NATURAL_16
			--
	usWinDescent : NATURAL_16
			--
	ulCodePageRange1 : NATURAL_32
			--Bits 0-31
	ulCodePageRange2 : NATURAL_32
			--Bits 32-63
	sxHeight : INTEGER_16
			--
	sCapHeight : INTEGER_16
			--
	usDefaultChar : NATURAL_16
			--
	usBreakChar : NATURAL_16
			--
	usMaxContext : NATURAL_16
			--

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True

end
