indexing
	description: "PDF Destinations"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_DESTINATION

inherit
	PDF_SERIALIZABLE
		undefine
			put_pdf
		end

feature -- Conversion

	to_pdf : STRING is
		do
			Result := to_pdf_using_put_pdf
		end

feature -- Inapplicable

	number : INTEGER is do  end

end -- class PDF_DESTINATION
