indexing
	description: "Identifiers of panel api features"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_PANEL_API_IDS

feature -- Identifiers

	Id_panel_window: INTEGER is 150
	Id_update_panels: INTEGER is 151
	Id_hide_panel: INTEGER is 152
	Id_show_panel: INTEGER is 153
	Id_del_panel: INTEGER is 154
	Id_top_panel: INTEGER is 155
	Id_bottom_panel: INTEGER is 156
	Id_new_panel: INTEGER is 157
	Id_panel_above: INTEGER is 158
	Id_panel_below: INTEGER is 159
	Id_set_panel_userptr: INTEGER is 160
	Id_panel_userptr: INTEGER is 161
	Id_move_panel: INTEGER is 162
	Id_replace_panel: INTEGER is 163
	Id_panel_hidden: INTEGER is 164

end -- class RCURSES_PANEL_API_IDS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

