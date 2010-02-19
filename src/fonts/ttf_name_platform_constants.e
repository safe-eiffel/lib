indexing
	description: "Summary description for {TTF_NAME_PLATFORM_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_NAME_PLATFORM_CONSTANTS

feature -- Access

	apple_unicode : NATURAL_16 = 0	-- Apple Unicode
	macintosh : NATURAL_16 = 1	-- Macintosh
	iso : NATURAL_16 = 2	-- ISO
	microsoft : NATURAL_16 = 3	-- Microsoft

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
