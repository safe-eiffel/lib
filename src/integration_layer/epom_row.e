indexing
	description: " Virtual relational representation of a persistent object %
				 % the representation is close to the logical structure of the database "
	author: "Paul George Crismer, Fafchamps Eric"
	cluster: "PERSISTENT_OBJECT_MANAGEMENT"
	keywords: "virtual,database,representation,gateway"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_ROW


feature -- Acces

	session: ECLI_SESSION
			-- Database session

feature -- Status report

	error: UT_ERROR
			-- Error of last operation.

feature -- Basic operations

	retrieve (an_epom_query_frame: EPOM_QUERY_FRAME)  is
			-- Retrieve table row from database.
		require
			query_frame_defined: an_epom_query_frame /= Void
		deferred
		end
		
	update is
			-- Update database from row.
		deferred
		end

	insert is
			-- Insert into database from row.
		deferred
		end

	delete is
			-- Delete in database current row.
		deferred
		end
	
end -- class EPOM_ROW

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
