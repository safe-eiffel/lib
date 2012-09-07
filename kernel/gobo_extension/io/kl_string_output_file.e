note

	description:

	    "KL_TEXT_OUTPUT_FILEs writing in an instance of STRING."

	author: "Paul G. Crismer"

	library: "SAFE Kernel/Gobo extensions"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	KL_STRING_OUTPUT_FILE

inherit

	KI_BINARY_OUTPUT_FILE
		rename
			make as make_file
		end

create

	make

feature {NONE} -- Initialization

	make (a_string: STRING_8)
			-- Make using a_string as `target_string'.
		do
			target_string := a_string
			create stream.make (target_string)
		ensure
			target_string_attached: target_string = a_string
		end

feature -- Access

	target_string : STRING_8
			-- Target where file content is output.

	name: STRING = "STRING"

	time_stamp: INTEGER_32 = 0

feature -- Measurement

	count : INTEGER_32
		require else
			is_open: is_open_write
		do
			Result := target_string.count
		end

feature -- Comparison

feature -- Status report

	exists: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_closed : BOOLEAN
			-- <Precursor>
		do
			Result := not is_open_write
		end

	is_open_write: BOOLEAN
			-- <Precursor>

	is_readable : BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

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

	close
			-- <Precursor>
		do
			is_open_write := False
		end

	flush
			-- <Precursor>
		do
			stream.flush
		end

	open_append
			-- <Precursor>
		do

		end

	open_write
			-- <Precursor>
		do
			is_open_write := True
		end

	put_character (c: CHARACTER_8)
			-- <Precursor>
		do
			stream.put_character (c)
		end

	put_string (a_string: STRING_8)
			-- <Precursor>
		do
			stream.put_string (a_string)
		end

feature -- Obsolete

feature -- Inapplicable

	concat (a_filename: STRING_8)
		do
			-- NOT IMPLEMENTED
		end

	copy_file (new_name : STRING_8)
		do
			-- NOT IMPLEMENTED
		end

	change_name (new_name: STRING_8)
		do
			-- NOT IMPLEMENTED
		end

	delete
		do
			-- NOT IMPLEMENTED
		end

	make_file (a_name : STRING_8)
		do
			-- NOT IMPLEMENTED
		end

	recursive_open_append
		do
			open_append
		end

	recursive_open_write
		do
			open_write
		end

	same_physical_file (other_name: STRING_8) : BOOLEAN
		do
			-- NOT IMPLEMENTED
		end

feature -- Constants

feature {NONE} -- Implementation

	stream : KL_STRING_OUTPUT_STREAM

invariant

	stream_attached: stream /= Void
	target_string_attached: target_string /= Void

end

--
-- Copyright: 2009-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
