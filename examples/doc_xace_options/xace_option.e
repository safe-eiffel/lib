indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XACE_OPTION

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Make `a_name' option.
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

feature -- Access

	example: STRING
			-- Sample value

	name : STRING
			-- Short name

	description : STRING
			-- Description

	nota_bene : STRING
			-- Useful to note

	values : DS_LIST[STRING]
			-- Possible values

	default_value : STRING
			-- Default value

	ise_ace : STRING
			-- ISE Ace generation

	ise_ecf : STRING
			-- ISE ecf generation

feature -- Measurement

feature -- Status report

	is_ise_ecf : BOOLEAN is
		do
			Result := ise_ecf /= Void and then not rx_not_available.matches (ise_ecf)
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_example (an_example: like example) is
			-- Set `example' to `an_example'.
		do
			example := an_example
		ensure
			example_assigned: example = an_example
		end

	set_description (a_description : like description)
			-- Set `description' to `a_description'.
		require
			a_description_not_void: a_description /= Void
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_nota_bene (a_nota_bene : like nota_bene) is
			-- Set `nota_bene' to `a_nota_bene'.
		require
			a_nota_bene_not_void: a_nota_bene /= Void
		do
			nota_bene := a_nota_bene
		ensure
			nota_bene_set: nota_bene = a_nota_bene
		end

	set_default_value (a_default_value : like default_value) is
			-- Set `default_value' to `a_default_value'.
		require
			a_default_value_not_void: a_default_value /= Void
		do
			default_value := a_default_value
		ensure
			default_value_set: default_value = a_default_value
		end

	set_values (a_values : like values) is
			-- Set `values' to `a_values'.
		require
			a_values_not_void: a_values /= Void
			no_void: not a_values.has (Void)
		do
			values := a_values
		ensure
			values_set: values = a_values
		end

	set_ise_ace (a_value : like ise_ace) is
			-- Set `ise_ace' to `a_value'
		require
			a_value_not_void: a_value /= Void
		do
			ise_ace := a_value
		ensure
			ise_ace_set: ise_ace = a_value
		end

	set_ise_ecf (a_value : like ise_ecf) is
			-- Set `ise_ecf' to `a_value'.
		require
			a_value_not_void: a_value /= Void
		do
			ise_ecf := a_value
		ensure
			ise_ecf_set: ise_ecf = a_value
		end


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

	rx_not_available : RX_PCRE_REGULAR_EXPRESSION
		once
			create Result.make
			Result.compile ("^[ \t\n]*[Nn]/[Aa]")
		end

invariant
	name_not_void: name /= Void

end
