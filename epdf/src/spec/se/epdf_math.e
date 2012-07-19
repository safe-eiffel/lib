class 

	EPDF_MATH

feature

		sine (d : DOUBLE) : DOUBLE is
			do
				Result := d.sin
			end

		cosine (d : DOUBLE) : DOUBLE is
			do
				Result := d.cos
			end

		tangent (d : DOUBLE) : DOUBLE is
			do
				Result := d.tan
			end

		arc_tangent (d : DOUBLE) : DOUBLE is
			do
				Result := d.atan
			end
			
		sqrt (d : DOUBLE) : DOUBLE is
			do
				Result := d.sqrt
			end
			
end -- class EPDF_MATH
