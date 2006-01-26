indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_SECTION

create
	
	make
	
feature {NONE} -- Initialization

	make (new_name : STRING; new_page_rectangle : FO_RECTANGLE; new_margins : FO_MARGINS) is
			-- create with `new_name', `new_page_rectangle' and `new_margins'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
			new_page_rectangle_not_void: new_page_rectangle /= Void
			new_margins_not_void: new_margins /= Void
		do
			name := new_name
			page_rectangle := new_page_rectangle
			margins := new_margins
		ensure	
			name_set: name = new_name
			page_rectangle_set: page_rectangle = new_page_rectangle
			margins_set: margins = new_margins
			is_orientation_portrait: is_orientation_portrait
		end
				
feature -- Access

	name : STRING
			-- Name.
	
	page_rectangle : FO_RECTANGLE
			-- Page rectangle.
	
	margins : FO_MARGINS
			-- Section margins.

	header : FO_HEADER_FOOTER
			-- Header.
			
	footer : FO_HEADER_FOOTER
			-- Footer.
			
feature -- Status report

	is_orientation_portrait : BOOLEAN is
			-- Is the page orientation Portrait?
		do
			Result := not is_orientation_landscape
		end
		
	is_orientation_landscape : BOOLEAN
			-- Is the page orientation Landscape?
		
feature -- Status setting

	set_orientation_landscape is
			-- set `is_orientation_landscape'.
		do
			is_orientation_landscape := True
		end
		
	set_orientation_portrait is
			-- set `is_orientation_portrait'.
		do
			is_orientation_landscape := False
		end

feature -- Element change.

	set_header (a_header : FO_HEADER_FOOTER) is	
			-- Set `header' to `a_header'.
		require
			a_header_not_void: a_header /= Void
		do
			header := a_header
		ensure
			header_set: header = a_header
		end
		
	set_footer (a_footer : FO_HEADER_FOOTER) is
			-- Set `footer' to `a_footer'.
		require
			a_footer_not_void: a_footer /= Void
		do
			footer := a_footer
		ensure
			footer_set: footer = a_footer
		end

invariant		
	
	portrait_xor_landscape: is_orientation_portrait xor is_orientation_landscape
	name_not_void: name /= Void
	name_not_empty: not name.is_empty
	page_rectangle_not_void: page_rectangle /= Void
	margins_not_void: margins /= Void
	
end

