indexing
	description: "Identifiers of slk api features"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_SLK_API_IDS

feature -- Identifiers

	Id_slk_init: INTEGER is 200
	Id_slk_set: INTEGER is 201
	Id_slk_refresh: INTEGER is 202
	Id_slk_noutrefresh: INTEGER is 203
	Id_slk_label: INTEGER is 204
	Id_slk_clear: INTEGER is 205
	Id_slk_restore: INTEGER is 206
	Id_slk_touch: INTEGER is 207
	Id_slk_attron: INTEGER is 208
	Id_slk_attrset: INTEGER is 209
	Id_slk_attr: INTEGER is 210
	Id_slk_attroff: INTEGER is 211

end -- class RCURSES_SLK_API_IDS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
