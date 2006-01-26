indexing

	description: "Objects isomorphic to 'style' elements"
	note: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:09.531"

class XFOCFG_STYLE

feature  -- Access

	margins: XFOCFG_MARGINS
			-- element corresponding to `margins'

	font: XFOCFG_FONT
			-- element corresponding to `font'

	justification: XFOCFG_JUSTIFICATION
			-- element corresponding to `justification'

	attribute_name: STRING
			-- attribute corresponding to `name'

feature  -- Element change

	set_margins (a_margins: like margins) is
			-- set element `margins'
		do
			margins := a_margins
		ensure
			margins_set: margins = a_margins
		end

	set_font (a_font: like font) is
			-- set element `font'
		do
			font := a_font
		ensure
			font_set: font = a_font
		end

	set_justification (a_justification: like justification) is
			-- set element `justification'
		do
			justification := a_justification
		ensure
			justification_set: justification = a_justification
		end

	set_attribute_name (a_attribute_name: like attribute_name) is
			-- set attribute `name'
		do
			attribute_name := a_attribute_name
		ensure
			attribute_name_set: attribute_name = a_attribute_name
		end

end -- class XFOCFG_STYLE
