indexing
	description: "Caches that implement the LRU Algorithm."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PO_LRU_HASHED_CACHE [G -> PO_PERSISTENT]

inherit
	PO_HASHED_CACHE [G]
		redefine
			item,
			make,
			put,
			put_void,
			remove
		end

create
	make

feature {NONE} -- Initialization

	make (new_capacity: INTEGER_32) is
			-- <precursor>
		do
			Precursor (new_capacity)
			create lru_entries.make (new_capacity)
		end

feature -- Access

	time : INTEGER_64

	item (pid: PO_PID) : G is
		do
			increment_time
			Result := precursor (pid)
			lru_entries.item (pid.as_string).record_access (time)
		end

feature -- Status report

	full : BOOLEAN is
		do
			Result := table.count = capacity
		end


feature -- Element change

	increment_time is
		do
			time := time + 1
		end

	put (object: G) is
		local
			pid : PO_PID
			entry : PO_LRU_ENTRY
		do
			increment_time
			pid := object.pid
			if full then
				remove_lru
			end
			create entry.make (pid)
			entry.record_access (time)
			lru_entries.put (entry, pid.as_string)
			Precursor (object)
		end

	put_void (pid: PO_PID) is
		local
			entry : PO_LRU_ENTRY
		do
			increment_time
			if full then
				remove_lru
			end
			create entry.make (pid)
			entry.record_access (time)
			lru_entries.put (entry, pid.as_string)
			Precursor (pid)
		end

	remove (pid: PO_PID) is
		do
			debug ("PO_LRU")
				print ("Removing " + pid.as_string + "%N")
			end
			lru_entries.remove (pid.as_string)
			Precursor (pid)
		end

feature {NONE} -- Implementation

	lru_entries : DS_HASH_TABLE[PO_LRU_ENTRY,STRING]

	remove_lru is
		require
			full: full
		local
			lru : PO_LRU_ENTRY
			cursor : DS_HASH_TABLE_CURSOR[PO_LRU_ENTRY, STRING]
		do
			from
				cursor := lru_entries.new_cursor
				cursor.start
			until
				cursor.off
			loop
				if lru = Void then
					lru := cursor.item
				else
					if cursor.item.time < lru.time then
						lru := cursor.item
					end
				end
				cursor.forth
			end
			debug ("PO_LRU")
				print ("LRU found : " + lru.pid.as_string + " current time: " + time.out + " LRU time: " + lru.time.out + "%N%T")
			end
			remove (lru.pid)
		ensure
			not_full: not full
		end

invariant
	lru_entries_not_void: lru_entries /= Void

end
