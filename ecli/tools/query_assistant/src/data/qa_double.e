indexing
	description: "CLI SQL DOUBLE value."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	QA_DOUBLE

inherit
	ECLI_DOUBLE
	
	QA_VALUE


create
	make
	
feature


	ecli_type : STRING is "ECLI_DOUBLE"
		
	value_type : STRING is "DOUBLE"

	creation_call : STRING is
		do
			Result := make_call
		end

		
end -- class QA_DOUBLE
--
-- Copyright (c) 2000-2006, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
