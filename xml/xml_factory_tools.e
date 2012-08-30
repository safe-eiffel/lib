note
	description: "XML factory tools and conversion routines"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FACTORY_TOOLS

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

	to_string (text : STRING) : STRING
			-- `text' converted to STRING
		do
			if text /= Void then
				Result := text.string
			end
		end
		
	to_date (text : STRING) : DT_DATE
			-- `text' converted to DT_DATE
		local
			string : STRING
		do
			if text /= Void then
				string := text.string
				if xsd_date.is_valid (string) then
					Result := xsd_date.to_date (string)
				end
			end
		end
		
	to_date_time (text : STRING) : DT_DATE
			-- `text' converted to DT_DATE_TIME
		local
			string : STRING
		do
			if text /= Void then
				string := text.string
				if xsd_date_time.is_valid (string) then
					Result := xsd_date_time.to_date_time (string)
				end
			end
		end

	to_time (text : STRING) : DT_TIME
			-- `text' converted to DT_TIME
		local
			string : STRING
		do
			if text /= Void then
				string := text.string
				if xsd_time.is_valid (string) then
					Result := xsd_time.to_time (string)
				end
			end
		end
		
	to_integer (text : STRING) : INTEGER_REF
			-- `text' converted to INTEGER_REF
		local
			string : STRING			
		do
			if text /= Void then
				string := text.string
				if string.is_integer then
					Result := string.to_integer
				end
			end
		end

	to_integer_64 (text : STRING) : INTEGER_64_REF
			-- `text' converted to INTEGER_64_REF
		local
			string : STRING			
		do
			if text /= Void then
				string := text.string
				if string.is_integer then
					Result := string.to_integer_64
				end
			end
		end
		
	to_double (text : STRING) : DOUBLE_REF
			-- `text' converted to DOUBLE_REF
		local
			string : STRING
		do
			if text /= Void then
				string := text.string
				if string.is_double then
					Result := string.to_double
				end
			end
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	xsd_date : XSD_DATE once create Result end
	xsd_time : XSD_TIME once create Result end
	xsd_date_time : XSD_DATE_TIME once create Result end
	
end -- class XML_FACTORY_TOOLS
