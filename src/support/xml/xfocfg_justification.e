indexing

	description: "Objects isomorphic to 'justification' elements"
	nota_bene: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:08.968"

class XFOCFG_JUSTIFICATION

feature  -- Access

	attribute_value: STRING
			-- attribute corresponding to `value'

feature  -- Element change

	set_attribute_value (a_attribute_value: like attribute_value) is
			-- set attribute `value'
		do
			attribute_value := a_attribute_value
		ensure
			attribute_value_set: attribute_value = a_attribute_value
		end

end -- class XFOCFG_JUSTIFICATION
