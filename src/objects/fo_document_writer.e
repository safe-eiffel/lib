indexing
	description:

		"Objects that write rendered documents."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_DOCUMENT_WRITER

creation
	make

feature {NONE} -- Initialization

	make (document_file_name : STRING) is
			-- Make for writing file `document_file_name'.
		require
			document_file_name_not_void: document_file_name /= Void
			document_file_name_not_empty: not document_file_name.is_empty
		do
			file_name := document_file_name
		ensure
			file_name_set: file_name = document_file_name
		end

feature -- Access

	file_name : STRING
			-- File name used for writing.

	document : PDF_DOCUMENT
			-- PDF document to write.

feature -- Status report

	is_open : BOOLEAN

feature -- Basic operations

	open is
			-- Open.
		do
			create file.make (file_name)
			file.open_write
			if file.is_open_write then
				create document.make
				create medium.make (file)
				is_open := True
			end
		ensure
			is_open: is_open implies (document /= Void and then file /= Void and then file.is_open_write and then medium /= Void)
		end

	close is
			-- Close.
		require
			is_open: is_open
		do
			document.put_pdf (medium)
			file.close
			is_open := False
		ensure
			is_closed: not is_open
		end

feature {NONE} -- Implementation

	file : KL_BINARY_OUTPUT_FILE
			-- Output file.

	medium : PDF_OUTPUT_MEDIUM
			-- PDF output medium.

	current_page : PDF_PAGE is
			-- Current PDF page being rendered.
		require
			is_open: is_open
		do
			Result := document.last_page
		end

end
