indexing
	description: 
	
		"Octal format conversion routines"

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	OCTAL_FORMAT
	
creation
	make

feature -- Initialization

	make is
			-- 
		do
			
		end
		
feature -- Access

	last_value : INTEGER
	
feature -- Status report

	last_value_octal : BOOLEAN
	
feature -- Conversion

	from_string (s : STRING) is
		require
			s.is_integer
		local
			decimal : INTEGER
			digit : INTEGER
			multiplier : INTEGER
		do
			from
				decimal := s.to_integer
				last_value_octal := True
				last_value := 0
				multiplier := 1
			until
				decimal = 0 or not last_value_octal	
			loop
				digit := decimal \\ 10
				decimal := decimal // 10
				if digit <= 7 then
					last_value := last_value + digit * multiplier
					multiplier := multiplier * 8
				else
					last_value_octal := False
				end
			end
		ensure	
		end

	to_string (o : INTEGER) : STRING is
			-- 
		local
			octal : INTEGER
			digit : INTEGER
			multiplier : INTEGER
		do
			create Result.make (0)
			from
				octal := o
			until
				octal = 0	
			loop
				digit := octal \\ 8
				octal := octal // 8
				Result.prepend (digit.out)
			end
		end
		
end -- class OCTAL_FORMAT
