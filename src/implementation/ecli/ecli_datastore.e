indexing

	description:

		"ECLI implementation of PO_DATASTORE."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ECLI_DATASTORE

inherit

	PO_DATASTORE

create

	make

feature {NONE} -- Initialisation

	make (a_session : ECLI_SESSION) is
			-- Initialise with `a_session'.
		require
			a_session_not_void : a_session /= Void
			a_session_ready_to_connect: a_session.is_ready_to_connect
		do
			session_impl := a_session
			create adapters_impl.make
		ensure
			session_set: session_impl = a_session
			adapters_not_void: adapters /= Void and then adapters.is_empty
		end

feature -- Access

	session: ECLI_SESSION is
			-- Session Ecli.
		do
			Result := session_impl
		end

	adapters : DS_LIST [PO_ADAPTER[PO_PERSISTENT]] is
			--
		do
			Result := adapters_impl
		end

feature -- Status report

	is_connected : BOOLEAN is
			-- is the datastore connected ?
		do
			Result := session.is_connected
		end

	is_error : BOOLEAN is
			-- is there an error caused by the latest operation?
		do
			Result := session.is_error
		end

	valid_connection_parameters : BOOLEAN is
			-- are the connection parameters valid ?
		do
			Result := True
		end

	can_begin_transaction : BOOLEAN is
			-- can this datastore begin a new transaction ?
		do
			Result := is_connected and session.is_transaction_capable
		end

feature -- Status setting

	connect is
			-- Connect to datastore.
		do
			session.connect
			on_connected
		end

	disconnect is
			-- Disconnect from datastore.
		do
			on_disconnect
			session.disconnect
		end

feature -- Basic operations

	begin_transaction is
			-- Begin a new transaction.
		do
			session.begin_transaction
			transaction_level := transaction_level + 1
		end

	commit_transaction is
			-- Commits the current transaction.
		do
			session.commit
			transaction_level := transaction_level - 1
		end

	rollback_transaction is
			-- Rollbacks the current transaction.
		do
			session.rollback
			transaction_level := transaction_level - 1
		end

feature {NONE} -- Implementation

	session_impl : ECLI_SESSION

	adapters_impl : DS_LINKED_LIST[PO_ADAPTER[PO_PERSISTENT]]

	on_connected is
		local
			adapters_cursor : DS_LIST_CURSOR [PO_ADAPTER[PO_PERSISTENT]]
		do
			if is_connected then
				adapters_cursor := adapters.new_cursor
				from
					adapters_cursor.start
				until
					adapters_cursor.off
				loop
					adapters_cursor.item.on_adapter_connected
					adapters_cursor.forth
				end
			end
		end

	on_disconnect is
		local
			adapters_cursor : DS_LIST_CURSOR [PO_ADAPTER[PO_PERSISTENT]]
		do
			if not is_connected then
				adapters_cursor := adapters.new_cursor
				from
					adapters_cursor.start
				until
					adapters_cursor.off
				loop
					adapters_cursor.item.on_adapter_disconnect
					adapters_cursor.item.clear_cache
					adapters_cursor.forth
				end
			end
		end


invariant

	session_not_void: session /= Void

end
