INCLUDE_PATH = -I$(ECURSES)\spec\se\windows

CC = cl
CFLAGS = -c -O2 -nologo -D"WIN32" $(INCLUDE_PATH)

LDFLAGS = /SUBSYSTEM:CONSOLE 

SHAREDLIBS = USER32.lib WSOCK32.lib ADVAPI32.lib GDI32.lib SHELL32.lib\
	COMDLG32.lib UUID.lib OLE32.lib OLEAUT32.lib COMCTL32.lib MPR.LIB ODBC32.LIB

EXTERNALS =  \
	$(ECURSES)\spec\se\windows\ecurses_c.lib \
	$(PDCURSES)\win32\pdcurses.lib \
	$(PDCURSES)\win32\panel.lib \
	$(ECURSES)\remote\spec\c\remote_curses.obj \
	$(ECURSES)\remote\ipc\C\ipc_c.lib

	
all:: rcurses_server.exe

rcurses_server.exe: *.c *.h
	$(CC) $(CFLAGS) *.c 	
	LINK $(LDFLAGS) /OUT:rcurses_server.exe *.obj $(EXTERNALS) $(SHAREDLIBS)