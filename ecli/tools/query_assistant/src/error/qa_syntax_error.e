note

	description:

			"Syntax Errors."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class QA_SYNTAX_ERROR

inherit

	QA_ERROR

create

	make_duplicate_element,
	make_exclusive_element,
	make_missing_element,
	make_missing_attribute,
	make_parse_error

feature {NONE} -- Initialization

	make_duplicate_element (module, element, parent : STRING)
			-- Make for duplicate `element' in `parent' for `module'.
		require
			module_not_void: module /= Void
			element_not_void: element /= Void
			parent_not_void: parent /= Void
		do
			default_template := dupel_template
			create parameters.make (1, 4)
			parameters.put (module, 1)
			parameters.put (element, 2)
			parameters.put (parent, 3)
			code := dupel_code
			parameters.put (code, 4)
		end

	make_exclusive_element (module, element_a, element_b, parent : STRING)
			-- Make for `element_a' exclusive of `element_b' in `parent' for `module'.
		require
			module_not_void: module /= Void
			element_a_not_void: element_a /= Void
			element_b_not_void: element_b /= Void
			parent_not_void: parent /= Void
		do
			default_template := excel_template
			create parameters.make (1, 5)
			parameters.put (module, 1)
			parameters.put (element_a, 2)
			parameters.put (element_b, 3)
			parameters.put (parent, 4)
			code := excel_code
			parameters.put (code, 5)
		end

	make_missing_element (module, element, parent : STRING)
			-- Make for missing `element' in `parent' for `module'.
		require
			module_not_void: module /= Void
			element_not_void: element /= Void
		do
			default_template := misel_template
			create parameters.make (1, 4)
			parameters.put (module, 1)
			parameters.put (element, 2)
			parameters.put (parent, 3)
			code := misel_code
			parameters.put (code, 4)
		end

	make_missing_attribute (module, an_attribute, element : STRING)
			-- Make for missing `attribute' in `element' for `module'.
		require
			module_not_void: module /= Void
			an_attribute_not_void: an_attribute /= Void
			element_not_void: element /= Void
		do
			default_template := misat_template
			create parameters.make (1, 4)
			parameters.put (module, 1)
			parameters.put (an_attribute, 2)
			parameters.put (element, 3)
			code := misat_code
			parameters.put (code, 4)
		end

	make_parse_error (diagnostic : STRING)
			-- Make for XML parse error with `diagnostic'.
		require
			diagnostic_not_void: diagnostic /= Void
		do
			default_template := parer_template
			code := parer_code
			create parameters.make (1, 2)
			parameters.put (diagnostic, 1)
			parameters.put (code, 2)
		end

feature {NONE} -- Implementation

	dupel_template : STRING = "[$4] Module `$1' : duplicate element `$2' in element `$3'."
	excel_template : STRING = "[$5] Module `$1' : `$2' and `$3' are exclusive elements in `$4'."
	misel_template : STRING = "[$4] Module `$1' : element `$2' is missing in parent `$3'."
	misat_template : STRING = "[$4] Module `$1' : attribute `$2' is missing in element `$3'."
	parer_template : STRING = "[$2] XML Parse error : `$1'."

	dupel_code : STRING = "E-SYN-DUPELEM"
	excel_code : STRING = "E-SYN-EXCELEM"
	misel_code : STRING = "E-SYN-MISELEM"
	misat_code : STRING = "E-SYN-MISATTR"
	parer_code : STRING = "E-SYN-PARSERR"

end -- class QA_SYNTAX_ERROR
