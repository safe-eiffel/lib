indexing
	description: "Line segment"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	LINE_SEGMENT

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

creation
	make_2_points, make_polar

feature -- Initialization

	make_2_points (a_p0x, a_p0y, a_p1x, a_p1y : DOUBLE) is
			-- 
		local
			dx, dy : DOUBLE
		do
			-- origin
			p0x := a_p0x
			p0y := a_p0y
			-- destination
			p1x := a_p1x
			p1y := a_p1y
			--
			dx := p1x - p0x
			dy := p1y - p0y
			-- slope
			infinite_slope := (dx).abs < 0.00000001
			if not infinite_slope then
				slope_impl := dy/dx
			end
			-- theta
			if not infinite_slope then
				theta := math.arc_tangent (slope)
			else
				if dy > 0 then
					theta := math.pi / 2
				elseif dy < 0 then
					theta := - math.pi / 2
				end
			end
			length := math.sqrt (dx^2 + dy^2)
		end
	
	make_polar (a_length, a_theta : DOUBLE) is
			-- 
		local
			halfpidivided : DOUBLE
			halfpi : DOUBLE
		do
			theta := a_theta
			length := a_length
			halfpi := math.Pi / 2.0
			halfpidivided := theta / halfpi
			if (halfpidivided - (halfpidivided.truncated_to_integer)).abs < 0.0000001  then
				infinite_slope := True
			else
				slope_impl := math.tangent (theta)
			end	
			p0x := 0
			p0y := 0
			p1x := length * math.cosine (theta)
			p1y := length * math.sine (theta)
		end
		
feature -- Access

	theta : DOUBLE
		-- arc_tangent (slope)
		
	slope : DOUBLE is
			-- 
		require
			not infinite_slope
		do
			Result := slope_impl
		end

	
	p0x, p0y : DOUBLE
		-- origin point
	
	p1x, p1y : DOUBLE
		-- destination point
	
	upside_down : INTEGER is
		do
			if p1x >= p0x then
				Result := +1
			else
				Result := - 1
			end
		end
feature -- Measurement

	length : DOUBLE
		-- length of the segment
		
feature -- Status report

	infinite_slope : BOOLEAN
		
feature {NONE} -- Implementation

	slope_impl : DOUBLE

	math : EPDF_MATH is
			-- 
		once
			!!Result
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class LINE_SEGMENT
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
