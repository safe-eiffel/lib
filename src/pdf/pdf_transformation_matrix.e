indexing 

	description: "Transformation matrixes. 3x3 matrix organized like this : %N%
		% 	| a  b  0 |%N%
		% 	| c  d  0 |%N%
		% 	| e  f  1 |%N%
		% Transormation matrix operations take account of these properties."
	
class

	PDF_TRANSFORMATION_MATRIX
	
inherit
	ANY
		redefine
			copy
		end
		
create

	set_null, set_identity, set
	
feature -- Access

	a : DOUBLE
			-- M(1,1)
	b : DOUBLE
			-- M(1,2)
	c : DOUBLE
			-- M(2,1)
	d : DOUBLE
			-- M(2,2)
	e : DOUBLE
			-- M(3,1)
	f : DOUBLE
			-- M(3,2)
	
	determinant : DOUBLE is
		do
			Result := a * d - b * c
		end

feature -- Status Report

	is_identity : BOOLEAN is
			-- is this an identity matrix?
		do
			Result := (a = 1 and b = 0 and c = 0 and d = 1 and e = 0 and f = 0)
		end
				
feature -- Status setting

	set_null is 
			-- make null
		do 
			a := 0; b := 0; c := 0; d := 0; e := 0; f := 0 
		end
	
	set_identity is
		do
			a := 1; b := 0; c := 0; d := 1; e := 0; f := 0
		ensure
			identity: is_identity
		end

	set (aa, ab, ac, ad, ae, af : DOUBLE) is
			-- set matrix content
		do
			a := aa
			b := ab
			c := ac
			d := ad
			e := ae
			f := af
		ensure
			elements_set: a = aa; b = ab; c = ac; d =ad; e = ae; f = af
		end

	copy (other : like Current) is
			-- 
		do
			a := other.a
			b := other.b
			c := other.c
			d := other.d
			e := other.e
			f := other.f
		end
		
feature -- Basic operations
		
	multiply (n : like Current) : like Current is
			-- multiplication: not commutative
		local
			ra, rb, rc, rd, re, rf : DOUBLE
		do
		    ra := a * n.a + b * n.c;
		    rb := a * n.b + b * n.d;
		    rc := c * n.a + d * n.c;
		    rd := c * n.b + d * n.d;

		    re := e * n.a + f * n.c + n.e;
		    rf := e * n.b + f * n.d + n.f;
		    create Result.set (ra, rb, rc, rd, re, rf)			
		ensure
			-- Result = Current X n
		end
		
	infix "*" (n : like Current) : like Current is
			-- multiplication: not commutative
		do
			Result := multiply (n)
		ensure
			-- Result = Current X n
		end
		
	inverted : like Current is
		require
			determinant_not_too_small: determinant.abs > 0.00001
		local
			ra, rb, rc, rd, re, rf, det : DOUBLE
		do
			det := determinant
			ra := d/det;
			rb := -b/det;
			rc := -c/det;
			rd := a/det;
			re := -(e * ra + f * rc) -- re = -(e * (d/det) + f * (-c/det))
			rf := -(e * rb + f * rd) -- rf = -(e * (-b/det) + f * (a/det))
			create Result.set (ra, rb, rc, rd, re, rf)
		end

end -- class PDF_TRANSFORMATION_MATRIX	
