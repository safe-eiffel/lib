indexing

	description: "Objects isomorphic to 'section' elements"
	note: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:07.218"

class XFOCFG_SECTION

feature  -- Access

	page: XFOCFG_PAGE
			-- element corresponding to `page'

	margins: XFOCFG_MARGINS
			-- element corresponding to `margins'

	attribute_name: STRING
			-- attribute corresponding to `name'

feature  -- Element change

	set_page (a_page: like page) is
			-- set element `page'
		do
			page := a_page
		ensure
			page_set: page = a_page
		end

	set_margins (a_margins: like margins) is
			-- set element `margins'
		do
			margins := a_margins
		ensure
			margins_set: margins = a_margins
		end

	set_attribute_name (a_attribute_name: like attribute_name) is
			-- set attribute `name'
		do
			attribute_name := a_attribute_name
		ensure
			attribute_name_set: attribute_name = a_attribute_name
		end

end -- class XFOCFG_SECTION
