indexing
	description: "Panel with a border, a header and a footer. %
		    % A client subwindow is available %
		    % It does not overlap neither the border nor the header or the footer";
	date: "$Date$";
	revision: "$Revision$"

class 
	CURSES_FRAME_PANEL

inherit
	CURSES_PANEL
		redefine post_creation_command
		end

create
	make, make_standard_panel

feature
	client : CURSES_WINDOW

feature {NONE} -- implementation

	post_creation_command is
	    do
		make_frame
		Precursor
	    end

	make_frame is
		-- actual making of the frame
	    local
		head_h, foot_h : INTEGER
	    do
		-- set borders
		set_standard_border
		refresh
		-- create subwindow
		if header_height = 0 then
		   head_h := 1
		else
		    head_h := header_height
		end
		if footer_height = 0 then
		   foot_h := 1
		else
		    foot_h := footer_height
		end
		!!client.make_subwindow_relative(
			Current, height - head_h - foot_h,width - 2,
			head_h, 1)
	    end

	header_height : INTEGER is
		     -- height of frame header
		do
		end

	footer_height : INTEGER is
		     -- height of frame footer
		do
		end

	
end -- class CURSES_FRAME_PANEL
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

