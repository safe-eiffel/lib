indexing
	description: "Textable objects."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

deferred class FO_TEXTABLE

inherit
	
	FO_RENDERABLE
		redefine
			is_equal
		end

	FO_FONT_ABLE
		undefine
			out, is_equal
		end
		
	FO_COLOR_ABLE
		undefine
			out
		redefine
			is_equal
		end


feature {NONE} -- Initialization

feature -- Access

feature -- Measurement

feature -- Comparison

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

feature -- Constants

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_fontable (other) and same_colorable (other)
		end

end
