indexing

	description: "Objects isomorphic to 'font' elements"
	note: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:08.093"

class XFOCFG_FONT

feature  -- Access

	attribute_family: STRING
			-- attribute corresponding to `family'

	attribute_style: STRING
			-- attribute corresponding to `style'

	attribute_weight: STRING
			-- attribute corresponding to `weight'

	attribute_size: STRING
			-- attribute corresponding to `size'

	attribute_stretch: DOUBLE_REF
			-- attribute corresponding to `stretch'

feature  -- Element change

	set_attribute_family (a_attribute_family: like attribute_family) is
			-- set attribute `family'
		do
			attribute_family := a_attribute_family
		ensure
			attribute_family_set: attribute_family = a_attribute_family
		end

	set_attribute_style (a_attribute_style: like attribute_style) is
			-- set attribute `style'
		do
			attribute_style := a_attribute_style
		ensure
			attribute_style_set: attribute_style = a_attribute_style
		end

	set_attribute_weight (a_attribute_weight: like attribute_weight) is
			-- set attribute `weight'
		do
			attribute_weight := a_attribute_weight
		ensure
			attribute_weight_set: attribute_weight = a_attribute_weight
		end

	set_attribute_size (a_attribute_size: like attribute_size) is
			-- set attribute `size'
		do
			attribute_size := a_attribute_size
		ensure
			attribute_size_set: attribute_size = a_attribute_size
		end

	set_attribute_stretch (a_attribute_stretch: like attribute_stretch) is
			-- set attribute `stretch'
		do
			attribute_stretch := a_attribute_stretch
		ensure
			attribute_stretch_set: attribute_stretch = a_attribute_stretch
		end

end -- class XFOCFG_FONT
