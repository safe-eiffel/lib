indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XACE_OPTIONS_FILE
inherit
	KL_TEXT_INPUT_FILE
		redefine
			read_line, open_read
		end

create
	make

feature -- Access

	system_options: XACE_OPTIONS
	cluster_options : XACE_OPTIONS
	class_options : XACE_OPTIONS
	feature_options : XACE_OPTIONS

	line : INTEGER


feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	open_read
		do
			precursor
			line := 0
		end

	read_line
		do
			precursor
			line := line + 1
		end

	read_options is
		local
			c : INTEGER
		do
			read_system_options
			read_cluster_options
			read_class_options
			read_feature_options
			c := system_options.options.count + cluster_options.options.count + class_options.options.count + feature_options.options.count
			print ("%NIl y a en tout : "+c.out+" options.%N")
		end

	read_some_options (some_options : XACE_OPTIONS ; rx : RX_PCRE_REGULAR_EXPRESSION)
		require
			some_options_not_void: some_options /= Void
			rx_not_void: rx /= Void
		local
			l_sys : STRING
		do
			-- Skip blank lines
			from
				read_line
			until
				end_of_input or else last_string.count > 0
			loop
				read_line
			end
			if not end_of_input then
				read_text_for (rx)
				from
					last_text.append_string (last_string)
					read_line
				until
					last_string.is_equal (hyphen_line)
				loop
					if last_string.count = 0 then
						last_text.append_character ('%N')
					else
						inspect last_text.item(last_text.count)
						when ' ', '%T' then
							do_nothing
						else
							last_text.append_character (' ')
						end
						last_text.append_string (last_string)
					end
					read_line
				end
				l_sys := last_text
				from
					if last_text /= Void then
						some_options.set_description (last_text)
					end
				until
					end_of_input or else last_string.is_equal (equal_line)
				loop
					read_line
					read_option
					if last_option /= Void then
						some_options.options.force (last_option, last_option.name)
					else
						print (".")
					end
				end
			end
		end

	read_system_options is
			--
		do
			create system_options.make ("SYSTEM OPTIONS")
			read_some_options (system_options, rx_system_option)
		end

	read_cluster_options is
		do
			create cluster_options.make ("CLUSTER OPTIONS")
			read_some_options (cluster_options, rx_cluster_option)
		end

	read_class_options is
		do
			create class_options.make ("CLASS OPTIONS")
			read_some_options (class_options, rx_class_option)
		end

	read_feature_options is
			--
		do
			create feature_options.make ("FEATURE OPTIONS")
			read_some_options (feature_options, rx_feature_option)
		end

	read_option is
		local
			l_name : STRING
			l_text : STRING
			done : BOOLEAN
		do
			create last_text.make (20)
			last_description := Void
			last_nota_bene := Void
			last_example := Void
			last_values := Void
			last_default_value := Void
			last_ise_ace := Void
			last_ise_ecf := Void
			last_ve := Void
			last_se := Void
			last_option := Void
			read_until (rx_name)
			if rx_name.has_matched then
				l_name := rx_name.captured_substring (1)
				create last_option.make (l_name)
				if last_string.count > 0 then
					from
						read_line
						read_text
						done := False
					until
						done
					loop
						inspect last_string.item (1)
						when 'D' then
							if rx_description.matches (last_string) then
								read_text_for (rx_description)
								last_description := appended_text (last_description, last_text)
							elseif rx_default.matches (last_string) then
								read_text_for (rx_default)
								last_default_value := appended_text (last_default_value, last_text)
							end
						when 'E' then
							read_text_for (rx_example)
							last_example := appended_text (last_example, last_text)
						when 'N' then
							read_text_for (rx_note)
							last_nota_bene := appended_text (last_nota_bene, last_text)
						when 'V' then
							if rx_values.matches (last_string) then
								read_text_for (rx_values)
								last_values := appended_text (last_values, last_text)
							elseif rx_ve.matches (last_string) then
								read_text_for (rx_ve)
								last_ve := appended_text (last_ve, last_text)
							end
						when 'I' then
							if rx_ise_ace.matches (last_string) then
								read_text_for (rx_ise_ace)
								last_ise_ace := appended_text (last_ise_ace, last_text)
							elseif rx_ise_ecf.matches (last_string) then
								read_text_for (rx_ise_ecf)
								last_ise_ecf := appended_text (last_ise_ecf, last_text)
							end
						when 'S' then
							read_text_for (rx_se)
							last_se := appended_text (last_se, last_text)
						when '-', '=' then
							done := True
						when ' ' then

						else
							print (">Unknown tag:%N"+last_string+"%N")
						end
						if last_text = Void or else last_text.is_empty then
							read_line
						end
					end
					if last_description /= Void then
						last_option.set_description (last_description)
					end
					if last_nota_bene /= Void then
						last_option.set_nota_bene (last_nota_bene)
					end
					if last_ise_ace /= Void then
						last_option.set_ise_ace (last_ise_ace)
					end
					if last_ise_ecf /= Void then
						last_option.set_ise_ecf (last_ise_ecf)
					end
					if last_default_value /= Void then
						last_option.set_default_value (last_default_value)
					end
					if last_values /= Void then
						last_option.set_values (bar_split.split_greedy (last_values))
					end
					if last_example /= Void then
						last_option.set_example (last_example)
					end
				end
			end
		end

	bar_split : ST_SPLITTER once create Result.make_with_separators ("|") end

	read_until (a_regex : RX_PCRE_REGULAR_EXPRESSION) is
		do
			from

			until
				end_of_input or else a_regex.matches (last_string) or else last_string.count > 0 and then (last_string.item(1)='-' or else last_string.item(1)='=')
			loop
				read_line
			end
		end

	read_text
		do
			from

			until
				last_string.count > 0 and then last_string.item(1) /= ' '
			loop
--				if last_text.count > 0 then
--					inspect last_text.item(last_text.count)
--					when ' ', '%T' then
--						do_nothing
--					else
--						last_text.append_character (' ')
--					end
--				end
				last_text.append_character ('%N')
				last_text.append_string (last_string)
				read_line
			end
		end

	read_text_for (a_regex : RX_PCRE_REGULAR_EXPRESSION) is
		do
			create last_text.make (100)
			a_regex.match (last_string)
			if a_regex.has_matched then
				last_text.append_string (a_regex.captured_substring (1))
				read_line
				read_text
--				if a_regex.matches (last_string) then
--					read_line
--				end
			else
				read_line
			end
		end

feature -- Obsolete

feature -- Inapplicable

	hyphen_line : STRING is "-------------------------------------------------------------"

	equal_line : STRING is  "============================================================="

feature {NONE} -- Implementation

	last_text : STRING

	last_description : STRING
	last_example : STRING
	last_nota_bene : STRING
	last_values : STRING
	last_default_value : STRING
	last_ise_ace : STRING
	last_ise_ecf : STRING
	last_ve : STRING
	last_se : STRING

	last_option : XACE_OPTION

	read_options_header is
		do
			from
				create last_header.make (100)
			until
				last_string.is_equal (hyphen_line)
			loop
				if last_header.count > 0 then
					inspect last_header.item(last_header.count)
					when ' ', '%T' then
						do_nothing
					else
						last_header.append_character (' ')
					end
				end
				last_header.append_string (last_string)
				read_line
			end
			read_line
		ensure
			last_string_not_hyphen_line: not last_string.is_equal (hyphen_line)
		end

	last_header : STRING

	rx_name: RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^NAME:?(.*)$")
		end

	rx_values : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^VALUES:?(.*)$")
		end

	rx_default : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^DEFAULT:?(.*)$")
		end

	rx_description : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^DESCRIPTION:?(.*)$")
		end

	rx_note : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^NOTE:?(.*)$")
		end

	rx_ise_ace : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^ISE Ace:?(.*)$")
		end

	rx_ise_ecf : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^ISE ECF:?(.*)$")
		end

	rx_ve : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^VE:?(.*)$")
		end

	rx_se : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("^SE:?(.*)$")
		end

	rx_system_option : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("SYSTEM OPTIONS(.*)")
		end

	rx_cluster_option : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("CLUSTER OPTIONS(.*)")
		end

	rx_class_option : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("CLASS OPTIONS(.*)")
		end

	rx_feature_option : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("FEATURE OPTIONS(.*)")
		end

	rx_example : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("EXAMPLE:(.*)")
		end

	appended_text (target, text : STRING) : STRING
		do
			if target /= Void then
				target.append_string (text)
				Result := target
			else
				Result := text
			end
		end
invariant
	invariant_clause: True -- Your invariant here

end
