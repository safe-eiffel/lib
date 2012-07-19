indexing
	description: "Summary description for {TTF_NAME_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_NAME_CONSTANTS

feature -- Access

	copyright : NATURAL_16 = 0	-- Copyright notice.
	font_family_name : NATURAL_16 = 1	-- Font Family name
	font_subfamily_name : NATURAL_16 = 2	-- Font Subfamily name; for purposes of definition, this is assumed to address style (italic, oblique) and weight (light, bold, black, etc.) only. A font with no particular differences in weight or style (e.g. medium weight, not italic and fsSelection bit 6 set) should have the string "Regular" stored in this position.
	unique_font_identifier : NATURAL_16 = 3	-- Unique font identifier
	full_font_name : NATURAL_16 = 4	-- Full font name; this should simply be a combination of strings 1 and 2. Exception: if string 2 is "Regular," then use only string 1. This is the font name that Windows will expose to users.
	version_string : NATURAL_16 = 5	-- Version string. In n.nn format.
	postscript_name : NATURAL_16 = 6	-- Postscript name for the font.
	trademark : NATURAL_16 = 7	-- Trademark; this is used to save any trademark notice/information for this font. Such information should be based on legal advice. This is distinctly separate from the copyright.

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
	invariant_clause: True -- Your invariant here

end
