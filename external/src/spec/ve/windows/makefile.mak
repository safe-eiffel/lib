CC = cl
PLATFORM=windows
CFLAGS = -c -Ox -W3 -Zl -I$(VE_BIN) -I.
OBJ = xs_c.obj

all:: xs_c_msc.lib

.c.obj:
	$(CC) $(CFLAGS) ..\..\C\$< 

xs_c_msc.lib: $(OBJ) ..\..\C\xs_c.h
	-del $@
	lib /OUT:$@ $(OBJ)

xs_c.obj: ..\..\C\xs_c.c ..\..\C\xs_c.h
	$(CC) $(CFLAGS) ..\..\C\xs_c.c

clean:
	-del *.obj
	-del *.lib
