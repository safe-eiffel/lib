indexing
	description: "Identifiers of curses attribute constants features"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_ATTRIBUTE_CONSTANTS_IDS

feature -- Identifiers

    Id_attribute_attributes: INTEGER is 220
    Id_attribute_normal: INTEGER is 221
    Id_attribute_standout: INTEGER is 222
    Id_attribute_underline: INTEGER is 223
    Id_attribute_reverse: INTEGER is 224
    Id_attribute_blink: INTEGER is 225
    Id_attribute_dim: INTEGER is 226
    Id_attribute_bold: INTEGER is 227
    Id_attribute_altcharset: INTEGER is 228
    Id_attribute_invisible: INTEGER is 229
    Id_attribute_protected: INTEGER is 230
    Id_attribute_color: INTEGER is 231

end -- class RCURSES_ATTRIBUTE_CONSTANTS_IDS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
