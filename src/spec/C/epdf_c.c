
#include "epdf_c.h"
#include <epdf_c_spec.h>
#include <stdio.h>

/* compress data using zlib algorithm */
EIF_INTEGER zlib_compress (EIF_POINTER pDest, EIF_POINTER pDestLen, EIF_POINTER pSource, EIF_INTEGER SourceLen) {
	return (EIF_INTEGER) compress ((Bytef *)pDest,   (uLongf *) pDestLen,
                                 (const Bytef *) pSource, (uLong) SourceLen);
}

/* read png image */
uch *read_png (EIF_POINTER p_file_name, EIF_POINTER pChannels, EIF_POINTER pRowbytes,
		EIF_POINTER pWidth, EIF_POINTER pHeight,EIF_POINTER pBitDepth,EIF_POINTER pColorType,EIF_POINTER pInterlaceType) {
	//parameters
	char *file_name;

	//locals
	//int cha
	png_structp		png_ptr;
	png_infop		info_ptr;
	png_uint_32 	width;
	png_uint_32		height;
    	png_uint_32  i, rowbytes;
	int				bit_depth;
	int				color_type;
	int				interlace_type;
	FILE 			*fp;			/* Current opened file */
   	png_color_16 my_background, *image_background;
	double gamma;

    	png_bytepp  row_pointers = NULL;

	// open file
	file_name=(char*)p_file_name;
	fp = fopen (file_name, "rb");
	if (fp == NULL) {
		return NULL;
	}
	png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (png_ptr == NULL){
		fclose (fp);
		return NULL;
	}

	/* Allocate/initialize the memory for image information.  REQUIRED. */
	info_ptr = png_create_info_struct(png_ptr);
	if (info_ptr == NULL) {
		png_destroy_read_struct(&png_ptr, (png_infopp)NULL, (png_infopp)NULL);
		fclose (fp);
		return NULL;
	}

	/* Set error handling if you are using the setjmp/longjmp method (this is
	 * the normal method of doing things with libpng).  REQUIRED unless you
	 * set up your own error handlers in the png_create_read_struct() earlier.
	 */
	if (setjmp(png_ptr->jmpbuf)) {
		/* Free all of the memory associated with the png_ptr and info_ptr */
		png_destroy_read_struct(&png_ptr, &info_ptr, (png_infopp)NULL);

		/* If we get here, we had a problem reading the file */
		fclose (fp);
		return NULL;
	}

	/* One of the following I/O initialization methods is REQUIRED */
	/* Set up the input control if you are using standard C streams */
	png_init_io(png_ptr, fp);

	/* The call to png_read_info() gives us all of the information from the
	 * PNG file before the first IDAT (image data chunk).  REQUIRED
	 */
	png_read_info(png_ptr, info_ptr);

	png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type,
		&interlace_type, NULL, NULL);

	/* Set up the data transformations you want.  Note that these are all */
	/* optional.  Only call them if you want/need them.  Many of the      */
	/* transformations only work on specific types of images, and many    */
	/* are mutually exclusive.                                            */

	/* Extract multiple pixels with bit depths of 1, 2, and 4 from a single
	 * byte into separate bytes (useful for paletted and grayscale images).
	 */
	png_set_packing(png_ptr);

	/* Expand paletted colors into true RGB triplets */
	if (color_type == PNG_COLOR_TYPE_PALETTE)
		png_set_expand(png_ptr);

	/* Expand grayscale images to the full 8 bits from 1, 2, or 4 bits/pixel */
	if (color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
		png_set_expand(png_ptr);

    if (bit_depth == 16)
        png_set_strip_16(png_ptr);

	/* Expand paletted or RGB images with transparency to full alpha channels
	 * so the data will be available as RGBA quartets.
	 */
	if (png_get_valid(png_ptr, info_ptr, PNG_INFO_tRNS))
		png_set_expand(png_ptr);

	/* invert monocrome files to have 0 as white and 1 as black */
	//png_set_invert_mono(png_ptr);

	/* Add filler (or alpha) byte (before/after each RGB triplet) */
	if (color_type == PNG_COLOR_TYPE_RGB_ALPHA || color_type == PNG_COLOR_TYPE_GRAY_ALPHA) {
		png_set_filler(png_ptr, 0xff, PNG_FILLER_AFTER);
	}

        // after the transformations have been registered update info_ptr data

	png_read_update_info(png_ptr, info_ptr);

	// get again width, height and the new bit-depth and color-type

	png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type,
		&interlace_type, NULL, NULL);

	rowbytes = png_get_rowbytes(png_ptr, info_ptr);
    	*((EIF_INTEGER*)pRowbytes) = (EIF_INTEGER) rowbytes;
	*((EIF_INTEGER*)pChannels) = (EIF_INTEGER) png_get_channels(png_ptr, info_ptr);


	*((EIF_INTEGER*)pWidth) = (EIF_INTEGER) width;
	*((EIF_INTEGER*)pHeight) = (EIF_INTEGER) height;
	*((EIF_INTEGER*)pBitDepth) = (EIF_INTEGER) bit_depth;
	*((EIF_INTEGER*)pColorType) = (EIF_INTEGER) color_type;
	*((EIF_INTEGER*)pInterlaceType) = (EIF_INTEGER) interlace_type;

    if ((image_data = (uch *)malloc(rowbytes*height)) == NULL) {
        png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
		fclose (fp);
        return NULL;
    }
    if ((row_pointers = (png_bytepp)malloc(height*sizeof(png_bytep))) == NULL) {
        png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
        free(image_data);
        image_data = NULL;
		fclose (fp);
        return NULL;
    }

//    Trace((stderr, "readpng_get_image:  channels = %d, rowbytes = %ld, height = %ld\n", *pChannels, rowbytes, height));


    /* set the individual row_pointers to point at the correct offsets */

    for (i = 0;  i < height;  ++i)
        row_pointers[i] = image_data + i*rowbytes;


    /* now we can go ahead and just read the whole image */

    png_read_image(png_ptr, row_pointers);


    /* and we're done!  (png_read_end() can be omitted if no processing of
     * post-IDAT text/time/etc. is desired) */

    free(row_pointers);
    row_pointers = NULL;

    png_read_end(png_ptr, NULL);
	/* clean up after the read, and free any memory allocated - REQUIRED */
	png_destroy_read_struct(&png_ptr, &info_ptr, NULL);

	fclose (fp);

    return (EIF_POINTER) image_data;
}







