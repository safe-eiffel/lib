indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUTORIAL_TEST

inherit

	FO_SHARED_FONT_FACTORY
	FO_MEASUREMENT_ROUTINES

feature -- Access

	document : FO_DOCUMENT
	writer : FO_DOCUMENT_WRITER

feature -- Constants

	color_red : FO_COLOR is once create Result.make_rgb (255,0,0) end
	color_black : FO_COLOR is once create Result.make_rgb (0,0,0) end
	color_green : FO_COLOR is once create Result.make_rgb (0,255,0) end
	color_blue : FO_COLOR is once create Result.make_rgb (0,0,255) end

feature  -- Basic operations

	create_document (file_name : STRING) is
			-- create `document' for writing into `file_name'.
		require
			file_name_not_void: file_name /= Void
		do
			create writer.make (file_name)
			create document.make (writer)
		ensure
			writer_not_void: writer /= Void
			document_not_void: document /= Void
		end

end
