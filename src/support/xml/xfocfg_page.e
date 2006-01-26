indexing

	description: "Objects isomorphic to 'page' elements"
	note: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:05.625"

class XFOCFG_PAGE

feature  -- Access

	attribute_height: STRING
			-- attribute corresponding to `height'

	attribute_width: STRING
			-- attribute corresponding to `width'

	attribute_orientation: STRING
			-- attribute corresponding to `orientation'

feature  -- Element change

	set_attribute_height (a_attribute_height: like attribute_height) is
			-- set attribute `height'
		do
			attribute_height := a_attribute_height
		ensure
			attribute_height_set: attribute_height = a_attribute_height
		end

	set_attribute_width (a_attribute_width: like attribute_width) is
			-- set attribute `width'
		do
			attribute_width := a_attribute_width
		ensure
			attribute_width_set: attribute_width = a_attribute_width
		end

	set_attribute_orientation (a_attribute_orientation: like attribute_orientation) is
			-- set attribute `orientation'
		do
			attribute_orientation := a_attribute_orientation
		ensure
			attribute_orientation_set: attribute_orientation = a_attribute_orientation
		end

end -- class XFOCFG_PAGE
