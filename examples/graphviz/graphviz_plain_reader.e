indexing
	description: "Objects that read Graphviz-generated plain format."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHVIZ_PLAIN_READER

creation
	make

feature -- Initialization

	make (medium : KI_TEXT_INPUT_STREAM) is
			--
		require
			medium /= Void and then medium.is_open_read
		do
			!!nodes.make
			!!edges.make
			from
				
			until
				stop_reading or else medium.end_of_input
			loop
				read_line (medium)
				debug ("reading")
					print ("read '")
					print (last_line)
					print ("'%N")
				end
				if last_line.count > 0 then
					process_line (last_line)
				end
			end
		end
			
feature -- Access

	nodes : DS_LINKED_LIST [GRAPHVIZ_NODE]
	edges : DS_LINKED_LIST [GRAPHVIZ_EDGE]

	graph_width   : DOUBLE
	graph_height  : DOUBLE
	scaling : DOUBLE
	
feature -- Measurement

	last_node : GRAPHVIZ_NODE
	last_edge : GRAPHVIZ_EDGE

feature {NONE} -- Implementation

	read_node (s : STRING) is
		local
			sname, sx, sy, swidth, sheight, slabel, sline, sshape : STRING
			scolor : GRAPHVIZ_COLOR
			x, y, width, height : DOUBLE
			w : WORDER2
			error : BOOLEAN
		do
			split_words (s)
			if words.count >= 10 and then words.item (1).is_equal ("node") then
				sname := words.item (2)
				sx := words.item (3)
				sy := words.item (4)
				swidth := words.item (5)
				sheight := words.item (6)
				slabel := words.item (7)
				sline := words.item (8)
				sshape := words.item (9)					
				if words.count = 10 then
					scolor := colors.by_name (words.item (10))
				elseif words.count = 12 then						
					!!scolor.make_rgb (words.item (10).to_double,
									words.item (11).to_double,
									words.item (12).to_double)
				end
				if sx.is_double then
					x := sx.to_double * pts_in_inch
				else
					error := True
				end
				if sy.is_double then
					y := sy.to_double * pts_in_inch
				else
					error := True
				end
				if swidth.is_double then
					width := swidth.to_double * pts_in_inch
				else
					error := True
				end
				if sheight.is_double then
					height := sheight.to_double * pts_in_inch
				else
					error := True
				end
				if not error then
					!!last_node.make (sname, x, y, width, height, slabel, sline, sshape,scolor)
				else
					last_node := Void
				end
			end
		end
		
	read_edge (s : STRING) is
		local
			stail, shead, sn, spx, spy, slabel, slabelx,slabely,sline : STRING
			scolor : GRAPHVIZ_COLOR
			error : BOOLEAN
			ax : ARRAY[DOUBLE]
			ay : ARRAY[DOUBLE]
			coord_count : INTEGER
			lx, ly : DOUBLE
			w : WORDER2
			line_index, remaining_count : INTEGER
		do
			split_words (s)
			if words.count > 4 and then words.item (1).is_equal ("edge") then
				stail := words.item (2)
				shead := words.item (3)
				sn := words.item (4)
				if sn.is_integer then
					coord_count := sn.to_integer
					!!ax.make (1, coord_count)
					!!ay.make (1, coord_count)
					check
						words.count >= 4 + coord_count * 2
					end
					from
						coord_count := 0
					until
						coord_count = ax.count
					loop
						spx := words.item (5+coord_count * 2)
						spy := words.item (5+coord_count * 2 + 1)
						ax.put (spx.to_double * pts_in_inch, coord_count + 1)
						ay.put (spy.to_double * pts_in_inch, coord_count + 1)
						coord_count := coord_count + 1
					end
					line_index := 5 + coord_count * 2
					
					-- [label labelx labely] line color (wordcount = {2, 5, 4, 7})
					-- label exists if wordcount in {5, 7}
					-- line color (2 or 4)
					-- color ::= colorname | r g b
					remaining_count := words.count - line_index + 1
					inspect remaining_count
					when 5, 7 then
						slabel := words.item (line_index)
						lx := words.item (line_index+1).to_double * pts_in_inch
						ly := words.item (line_index+2).to_double * pts_in_inch
						line_index := line_index + 3
					else
					end
					-- line color
					remaining_count := words.count - line_index + 1
					inspect remaining_count
					when 2, 4 then
						sline := words.item (line_index)
						if remaining_count = 2 then
							scolor := colors.by_name (words.item (line_index + 1))						
						else
							!!scolor.make_rgb (words.item (line_index+1).to_double,
								words.item (line_index+2).to_double,
								words.item (line_index+3).to_double)
						end
					else
					end						
--						if not w.off then
--							-- optional label?
--							slabel := w.last_word
--							w.forth; slabelx := w.last_word
--							w.forth; slabely := w.last_word
--							lx := slabelx.to_double * pts_in_inch
--							ly := slabely.to_double * pts_in_inch
--							if not w.off then
--								w.forth; sline := w.last_word
--								w.forth; scolor := w.last_word
--							end
--						end

						
						!!last_edge.make (stail, shead, ax, ay, slabel, lx, ly, sline, scolor)
				else
					last_edge := Void
				end
			end
		end

	read_graph (s : STRING) is
		local
			w : WORDER2
		do
			!!w.make (s)
			w.start
			if w.last_word.is_equal ("graph") then
				if not w.off then
					w.forth; scaling := w.last_word.to_double
					w.forth; graph_width  := w.last_word.to_double * pts_in_inch
					w.forth; graph_height  := w.last_word.to_double * pts_in_inch
				end
			end
		end

	pts_in_inch : INTEGER is 72
 
 	words : ARRAY[STRING]
 	
 	split_words (s : STRING) is
 			-- 
 		local
 			w : WORDER2
 		do
 			!!w.make (s)
 			!!words.make (1,0)
 			from
 				w.start
 			until
 				w.off
 			loop
 				words.force (w.last_word, words.count + 1)
 				w.forth
 			end
 			if w.last_word /= Void then
 				words.force (w.last_word, words.count + 1)
 			end
 		end
 
 	colors : GRAPHVIZ_COLORS is
 			-- 
 		once
 			!!Result
 		end
 	
 	process_line (s : STRING) is
 			-- 
 		do
			inspect s.item (1)
			when 'n' then
				read_node (s)
				if last_node /= Void then
					nodes.put_last (last_node)
				end
			when 'e' then
				read_edge (s)
				if last_edge /= Void then
					edges.put_last (last_edge)
				end
			when 'g' then
				read_graph (s)
			when 's' then
				stop_reading := True
			else
			end
 		end
 		
 	stop_reading : BOOLEAN
 	
 	last_line : STRING
 	
 	read_line (f : KI_TEXT_INPUT_STREAM) is
 			-- 
 		require
 			f /= void and f.is_open_read
 		do
 			from 
 				!!last_line.make (256)
 				f.read_character
 			until
 				f.end_of_input or else f.last_character = '%N'
 			loop
 				inspect f.last_character
 				when  '%R' then
 					
 				else
 					last_line.append_character (f.last_character)
 				end
 				f.read_character
 			end
 		end
 		
end -- class GRAPHVIZ_PLAIN_READER
	