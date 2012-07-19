indexing
	description: "Identifiers of curses system api features"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_SYSTEM_API_IDS

feature -- Identifiers

	Id_def_prog_mode: INTEGER is 180
	Id_def_shell_mode: INTEGER is 181
	Id_reset_prog_mode: INTEGER is 182
	Id_reset_shell_mode: INTEGER is 183
	Id_resetty: INTEGER is 184
	Id_savetty: INTEGER is 185
	Id_getsyx: INTEGER is 186
	Id_setsyx: INTEGER is 187
	Id_curs_set: INTEGER is 188
	Id_napms: INTEGER is 189
	Id_unctrl: INTEGER is 190
	Id_keyname: INTEGER is 191

end -- class RCURSES_SYSTEM_API_IDS

-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------
