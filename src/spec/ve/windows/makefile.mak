CC = cl
PLATFORM=windows
CFLAGS = -c -Ox -W3 -Zl -I$(VE_BIN) -I. -I$(ZLIB) -I$(LIBPNG)
OBJ = epdf_c.obj

all:: epdf_c_msc.lib

.c.obj:
	$(CC) $(CFLAGS) ..\..\C\$< 

epdf_c_msc.lib: $(OBJ) ..\..\C\epdf_c.h
	-del $@
	lib /OUT:$@ $(OBJ)

epdf_c.obj: ..\..\C\epdf_c.c ..\..\C\epdf_c.h
	$(CC) $(CFLAGS) ..\..\C\epdf_c.c

clean:
	-del *.obj
	-del *.lib
