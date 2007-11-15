indexing
	description: "Objects that read Adobe Font Metrics (AFM) files"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFM_READER

create
	make
	
feature -- Initialization
	
	make (f : PLAIN_TEXT_FILE) is
			-- 
		require
			f /= Void and then f.is_open_read
		do
			file := f
			read_font_properties
			read_widths
		end
		
feature -- Access

	file : PLAIN_TEXT_FILE

	font_name : STRING
		
	widths : DS_HASH_TABLE[INTEGER, STRING]
			-- widths, indexed by character name

	widths_count : INTEGER
	
	last_width : INTEGER
	
	last_name : STRING

	full_name : STRING 
		-- Times Bold
		
	family_name : STRING 
		-- Times
		
	weight : STRING
		-- Bold
		
	italic_angle : INTEGER
		-- 0

	is_fixed_pitch : BOOLEAN 
		-- false
		
	character_set : STRING 
		-- Extended_roman
		
	font_b_box : GEO_RECTANGLE[INTEGER]
		-- -168 -218 1000 935 
		
	underline_position : INTEGER
		-- -100
	
	underline_thickness : INTEGER
		-- 50
		
	encoding_scheme : STRING
		-- Adobe_standard_encoding
		
	cap_height : INTEGER
		-- 676
		
	x_height : INTEGER
		-- 461
		
	ascender : INTEGER
		-- 683
		
	descender : INTEGER
		-- -217

	std_hw : INTEGER
		-- 44
		
	std_vw : INTEGER
		-- 139
	
feature -- Element change
	
	read_name is
			-- 
		do
			read_until ("FontName")
			file.read_word
			font_name := clone (file.last_string)
		end
		
	read_widths is
		require
			start_metrics: startcharmetrics_regex.matches (file.last_string)
		do
			create widths.make (256)
			from
				file.read_line
			until
				file.end_of_file or else endcharmetrics_regex.matches (file.last_string)
			loop
				decode_char_metric (file.last_string)
				file.read_line
			end
		end
		
feature -- Basic operations

	read_until (s : STRING) is
			-- 
		do
			from
				file.read_word
			until
				file.end_of_file or else file.last_string.is_equal (s)
			loop
				file.read_word
			end			
		end
		
	fontname_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("FontName[\ \t]+([a-zA-Z\-_0-9]+)")
		ensure
			fontname_regex_is_compiled: Result.is_compiled
		end

	fullname_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("FullName[\ \t]+([a-zA-Z\-_\ 0-9]+)")
		ensure
			fullname_regex_is_compiled: Result.is_compiled
		end

	familyname_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("FamilyName[\ \t]+([a-zA-Z\-_0-9]+)")
		ensure
			familyname_regex_is_compiled: Result.is_compiled
		end

	weight_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("Weight[\ \t]+([a-zA-Z\-_0-9]+)")
		ensure
			weight_regex_is_compiled: Result.is_compiled
		end

	italicangle_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("ItalicAngle[\ \t]+([-]?[0-9]+)")
		ensure
			italicangle_regex_is_compiled: Result.is_compiled
		end

	isfixedpitch_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("IsFixedPitch[\ \t]+([TtFf][RrAa][UuLl][EeSs][Ee]?)")
		ensure
			isfixedpitch_regex_is_compiled: Result.is_compiled
		end

	characterset_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("CharacterSet[\ \t]+([a-zA-Z\-_0-9]+)")
		ensure
			characterset_regex_is_compiled: Result.is_compiled
		end

	fontbbox_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("FontBBox[\ \t]+([-]?[0-9]+)[\ \t]+([-]?[0-9]+)[\ \t]+([-]?[0-9]+)[\ \t]+([-]?[0-9]+)")
		ensure
			fontbbox_regex_is_compiled: Result.is_compiled
		end

	underlineposition_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("UnderlinePosition[\ \t]+([-]?[0-9]+)")
		ensure
			underlineposition_regex_is_compiled: Result.is_compiled
		end

	underlinethickness_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("UnderlineThickness[\ \t]+([-]?[0-9]+)")
		ensure
			underlinethickness_regex_is_compiled: Result.is_compiled
		end

	encodingscheme_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("EncodingScheme[\ \t]+([a-zA-Z\-_0-9]+)")
		ensure
			encodingscheme_regex_is_compiled: Result.is_compiled
		end

	capheight_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("CapHeight[\ \t]+([-]?[0-9]+)")
		ensure
			capheight_regex_is_compiled: Result.is_compiled
		end

	xheight_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("XHeight[\ \t]+([-]?[0-9]+)")
		ensure
			xheight_regex_is_compiled: Result.is_compiled
		end

	ascender_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("Ascender[\ \t]+([-]?[0-9]+)")
		ensure
			ascender_regex_is_compiled: Result.is_compiled
		end

	descender_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("Descender[\ \t]+([-]?[0-9]+)")
		ensure
			descender_regex_is_compiled: Result.is_compiled
		end

	stdhw_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("StdHW[\ \t]+([-]?[0-9]+)")
		ensure
			stdhw_regex_is_compiled: Result.is_compiled
		end

	stdvw_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("StdVW[\ \t]+([-]?[0-9]+)")
		ensure
			stdvw_regex_is_compiled: Result.is_compiled
		end

	startcharmetrics_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create  Result.make
			Result.compile ("StartCharMetrics[\ \t]+([-]?[0-9]+)")
		ensure
			startcharmetrics_regex_is_compiled: Result.is_compiled
		end

	endcharmetrics_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("EndCharMetrics")
		ensure
			endcharmetrics_regex_is_compiled: Result.is_compiled
		end

	read_font_properties is
		do
			from
				file.read_line
			until
				file.end_of_file or else startcharmetrics_regex.matches (file.last_string)
			loop
				decode_font_property (file.last_string)
				file.read_line
			end
		end
		
	decode_font_property (line : STRING) is
		do
			fontname_regex.match (line)
			if fontname_regex.has_matched then
				font_name := fontname_regex.captured_substring (1)
			end
			fullname_regex.match (line)
			if fullname_regex.has_matched then
				full_name := fullname_regex.captured_substring (1)
			end
			familyname_regex.match (line)
			if familyname_regex.has_matched then
				family_name := familyname_regex.captured_substring (1)
			end
			weight_regex.match (line)
			if weight_regex.has_matched then
				weight := weight_regex.captured_substring (1)
			end
			italicangle_regex.match (line)
			if italicangle_regex.has_matched then
				italic_angle := italicangle_regex.captured_substring (1).to_integer
			end
			isfixedpitch_regex.match (line)
			if isfixedpitch_regex.has_matched then
				is_fixed_pitch := isfixedpitch_regex.captured_substring (1).to_boolean
			end
			characterset_regex.match (line)
			if characterset_regex.has_matched then
				character_set := characterset_regex.captured_substring (1)
			end
			fontbbox_regex.match (line)
			if fontbbox_regex.has_matched then
				create font_b_box.set (
					fontbbox_regex.captured_substring (1).to_integer,
					fontbbox_regex.captured_substring (2).to_integer,
					fontbbox_regex.captured_substring (3).to_integer,
					fontbbox_regex.captured_substring (4).to_integer
					)
			end
			underlineposition_regex.match (line)
			if underlineposition_regex.has_matched then
				underline_position := underlineposition_regex.captured_substring (1).to_integer
			end
			underlinethickness_regex.match (line)
			if underlinethickness_regex.has_matched then
				underline_thickness := underlinethickness_regex.captured_substring (1).to_integer
			end
			encodingscheme_regex.match (line)
			if encodingscheme_regex.has_matched then
				encoding_scheme := encodingscheme_regex.captured_substring (1)
			end
			capheight_regex.match (line)
			if capheight_regex.has_matched then
				cap_height := capheight_regex.captured_substring (1).to_integer
			end
			xheight_regex.match (line)
			if xheight_regex.has_matched then
				x_height := xheight_regex.captured_substring (1).to_integer
			end
			ascender_regex.match (line)
			if ascender_regex.has_matched then
				ascender := ascender_regex.captured_substring (1).to_integer
			end
			descender_regex.match (line)
			if descender_regex.has_matched then
				descender := descender_regex.captured_substring (1).to_integer
			end
			stdhw_regex.match (line)
			if stdhw_regex.has_matched then
				std_hw := stdhw_regex.captured_substring (1).to_integer
			end
			stdvw_regex.match (line)
			if stdvw_regex.has_matched then
				std_vw := stdvw_regex.captured_substring (1).to_integer
			end
		end
		
	decode_char_metric (s : STRING) is
		local
			c : DS_LIST_CURSOR[STRING]
		do
			c := char_metrics_splitter.split (s).new_cursor
			from
				c.start
			until
				c.off
			loop
				if c.item.is_equal ("C") then
				elseif c.item.is_equal ("WX") then
					c.forth
					last_width := c.item.to_integer
				elseif c.item.is_equal ("N") then
					c.forth
					last_name := c.item
				elseif c.item.is_equal ("B") then
				end
				c.forth
			end
			widths.force (last_width, last_name)
		end
		
	char_metrics_splitter : ST_SPLITTER is
		once
			create Result.make
			Result.set_separators (" ;")
			--C integer
			--WX integer
			--N string
			--B integer integer integer integer
		end
			
end
