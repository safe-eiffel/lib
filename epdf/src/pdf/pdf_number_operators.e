indexing
	description: 
	
		"PDF number operations"

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	PDF_NUMBER_OPERATORS


feature -- Status report


	equal_numbers (a, b : DOUBLE) : BOOLEAN is
			-- is a = b i.e the difference negligible ?
		do
			Result := ((a - b).abs < 0.0000001)
		end

feature -- Conversion

	formatted (d : DOUBLE) : STRING is
			-- format 'iiiiii' or 'iiiii.ffff'
		local
			integral, fraction : INTEGER
			sign : INTEGER
		do
			create Result.make (10)
			sign := d.sign
			integral := d.truncated_to_integer
			fraction := ((d - integral) * 10000 * sign).truncated_to_integer
			if integral = 0 and sign = - 1 then
				Result.append_character ('-')
			end
			Result.append_string (integral.out)
			if fraction > 0 then
				Result.append_character ('.')
				if fraction < 10 then
					Result.append_string ("000")
				elseif fraction < 100 then
					Result.append_string ("00")
				elseif fraction < 1000 then
					Result.append_string ("0")
				end
				Result.append_string (fraction.out)
			end
		end
		
end -- class PDF_NUMBER_OPERATORS
