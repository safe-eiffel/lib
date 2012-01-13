note
	description: "Summary description for {PDF_OPENTYPE_FONT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_OPENTYPE_FONT

inherit
	PDF_FONT

--. The value of Subtype is TrueType.
--. The value of BaseFont is derived differently, as described below.
--. The value of Encoding is subject to limitations that are described in Section
--5.5.5, "Character Encoding."
--The PostScript name for the value of BaseFont is determined in one of two ways:
--. Use the PostScript name that is an optional entry in the "name" table of the
--TrueType font.
--. In the absence of such an entry in the "name" table, derive a PostScript name
--from the name by which the font is known in the host operating system. On a
--Windows system, the name is based on the lfFaceName field in a LOGFONT
--structure; in the Mac OS, it is based on the name of the FOND resource. If the
--name contains any spaces, the spaces are removed.

feature -- Access

	subtype : PDF_NAME
		once
			create Result.make("TrueType")
		end

	basefont : PDF_NAME
		do

		end

	
end
