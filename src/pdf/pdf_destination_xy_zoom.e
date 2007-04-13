indexing
	description:

	"Destinations designated by page, with the coordinates (left, top) positioned %
% at the top-left corner of the window and the contents of the page magnified %
% by the factor zoom. A null value for any of the parameters left, top, or %
% zoom specifies that the current value of that parameter is to be retained unchanged. %
% A zoom value of 0 has the same meaning as a null value."

	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_DESTINATION_XY_ZOOM

inherit
	PDF_EXPLICIT_DESTINATION

creation
	make

feature {NONE} -- Initialization

	make (destination : PDF_PAGE; left, top, zoom_factor : DOUBLE) is
			-- Initialize for `destination' at (`location_x', `location_y') z
		require
			destination_exists: destination /= Void
		do
			page := destination
			x := left
			y := top
			zoom := zoom_factor
		ensure
			page_set: page = destination
			x_set: x = left
			y_set: y = top
		end

feature -- Access

	x : DOUBLE
			-- x coordinate of top,left corner of window

	y : DOUBLE
			-- y coordinate of top,left corner of window

	zoom : DOUBLE
			-- magnification of window content

	type : PDF_NAME is
			--
		do
			Result := names.xyz
		end

feature -- Measurement

feature -- Status report

	fits (area : PDF_RECTANGLE) : BOOLEAN is
		do
			Result := area.has_point (x.truncated_to_integer, y.truncated_to_integer)
		end

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

	put_content (medium : PDF_OUTPUT_MEDIUM) is
		do
			medium.put_string (Array_element_separator)
			medium.put_double (x)
			medium.put_string (Array_element_separator)
			medium.put_double (y)
			medium.put_string (Array_element_separator)
			medium.put_double (zoom)
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_DESTINATION_XY_ZOOM
