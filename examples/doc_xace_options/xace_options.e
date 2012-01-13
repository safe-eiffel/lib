indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XACE_OPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_name : STRING)
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
			create options.make (10)
		ensure
			name_set: name = a_name
		end

feature -- Access

	options: DS_HASH_TABLE [XACE_OPTION, STRING]

	description: STRING
			-- Description

	name: STRING
			-- Name of options set.

feature -- Measurement

	count : INTEGER is
		do
			Result := options.count
		end

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_options (an_options: like options) is
			-- Set `options' to `an_options'.
		do
			options := an_options
		ensure
			options_assigned: options = an_options
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_assigned: description = a_description
		end

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
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

invariant
	name_not_void: name /= Void

end
