indexing

	description:

		"Objects that control datastore access"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class PO_DATASTORE

feature -- Access

	adapters : DS_LIST[PO_ADAPTER [PO_PERSISTENT]] is
			-- adapters registered for operating on this datastore
		deferred
		end

feature -- Measurement

	transaction_level : INTEGER
			-- count of embedded transactions
	
feature -- Status report

	is_connected : BOOLEAN is
			-- is the datastore connected ?
		deferred
		end
		
	is_error : BOOLEAN is
			-- is there an error caused by the latest operation?
		deferred
		end

	valid_connection_parameters : BOOLEAN is
			-- are the connection parameters valid ?
		deferred
		end
	
	can_begin_transaction : BOOLEAN is
			-- can this datastore begin a new transaction ?
		deferred
		end
		
feature -- Status setting

	connect is
			-- connect to datastore
		require
			valid_connection_parameters: valid_connection_parameters
		deferred
		ensure
			connected_if_no_error: not is_error implies is_connected
		end

	disconnect is
			-- disconnect from datastore
		require
			is_connected: is_connected
		deferred
		ensure
			disconnected: not is_connected
		end
feature -- Cursor movement

feature -- Element change

	register_adapter (an_adapter : PO_ADAPTER[PO_PERSISTENT]) is
			-- register `an_adapter' to datastore
		require
			an_adapter_not_void: an_adapter /= Void
			an_adapter_not_already_registered: not adapters.has (an_adapter)
		do
			adapters.put_last (an_adapter)
		ensure
			registered: adapters.has (an_adapter)
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	begin_transaction is
			-- begin a new transaction
		require
			can_begin_transaction: can_begin_transaction
		deferred	
		ensure
			begun_transaction: transaction_level = old transaction_level + 1
		end
	
	commit_transaction is
			-- commits the current transaction
		require
			in_transaction: transaction_level > 0
		deferred
		ensure
			ended_transaction: transaction_level = old transaction_level - 1	
		end
	
	rollback_transaction is
			-- rollbacks the current transaction
		require
			in_transaction: transaction_level > 0
		deferred
		ensure
			ended_transaction: transaction_level = old transaction_level - 1	
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation
		
end
