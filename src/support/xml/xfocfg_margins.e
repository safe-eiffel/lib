indexing

	description: "Objects isomorphic to 'margins' elements"
	note: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:06.375"

class XFOCFG_MARGINS

feature  -- Access

	attribute_left: STRING
			-- attribute corresponding to `left'

	attribute_right: STRING
			-- attribute corresponding to `right'

	attribute_bottom: STRING
			-- attribute corresponding to `bottom'

	attribute_top: STRING
			-- attribute corresponding to `top'

feature  -- Element change

	set_attribute_left (a_attribute_left: like attribute_left) is
			-- set attribute `left'
		do
			attribute_left := a_attribute_left
		ensure
			attribute_left_set: attribute_left = a_attribute_left
		end

	set_attribute_right (a_attribute_right: like attribute_right) is
			-- set attribute `right'
		do
			attribute_right := a_attribute_right
		ensure
			attribute_right_set: attribute_right = a_attribute_right
		end

	set_attribute_bottom (a_attribute_bottom: like attribute_bottom) is
			-- set attribute `bottom'
		do
			attribute_bottom := a_attribute_bottom
		ensure
			attribute_bottom_set: attribute_bottom = a_attribute_bottom
		end

	set_attribute_top (a_attribute_top: like attribute_top) is
			-- set attribute `top'
		do
			attribute_top := a_attribute_top
		ensure
			attribute_top_set: attribute_top = a_attribute_top
		end

end -- class XFOCFG_MARGINS
