indexing
	description: 
	
		"Render states."
		
	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_RENDER_STATE

feature -- Access

	is_render_inside : BOOLEAN is
		-- Is rendering busy?
		do
			Result := not is_render_off
		end

	is_render_off : BOOLEAN is
		do
			Result := render_state = render_state_before or else render_state = render_state_after
		end

	is_render_before : BOOLEAN is
		do
			Result := render_state = render_state_before
		end

	is_render_after : BOOLEAN is
		do
			Result := render_state = render_state_after
		end

feature {NONE} -- Access

	render_state : INTEGER

	render_state_before : INTEGER is 0
	render_state_inside : INTEGER is 1
	render_state_after : INTEGER is 2

feature -- Measurement

feature {NONE} -- Status report

	set_render_before is
		do
			render_state := render_state_before
		end

	set_render_inside is
		do
			render_state := render_state_inside
		end

	set_render_after is
		do
			render_state := render_state_after
		end

	update_render_state (all_after, one_inside : BOOLEAN) is
		do
			if all_after then
				set_render_after
			elseif one_inside then
				set_render_inside
			else
				set_render_before
			end
		end

end
