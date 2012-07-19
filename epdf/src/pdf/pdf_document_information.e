indexing
	description: "Objects that are document information.  See PDF Reference 9.2.1."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_DOCUMENT_INFORMATION

inherit
	PDF_OBJECT
		redefine
			put_pdf
		end

create
	make
	
feature -- Access

	title : STRING
		--Title text string (Optional; PDF 1.1) The document’s title.
		
	author : STRING
		--Author text string (Optional) The name of the person who created the document.
		
	subject : STRING
		--Subject text string (Optional; PDF 1.1) The subject of the document.
		
	keywords : STRING
		--Keywords text string (Optional; PDF 1.1) Keywords associated with the document.
		
	creator : STRING
		--Creator text string (Optional) If the document was converted to PDF from another format, the name of the application (for example, Adobe FrameMaker®) that created the original document from which it was converted.
		
	producer : STRING
		--Producer text string (Optional) If the document was converted to PDF from another format, the name of the application (for example, Acrobat Distiller) that converted it to PDF.
		
	creation_date : DT_DATE_TIME
		--CreationDate date (Optional) The date and time the document was created, in human-readable form (see Section 3.8.2, “Dates”).
		
	modification_date : DT_DATE_TIME
		--ModDate date (Optional; PDF 1.1) The date and time the document was most recently modified, in human-readable form (see Section 3.8.2, “Dates”).
		
feature -- Measurement

feature -- Status report

	is_empty : BOOLEAN is
			-- 
		do
			Result := title = Void
			Result := Result and author = Void
			Result := Result and subject = Void
			Result := Result and keywords = Void
			Result := Result and creator = Void
			Result := Result and producer = Void
			Result := Result and creation_date = Void
			Result := Result and modification_date = Void
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_title (new_title : STRING) is
			-- set `title' to `new_title'
		require
			new_title_exists: new_title /= Void
		do
			title := new_title
		ensure
			title_set: title = new_title
		end
		
	set_author (new_author : STRING) is
			-- set `author' to `new_author'
		require
			new_author_exists: new_author /= Void
		do
			author := new_author
		ensure
			author_set: author = new_author
		end
		
	set_subject (new_subject : STRING) is
			-- set `subject' to `new_subject'
		require
			new_subject_exists: new_subject /= Void
		do
			subject := new_subject
		ensure
			subject_set: subject = new_subject
		end
		
	set_keywords (new_keywords : STRING) is
			-- set `keywords' to `new_keywords'
		require
			new_keywords_exist: new_keywords /= Void
		do
			keywords := new_keywords
		ensure
			keywords_set: keywords = new_keywords
		end
		
	set_creator (new_creator : STRING) is
			-- set `creator' to `new_creator'
		require
			new_creator_exists: new_creator /= Void
		do
			creator := new_creator
		ensure
			creator_set: creator = new_creator
		end
		
	set_producer (new_procuder : STRING) is
			-- set `producer' to `new_producer'
		require
			new_procuder_exists: new_procuder /= Void
		do
			producer := new_procuder
		ensure
			producer_set: producer = new_procuder
		end
		
	set_creation_date (new_creation_date : DT_DATE_TIME) is
			-- set `creation_date' to `new_creation_date'
		require
			new_creation_date_exists: new_creation_date /= Void
		do
			creation_date := new_creation_date
		ensure
			creation_date_set: creation_date = new_creation_date
		end
	
	set_modification_date (new_modification_date : DT_DATE_TIME) is
			-- set `modification_date' to `new_modification_date'
		require
			new_modification_date_exists: new_modification_date /= Void
		do
			modification_date := new_modification_date
		ensure
			modification_date_set: modification_date = new_modification_date
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	to_pdf : STRING is
			-- Current converted to PDF
		do
			Result := to_pdf_using_put_pdf			
		end
		
	put_pdf (medium: PDF_OUTPUT_MEDIUM) is
			-- Put Current as PDF into `medium'
		local
			name : PDF_NAME
		do
			medium.put_string (object_header)
			medium.put_string (Begin_dictionary)
			if title /= Void then
				create name.make ("Title")
				medium.put_string (dictionary_entry (name, pdf_string(title)))
			end
			if author /= Void then
				create name.make ("Author")
				medium.put_string (dictionary_entry (name, pdf_string(author)))
			end
			if subject /= Void then
				create name.make ("Subject")
				medium.put_string (dictionary_entry (name, pdf_string(subject)))
			end
			if keywords /= Void then
				create name.make ("Keywords")
				medium.put_string (dictionary_entry (name, pdf_string(keywords)))
			end
			if creator /= Void then
				create name.make ("Creator")
				medium.put_string (dictionary_entry (name, pdf_string(creator)))
			end
			if producer /= Void then
				create name.make ("Producer")
				medium.put_string (dictionary_entry (name, pdf_string(producer)))
			end
			if creation_date /= Void then
				create name.make ("CreationDate")
				medium.put_string (dictionary_entry (name, pdf_date (creation_date)))
			end
			if modification_date /= Void then
				create name.make ("ModDate")
				medium.put_string (dictionary_entry (name, pdf_date(modification_date)))
			end
			medium.put_string (End_dictionary)
			medium.put_string (Object_footer)
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

end -- class PDF_DOCUMENT_INFORMATION
