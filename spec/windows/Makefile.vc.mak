ECURSES_PATH = e:\paul\eiffel\library\ecurses
EIFFEL_PATH = d:\USER\DEV\EIFFEL43
INCLUDE_PATH = -I$(ECURSES_PATH)\spec\windows
SHELL = \bin\sh
CC = cl
CPP = cl
CFLAGS = -Ox -YX -nologo  -DWORKBENCH -I$(EIFFEL_PATH)\bench\spec\windows\include $(INCLUDE_PATH)
CPPFLAGS = -Ox -YX-nologo  -DWORKBENCH -I$(EIFFEL_PATH)\bench\spec\windows\include $(INCLUDE_PATH)
LDFLAGS =  -SUBSYSTEM:CONSOLE 
LDSHAREDFLAGS =  -dll -incremental:no
EIFLIB = $(EIFFEL_PATH)\bench\spec\windows\lib\msc\wkbench.lib
LIBS = 
MAKE = nmake
AR = 
LD = 
MKDEP =   --
MV = copy
RANLIB = echo
RM = del
RMDIR = rd
SHAREDLINK = link
SHAREDLIBS = USER32.lib WSOCK32.lib ADVAPI32.lib GDI32.lib\
	COMDLG32.lib UUID.lib OLE32.lib OLEAUT32.lib
COMMAND_MAKEFILE = 

.SUFFIXES:.cpp

.c.obj::
	$(CC) $(CFLAGS) -c $< 

.cpp.obj::
	$(CPP) $(CPPFLAGS) -c $< 

all : $(ECURSES_PATH)\spec\Clib\ecurses_acs_characters.obj $(ECURSES_PATH)\spec\Clib\ecurses_attributes.obj $(ECURSES_PATH)\spec\Clib\ecurses_color_constants.obj $(ECURSES_PATH)\spec\Clib\ecurses_key_constants.obj $(ECURSES_PATH)\spec\Clib\ecurses_window_api.obj $(ECURSES_PATH)\spec\Clib\ecurses_panel_api.obj $(ECURSES_PATH)\spec\Clib\ecurses_slk_api.obj $(ECURSES_PATH)\spec\Clib\ecurses_system_api.obj $(ECURSES_PATH)\spec\Clib\ecurses_pad_api.obj
	lib /VERBOSE ecurses_acs_characters.obj ecurses_attributes.obj ecurses_color_constants.obj ecurses_key_constants.obj ecurses_window_api.obj ecurses_panel_api.obj ecurses_slk_api.obj ecurses_system_api.obj  ecurses_pad_api.obj /OUT:$(ECURSES_PATH)\spec\windows\ecurses_c.lib
	
