indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"
	licensing: "See notice at end of class"

class
	GRAPHVIZ_PDF

inherit
	KL_SHARED_STANDARD_FILES
	
creation
	make

feature -- Initialization

	make is
		local
			file : KL_TEXT_INPUT_FILE
			stream : KI_TEXT_INPUT_STREAM
			r : KL_BINARY_OUTPUT_FILE
			tx, ty : DOUBLE
			npages_x, npages_y : INTEGER
			page_width, page_height : DOUBLE
			document_width, document_height : DOUBLE
			page_rectangle : PDF_RECTANGLE
			row_index, column_index : INTEGER
			p : PDF_PAGE
			exception : EXCEPTIONS
		do
			!!exception
			process_arguments
			if args_ok then
					
				if input_file_name /= Void then
					create file.make (input_file_name)
					file.open_read
					stream := file
				else
					stream := std.input
				end
				if stream.is_open_read then
					create reader.make (stream)
				else
					io.put_string ("File cannot be read!%N")
					exception.die (1)
				end
				print ("graphviz_pdf application%N")
				print ("   input file : "); print (stream.name); print ("%N")
				print ("   output file: "); print (output_file_name); print ("%N")
				print ("   page margin: "); print (page_margin.truncated_to_integer.out); print (" points%N")
				print ("   scaling    : "); print ((scaling * 100).truncated_to_integer.out); print (" %%%N")
				
				-- 
				-- page dimensions
				--
				document_width := reader.graph_width
				document_height := reader.graph_height
				--
				-- determine number of pages
				--
				!!page_rectangle.make_a4			
				page_width := page_rectangle.urx - 2 * page_margin
				page_height := page_rectangle.ury - 2 * page_margin
--				npages_x := (document_width / page_width - 0.01).truncated_to_integer + 1
--				npages_y := (document_height / page_height - 0.01).truncated_to_integer + 1			
				npages_x := (document_width * scaling / page_width - 0.01).truncated_to_integer + 1
				npages_y := (document_height * scaling / page_height - 0.01).truncated_to_integer + 1			
	
				!!document.make
				from
					row_index := 0
				until
					row_index = npages_y
				loop
					from
						column_index := 0
					until
						column_index = npages_x
					loop
						document.find_font ("Helvetica", document.Encoding_standard)
						p := document.last_page
						p.set_mediabox (page_rectangle)
						p.set_font (document.last_font, 8)
						setup_page (p, page_width, page_height)
						p.gsave
						tx := column_index * page_width 
						ty := (npages_y - (row_index + 1)) * page_height
						p.scale (scaling, scaling)
						p.translate ((- tx + page_margin)*(1/scaling), (- ty + page_margin)*(1/scaling))
						draw_pdf (p, reader.nodes)
						draw_pdf (p, reader.edges)
						p.grestore		
						column_index := column_index + 1
						if not (column_index = npages_x and then row_index = npages_y - 1) then
							document.add_page
						end
					end
					row_index := row_index + 1
				end
				create r.make (output_file_name)
				r.open_write
				if r.is_open_write then
					r.put_string (document.to_pdf)
					r.close
				else
					print ("Error : cannot open file '")
					print (output_file_name)
					print ("'%N")
				end
			else
				io.put_string ("Incorrect argument%N")
				io.put_string ("%Tusage: graphviz_pdf -output outfilename [-input infilename] [-margin m] [-scaling s|-scale s]%N")
				io.put_string ("%N")
			end
		end

	reader : GRAPHVIZ_PLAIN_READER
	
	document : PDF_DOCUMENT
	
	scaling 		: DOUBLE
	page_margin 	: DOUBLE
	input_file_name, output_file_name 		: STRING
	args_ok 		: BOOLEAN
	
	process_arguments is
		local
			a : ARGUMENTS
			index : INTEGER
			arg : STRING
		do
			--default values
			page_margin := 36
			scaling := 1
			-- process arguments
			!!a
			from
				index := 1
				args_ok := False
			until
				index > a.argument_count
			loop
				arg := a.argument (index)
				if arg.is_equal ("-input") then
					input_file_name := a.argument (index + 1)
					index := index + 1
				elseif arg.is_equal ("-output") then
					output_file_name := a.argument (index + 1)
					args_ok := True
					index := index + 1
				elseif arg.is_equal ("-margin") then
					if a.argument (index + 1).is_double then
						page_margin := a.argument (index + 1).to_double
					else
						page_margin := 36 -- 1/2 inch
					end
					index := index + 1
				elseif arg.is_equal ("-scaling") or else arg.is_equal ("-scale") then
					if a.argument (index + 1).is_double then
						scaling := a.argument (index + 1).to_double
					else
						scaling := 1
					end
					index := index + 1
				end
				index := index + 1
			end
		end
	
	draw_pdf (p : PDF_PAGE; l : DS_LIST[GRAPHVIZ_FIGURE]) is
		local
			c : DS_LIST_CURSOR [GRAPHVIZ_FIGURE]
		do
			from
				c := l.new_cursor
				c.start
			until
				c.off
			loop
				c.item.draw_pdf (p)
				c.forth
			end		
		end

	show_mark (p : PDF_PAGE; x, y : DOUBLE; dir_x, dir_y : INTEGER) is
			-- 
		require
			dirx: dir_x = 1 or else dir_x = -1
			diry: dir_y = 1 or else dir_y = -1
		local
			line_length : DOUBLE
		do
			line_length := 24
			p.gsave
			p.move (x + dir_x * line_length, y)
			p.lineto (x , y)
			p.lineto (x, y + dir_y * line_length)
			p.stroke
			p.grestore
		end
		
	setup_page (p : PDF_PAGE; page_width, page_height : DOUBLE) is
			-- 
		do
			-- page marks
			show_mark (p, p.mediabox.llx + page_margin-2, 
						   p.mediabox.lly + page_margin-2, -1, -1) -- ll
			show_mark (p, p.mediabox.urx - page_margin+2, 
						   p.mediabox.ury - page_margin+2, 1, 1) -- ur
			show_mark (p, p.mediabox.urx - page_margin+2, 
						   p.mediabox.lly + page_margin-2, 1, -1) -- lr
			show_mark (p, p.mediabox.llx + page_margin-2, 
						   p.mediabox.ury - page_margin+2, -1, 1) -- ul
			
			-- title
			p.set_font (p.current_font, 8)
			p.begin_text
			p.move_text_origin ( p.mediabox.llx + page_margin + 10, p.mediabox.ury - page_margin + 4)
			p.put_string ("Graphviz Plain to PDF     -     Developed in Eiffel     -     (c) Paul G. Crismer")
			p.end_text
			-- set clipping
			p.rectangle (+ page_margin-1, + page_margin-1, page_width+2, page_height+2)
			p.clip
			p.end_path
			
		end
			
end -- class GRAPHVIZ_PDF
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
