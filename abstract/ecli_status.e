indexing
	description: 

		"Objects that represent a CLI status"

	author: 	"Paul G. Crismer"
	date: 		"$Date$"
	revision: 	"$Revision$"
	licensing: 	"See notice at end of class"

deferred class
	ECLI_STATUS

inherit

	ECLI_EXTERNAL_API
		export {NONE}	all
		end

feature -- Access

	status : INTEGER

	diagnostic_message : STRING is
			-- Message describing an error
		require
			error: is_error or has_information_message
		do
			--| TODO
			get_diagnostics
			Result := impl_error_message
		end

	has_information_message : BOOLEAN is
			-- Is the last CLI command ok, 
			-- but with an available information message ?
		do
			Result := status = cli_ok_with_info
		ensure
			Result implies is_ok
		end

	cli_state : STRING is
		do
			get_diagnostics
			Result := impl_cli_state
		end

	native_code : INTEGER is
		do
			get_diagnostics
			Result := impl_native_code
		end

	is_ok : BOOLEAN is
			-- Is the last CLI command ok ?
		do
			Result := status = cli_ok or else has_information_message
		end

	is_error : BOOLEAN is
			-- Is the last CLI command in error
		do
			Result := status = cli_error
		end
	
feature -- Measurement

feature -- Status report

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	cli_ok : INTEGER is
			-- 
		once
			Result := ecli_c_ok
		end

	cli_ok_with_info : INTEGER is
		once
			Result := ecli_c_ok_with_info
		end

	cli_no_data : INTEGER is
		once
			Result := ecli_c_no_data
		end

	cli_error : INTEGER is
		once
			Result := ecli_c_error
		end

	cli_invalid_handle : INTEGER is
		once
			Result := ecli_c_invalid_handle
		end

	cli_need_data : INTEGER is
		once
			Result := ecli_c_need_data
		end

	set_status (v : INTEGER) is
		do
			status := v
			need_diagnostics := True
		ensure
			status: status = v
		end

	get_error_diagnostic (record_index : INTEGER; state : POINTER; native_error : POINTER; message : POINTER; buffer_length : INTEGER; length_indicator : POINTER) : INTEGER  is
			-- to be redefined in descendant classes
		deferred
		end

	get_diagnostics is
		local
			count : INTEGER
			tools : ECLI_EXTERNAL_TOOLS
			retcode : INTEGER
		do
			if need_diagnostics then
				if impl_cli_state = Void then
					create impl_cli_state.make (6)
				end
				if impl_error_message = Void then
					create impl_error_message.make (256)
				end
				if impl_error_buffer = Void then
					create impl_error_buffer.make (256)
				end
				impl_error_message.clear_content
				-- fill cli_state and buffer with blanks so that count=capacity
				impl_cli_state.fill_blank
				impl_cli_state.head (5)
				impl_error_buffer.fill_blank
				from 
					count := 1
				until retcode = cli_no_data
				loop
					retcode := get_error_diagnostic (count, 
							tools.string_to_pointer (impl_cli_state),
							$impl_native_code, 
							tools.string_to_pointer (impl_error_buffer),
							255,
							$impl_buffer_length_indicator)
					if retcode = cli_ok or else retcode = cli_ok_with_info then	
						impl_error_message.append (
								tools.pointer_to_string (
									tools.string_to_pointer (impl_error_buffer)))
						impl_error_message.append ("%N")
					end	
					count := count + 1
				end
				need_diagnostics := False
			end
		end

	impl_native_code : INTEGER

	impl_cli_state : STRING

	impl_error_message : MESSAGE_BUFFER

	impl_error_buffer : MESSAGE_BUFFER

	need_diagnostics : BOOLEAN

	impl_buffer_length_indicator : INTEGER
	
invariant
	invariant_clause: -- Your invariant here

end -- class ECLI_STATUS
--
-- Copyright: 2000, Paul G. Crismer, <pgcrism@attglobal.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--