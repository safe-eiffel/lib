note

	description:

			"Information messages."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class QA_INFORMATION

inherit

	QA_ERROR

create

	make_copyright,
	make_banner,
	make_license,
	make_start,
	make_end,
	make_generating,
	make_processing_file

feature {NONE} -- Initialization

	make_copyright (author, period : STRING)
			-- Make copyright message with `author' for `period'.
		require
			author_not_void: author /= Void
			period_not_void: period /= Void
		do
			default_template := cprght_template
			create parameters.make (1,2)
			parameters.put (author, 1)
			parameters.put (period, 2)
		end

	make_processing_file (in_filename : STRING)
			-- Make processing file `in_filename'.
		require
			in_filename_not_void: in_filename /= Void
		do
			default_template := processing_file_template
			create parameters.make (1,1)
			parameters.put (in_filename, 1)
		end

	make_banner (version : STRING)
			-- Make banner `version'.
		require
			version_not_void: version /= Void
		do
			default_template := banner_template
			create parameters.make (1,1)
			parameters.put (version, 1)
		end


	make_license (license_name, version : STRING)
			-- Make license message for `license_name', `version'.
		require
			license_name_not_void: license_name /= Void
			version_not_void: version /= Void
		do
			default_template := license_template
			create parameters.make (1,2)
			parameters.put (license_name, 1)
			parameters.put (version, 2)
		end


	make_start (process : STRING)
			-- Make information on starting `process'.
		require
			process_not_void: process /= Void
		do
			default_template := procstart_template
			create parameters.make (1, 1)
			parameters.put (process, 1)
		end

	make_generating (generated : STRING)
			-- Make information on generating `generated'.
		require
			generated_not_void: generated /= Void
		do
			default_template := generating_template
			create parameters.make (1, 1)
			parameters.put (generated, 1)
		end

	make_end (process : STRING; success : BOOLEAN)
			-- Make information on ending `process' with `success'.
		require
			process_not_void: process /= Void
		do
			if success then
				default_template := procend_template
			else
				default_template := procfail_template
			end
			create parameters.make (1, 1)
			parameters.put (process, 1)
		end

feature -- Access

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

	procstart_template : STRING = "$1 : start."
	procend_template : STRING =   "$1 : end."
	procfail_template : STRING =  "$1 : fail."
	cprght_template : STRING =    "***        Copyright $2 by $1."
	license_template : STRING =   "***        Released under $1 license, version $2."
	banner_template : STRING =    "***    $0 Application $1."
    generating_template : STRING = "+ Generating $1."
    processing_file_template: STRING = "***        Processing file: $1."

end -- class QA_INFORMATION
