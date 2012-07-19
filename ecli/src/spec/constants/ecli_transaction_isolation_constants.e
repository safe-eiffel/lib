indexing

	description:
	
			"Transaction isolation constants - Used as bitmask in Sql_txn_isolation_option."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	copyright: "Copyright (c) 2001-2006, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

	usage: "buy or inherit.  When inheriting,  export {NONE} all."

class ECLI_TRANSACTION_ISOLATION_CONSTANTS

feature -- Constants

	--  Sql_txn_isolation_option bitmasks 
	Sql_txn_read_uncommitted, 
	Sql_transaction_read_uncommitted :	INTEGER is	1

	Sql_txn_read_committed, 
	Sql_transaction_read_committed:		INTEGER is	2

	Sql_txn_repeatable_read,	
	Sql_transaction_repeatable_read :	INTEGER is	4

	Sql_txn_serializable, 
	Sql_transaction_serializable:		INTEGER is	8

feature -- Status report

	is_valid_transaction_isolation_option (a_value : INTEGER) : BOOLEAN is
			-- 
		do
			inspect a_value
			when 1,2,4,8 then
				Result := True
			else
				Result := False
			end
		end
		
end
