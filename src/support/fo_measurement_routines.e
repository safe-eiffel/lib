indexing

	description: 
	
		"Measurement helper routines."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_MEASUREMENT_ROUTINES

feature {NONE} -- Access

	cm, centimeters (p_cm : DOUBLE) : FO_MEASUREMENT is
		do
			create Result.centimeters (p_cm)
		end
		
	in, inches (p_in : DOUBLE) : FO_MEASUREMENT is
		do
			create Result.inches (p_in)
		end
		
	mm, millimeters (p_mm : DOUBLE) : FO_MEASUREMENT is
		do
			create Result.millimeters (p_mm)
		end
		
	pt, points (p_pt : DOUBLE) : FO_MEASUREMENT is
		do
			create Result.points (p_pt)
		end
		
	unit (u : DOUBLE) : FO_MEASUREMENT is
		do
			create Result.points (u)
		end
		
end

