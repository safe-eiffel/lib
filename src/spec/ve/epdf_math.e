class 

	EPDF_MATH


inherit
   MATH
      rename 
      	sqrt as single_sqrt
      export
         {NONE} all;
         {ANY} pi
      end

feature

	sine (d : DOUBLE) : DOUBLE is
		do
			Result := sin( d.truncated_to_real )
		end

	cosine (d : DOUBLE) : DOUBLE is
		do
			Result := cos( d.truncated_to_real )
		end

	tangent (d : DOUBLE) : DOUBLE is
		do
			Result := tan( d.truncated_to_real )
		end

	arc_tangent (d : DOUBLE) : DOUBLE is
		do
			Result := arctan( d.truncated_to_real )
		end

	sqrt (d : DOUBLE) : DOUBLE is
		do
			Result := single_sqrt (d.truncated_to_real)
		end
		
end -- class EPDF_MATH
