/*************************************************************************
*
*	Portable external support library for Eiffel
*
**************************************************************************/

#include "xs_c.h"

/* memory and address routines */
EIF_POINTER c_memory_pointer_plus (EIF_POINTER pointer, EIF_INTEGER offset) {
	return (EIF_POINTER) (((char *)pointer) + (long)offset);
}

void c_memory_copy (EIF_POINTER destination, EIF_POINTER source, EIF_INTEGER length) {
	memcpy ((char *)destination, (char *)source, (long) length);
}

EIF_POINTER c_memory_allocate (EIF_INTEGER size) {
	return (EIF_POINTER) calloc ((long) size, 1);
}

EIF_POINTER c_memory_resize (EIF_POINTER p, EIF_INTEGER size) {
	return (EIF_POINTER) realloc (p, (long) size);
}

void c_memory_free (EIF_POINTER pointer) {
	free ((char *)pointer);
}

EIF_INTEGER c_memory_short_to_integer (EIF_POINTER pointer) {
	return (EIF_INTEGER) (*((short *)pointer));
}

void c_memory_put_char (EIF_POINTER pointer, EIF_CHARACTER v) { *((char*)pointer) = (char) v; };
void c_memory_put_int8 (EIF_POINTER pointer, EIF_INTEGER v) { *((char*)pointer) = (char) v; };
void c_memory_put_int16 (EIF_POINTER pointer, EIF_INTEGER v) { *((short*)pointer) = (short) v; };
void c_memory_put_int32 (EIF_POINTER pointer, EIF_INTEGER v) { *((int*)pointer) = (int) v; };
void c_memory_put_int64 (EIF_POINTER pointer, EIF_INTEGER_64 v) { *((EIF_INTEGER_64*)pointer) = (EIF_INTEGER_64) v; };
void c_memory_put_uint8 (EIF_POINTER pointer, EIF_INTEGER v) { *((unsigned char*)pointer) = (unsigned char) v; };
void c_memory_put_uint16 (EIF_POINTER pointer, EIF_INTEGER v) { *((unsigned short*)pointer) = (unsigned short) v; };
void c_memory_put_uint32 (EIF_POINTER pointer, EIF_NATURAL_32 v) { *((EIF_NATURAL_32*)pointer) = (EIF_NATURAL_32) v; };
void c_memory_put_uint64 (EIF_POINTER pointer, EIF_NATURAL_64 v) { *((EIF_NATURAL_64*)pointer) = (EIF_NATURAL_64) v; };
void c_memory_put_real (EIF_POINTER pointer, EIF_REAL v) { *((float*)pointer) = (float) v; };
void c_memory_put_double (EIF_POINTER pointer, EIF_DOUBLE v) { *((double*)pointer) = (double) v; };
void c_memory_put_pointer (EIF_POINTER pointer, EIF_POINTER v) { *((void**)pointer) = (void *) v; };

EIF_CHARACTER c_memory_get_char (EIF_POINTER pointer) { return (EIF_CHARACTER) (*((char*)pointer));};
EIF_INTEGER c_memory_get_int8 (EIF_POINTER pointer) { return (EIF_INTEGER) (*((char*)pointer));};
EIF_INTEGER c_memory_get_int16 (EIF_POINTER pointer) { return (EIF_INTEGER) (*((short*)pointer));};
EIF_INTEGER c_memory_get_int32 (EIF_POINTER pointer) { return (EIF_INTEGER) (*((int*)pointer));};
EIF_INTEGER_64 c_memory_get_int64 (EIF_POINTER pointer) { return (EIF_INTEGER_64) (*((EIF_INTEGER_64*)pointer));};
EIF_INTEGER c_memory_get_uint8 (EIF_POINTER pointer) { return (EIF_INTEGER) (*((unsigned char*)pointer));};
EIF_INTEGER c_memory_get_uint16 (EIF_POINTER pointer) { return (EIF_INTEGER) (*((unsigned short*)pointer));};
EIF_NATURAL_32 c_memory_get_uint32 (EIF_POINTER pointer) { return (EIF_NATURAL_32) (*((EIF_NATURAL_32*)pointer));};
EIF_NATURAL_64 c_memory_get_uint64 (EIF_POINTER pointer) { return (EIF_NATURAL_64) (*((EIF_NATURAL_64*)pointer));};
EIF_REAL c_memory_get_real (EIF_POINTER pointer) { return (EIF_REAL) (*((float*)pointer));};
EIF_DOUBLE c_memory_get_double (EIF_POINTER pointer) { return (EIF_DOUBLE) (*((double*)pointer));};
EIF_POINTER c_memory_get_pointer (EIF_POINTER pointer) { return (EIF_POINTER) (*((void**)pointer));};

/* unsigned routines */
EIF_INTEGER c_u_add32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 + e2);}
EIF_INTEGER c_u_subtract32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 - e2);}
EIF_INTEGER c_u_divide32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 / e2);}
EIF_INTEGER c_u_multiply32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 * e2);}
EIF_INTEGER c_u_remainder32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 % e2);}
EIF_INTEGER c_u_left_shift32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 << e2);}
EIF_INTEGER c_u_right_shift32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 >> e2);}
EIF_INTEGER c_u_and32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 & e2);}
EIF_INTEGER c_u_or32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 | e2);}
EIF_INTEGER c_u_xor32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 ^ e2);}
EIF_INTEGER c_u_not32  (unsigned long e1) { return (EIF_INTEGER) (~ e1);}
EIF_INTEGER c_u_lt32 (unsigned long e1, unsigned long e2) { return (EIF_INTEGER) (e1 < e2); }
EIF_INTEGER c_u_eq32 (unsigned long e1, unsigned long e2) {return (EIF_INTEGER) (e1 == e2); }
EIF_INTEGER c_u_setbit32 (unsigned long e1, EIF_INTEGER n) {return (EIF_INTEGER) (e1 | (1 << (n-1)));}
EIF_INTEGER c_u_getbit32 (unsigned long el, EIF_INTEGER n) {return (EIF_INTEGER) ((el & (1 << (n-1)))>0?1:0); }
EIF_INTEGER c_u_as_signed8 (EIF_INTEGER v) { return (EIF_INTEGER) ((char) v);}
EIF_INTEGER c_u_as_signed16 (EIF_INTEGER v) { return (EIF_INTEGER) ((short) v);}

