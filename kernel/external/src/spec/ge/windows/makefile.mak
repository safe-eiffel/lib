CC = cl
ISE_PLATFORM=windows
CFLAGS = -c -Ox -W2 -I$(GOBO)\tool\gec\runtime\c -I.
OBJ = xs_c_msc.obj

all:: xs_c_var clean xs_c_msc.lib

.c.obj:
	$(CC) $(CFLAGS) ..\..\C\$< 

xs_c_msc.lib: $(OBJ) ..\..\C\xs_c.h
	-del $@
	lib /OUT:$@ $(OBJ)

xs_c_msc.obj: xs_c_var ..\..\C\xs_c.c ..\..\C\xs_c.h
	$(CC) $(CFLAGS) /Foxs_c_msc.obj ..\..\C\xs_c.c
#	-ren xs_c.obj xs_c_msc.obj

clean:
	-del *.obj
	-del *.lib

xs_c_var:
! IFNDEF SAFE_KERNEL
!    ERROR SAFE_KERNEL environment variable not set ! Set it first, then make the build.
! ENDIF
! IFNDEF ISE_EIFFEL
!    ERROR ISE_EIFFEL environment variable not set ! Set it first, then make the build.
! ENDIF