indexing
	description: "Objects that give default values."

class FO_DEFAULTS

inherit

	FO_MEASUREMENT_ROUTINES

	PDF_ENCODING_CONSTANTS

feature -- Access

	font_family : STRING is
		do
			Result := "Helvetica"
		end

	font_size : FO_MEASUREMENT is
		do
			create Result.points (12)
		end

	font_encoding : STRING is
		do
			Result := encoding_winansi
		end


	document_margins : FO_MARGINS is
		do
			create Result.set (cm(1), cm (1), cm (1), cm (1))
		end

	document_rectangle : FO_RECTANGLE is
		do
			create {FO_PAGE_SIZE}Result.make_a4
		end

	block_margins : FO_MARGINS is
		do
			create Result.make
		end

	table_margins : FO_MARGINS is
		do
			create Result.make
		end

end
