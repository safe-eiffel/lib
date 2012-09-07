note

	description:

	    "KL_TEXT_INPUT_FILE instances reading from a STRING instance."

	author: "Paul G. Crismer"

	library: "SAFE Kernel/Gobo extensions"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	KL_STRING_INPUT_FILE

inherit
	KI_BINARY_INPUT_FILE
		rename
			make as make_file
		redefine
			is_closable,
			is_readable,
			is_rewindable
		end

create

	make

feature {NONE} -- Initialization

	make (a_string : STRING)
			-- Make with `a_string' as `target_string'.
		do
			target_string := a_string
			create stream.make (target_string)
		ensure
			target_string_attached: target_string = a_string
		end

feature -- Access

	target_string : STRING_8
			-- Target string where file content is read.

	name : STRING = "STRING"
			-- <Precursor>

	time_stamp: INTEGER = 0
			-- <Precursor>

	last_string: STRING_8
			-- <Precursor>
		do
			Result := stream.last_string
		end

	last_character : CHARACTER_8
			-- <Precursor>
		do
			Result := stream.last_character
		end

feature -- Measurement

	count : INTEGER_32
			-- <Precursor>
		do
			Result := target_string.count
		end

feature -- Comparison

feature -- Status report

	is_open_read : BOOLEAN
			-- <Precursor>

	is_closed : BOOLEAN
			-- <Precursor>
		do
			Result := not is_open_read
		end

	exists : BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	end_of_file : BOOLEAN
			-- <Precursor>
		do
			Result := stream.end_of_input
		end

	is_closable : BOOLEAN
			-- <Precursor>
		do
			Result := stream.is_closable
		end

	is_readable : BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_rewindable : BOOLEAN
			-- <Precursor>
		do
			Result := stream.is_rewindable
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Constants

	eol : STRING_8
			-- <Precursor>
		do
			Result := stream.eol
		end

feature -- Basic operations

	open_read
			-- <Precursor>
		do
			is_open_read := True
		end

	close
			-- <Precursor>
		do
			is_open_read := False
		end

	read_character
			-- <Precursor>
		do
			stream.read_character
		end

	unread_character (a_character: CHARACTER_8)
			-- <Precursor>
		do
			stream.unread_character (a_character)
		end

	read_line
			-- <Precursor>
		do
			stream.read_line
		end

	read_new_line
			-- <Precursor>
		do
			stream.read_new_line
		end

	read_string (nb : INTEGER_32)
			-- <Precursor>
		do
			stream.read_string (nb)
		end

feature -- Obsolete

feature -- Inapplicable

	make_file (a_name: STRING_8)
			-- <Precursor>
		do
			-- NOT IMPLEMENTED
		end

	delete
			-- <Precursor>
		do
			-- NOT IMPLEMENTED
		end

	concat (a_filename: STRING_8)
			-- <Precursor>
		do
			-- NOT IMPLEMENTED
		end

	copy_file (new_name : STRING_8)
			-- <Precursor>
		do
			-- NOT IMPLEMENTED
		end

	change_name (new_name : STRING_8)
			-- <Precursor>
		do
			-- NOT IMPLEMENTED
		end

	same_physical_file (other_name: STRING_8) : BOOLEAN
			-- <Precursor>
		do
			-- NOT IMPLEMENTED
		end

feature -- Constants

feature {NONE} -- Implementation

	stream : KL_STRING_INPUT_STREAM

invariant
	stream_attached: stream /= Void
	target_string_attached: target_string /= Void

end

--
-- Copyright: 2009-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
