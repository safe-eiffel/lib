indexing
	description: "Names of supported PDF encodings."
	author: "Paul G. Crismer"
	usage: "mix-in"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_ENCODING_CONSTANTS

feature -- Constants

	Encoding_winansi : STRING is "WinAnsiEncoding"
				-- ANSI encoding for Latin languages
	
	Encoding_mac : STRING is "MacRomanEncoding"
				-- Latin text in western European languages
				
	Encoding_standard : STRING is "StandardEncoding"
				-- standard encoding.
				-- Use it for Symbol and ZapfDingbats fonts
	
	Encoding_pdf : STRING is "PDFDocEncoding"
				-- Encoding used outside of stream objects
				-- Not intented to be used.

end -- class PDF_ENCODING_CONSTANTS
