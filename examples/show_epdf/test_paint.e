indexing
	description: 
	
		"Objects that show PDF painting operators"

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	TEST_PAINT

inherit
	TEST_HELPER
	
feature -- Initialization

	do_test (d : PDF_DOCUMENT) is
			-- 
		local
			p : PDF_PAGE
		do
			p := d.last_page
			d.find_font ("Helvetica", d.Encoding_standard)
			p.set_font (d.last_font, 10)
			p.translate (0, p.mediabox.ury-200)
			test_gray (d, p)
			p.translate (0, -150)
			test_color (d, p)
			p.translate (0, -150)
			test_circles (d, p)
			p.translate (0, -150)
			test_winding_fill (d, p)
			p.translate (0, -150)
			test_even_odd_fill (d, p)
		end
		
	test_gray (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			gray : INTEGER
		do
			show_title_xy (100,130, "Gray", d, p)
			from
				gray := 0
			until
				gray > 124
			loop
				show_gray (gray, p)
				gray := gray + 1
			end
		end
	
	test_color (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			r, g, b : INTEGER
		do
			show_title_xy (100, 130, "Colors r,g,b", d, p)
			from
				r := 0
			until
				r > 4
			loop
				from
					g := 0
				until
					g > 4
				loop
					from
						b := 0
					until
						b > 4
					loop
						show_color (r, g, b, p)
						b := b + 1
					end
					g := g + 1
				end
				r := r + 1
			end
		end
	
	test_circles (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			show_title_xy (100, 130, "Circles", d, p)
			p.set_font (d.last_font, 8)
			p.gsave
			p.circle (150, 60, 50)
			p.stroke
			center_label (150, 0, "circle (counter-clock)",p)
			p.circle_2 (270, 60, 50)
			p.stroke
			center_label (270, 0, "circle_2 (clockwise)",p)
			p.arc (390, 60, 50, p.math.Pi/8, (2*p.math.Pi)-p.math.Pi/8)
			p.stroke
			center_label (390, 0, "arc",p)
			p.pie (510, 60, 50, p.math.Pi/8, -2*p.math.Pi+p.math.Pi/4)
			p.stroke
			center_label (510, 0, "pie",p)
		end
		
	test_winding_fill (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			p.gsave
			show_title_xy (100, 130, "Fill - NonZero Winding Number rule", d,p)
			p.set_gray (0.75)
			p.set_non_zero_winding_rule
			test_fill (d,p)
			p.grestore
		end
		
	test_even_odd_fill (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			p.gsave
			show_title_xy (100, 130, "Fill - Even Odd rule", d,p)
			p.set_even_odd_rule
			p.set_gray (0.75)
			test_fill (d, p)
			p.set_non_zero_winding_rule
			p.grestore
		end
	
	test_fill (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			p.gsave
			p.translate (150, 0)
			show_star (60,50, 50, p)
			p.translate (120, 0)
			show_ring1 (60, 50, 50, p)
			p.translate (120, 0)
			show_ring2 (60, 50, 50, p)
			p.grestore
		end
		
	show_ring1 (x, y, r : DOUBLE; p : PDF_PAGE) is
			-- 
		do
			p.circle (x, y, r)
			p.circle (x, y, r/2)
			p.fill_then_stroke
		end
	
	show_ring2 (x, y, r : DOUBLE; p : PDF_PAGE) is
			--
		do
			p.circle (x, y, r)
			p.circle_2 (x, y, r/2)
			p.fill_then_stroke
		end
		
		
	show_gray (gray : INTEGER; p : PDF_PAGE) is	
		local
			row, column : DOUBLE
			actual_gray : DOUBLE
		do
			row := gray // 25
			column := gray \\ 25
			actual_gray := gray / 124
			p.gsave
			p.set_gray (actual_gray)
			p.rectangle (100 + column * 15, row * 15, 12, 12)
			p.fill
			p.grestore
		end

	show_color (r, g, b : INTEGER; p : PDF_PAGE) is
			-- 
		local
			row, column : DOUBLE
			actual_r, actual_g, actual_b : DOUBLE
		do
			row := r
			column := g * 5 + b
			actual_r := r / 4
			actual_g := g / 4
			actual_b := b / 4
			p.gsave
			p.set_rgb_color (actual_r, actual_g, actual_b)
			p.rectangle (100 + column * 15, row * 15, 12, 12)
			p.fill
			p.grestore			
		end
		
end -- class TEST_PAINT
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
