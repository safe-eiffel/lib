indexing
	description: "Summary description for {TTF_NAMES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_NAMES

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (otf : OPEN_TYPE_FONT_FILE)
		do
			otf.read_natural_16
			format_selector := otf.last_natural_16
			otf.read_natural_16
			count := otf.last_natural_16
			otf.read_natural_16
			storage_offset := otf.last_natural_16
			create records.make (count)
			read_records_table (otf)
			storage_length := max_offset + max_offset_name_count
			otf.read_string (storage_length)
			storage := otf.last_string.twin
		end

feature -- Access

	format_selector : NATURAL_16
			--USHORT	Format selector (=0).
	count : NATURAL_16
			--USHORT	Number of NameRecords that follow n.

	storage_offset : NATURAL_16
			--USHORT	Offset to start of string storage (from start of table).

	records : DS_HASH_TABLE[TTF_NAME_RECORD,STRING_8]
			--n  NameRecords	The NameRecords.

	storage : STRING_8
		--(Variable)	Storage for the actual string data.

	storage_length : NATURAL_16

	queried_encoding : NATURAL_16
	queried_platform : NATURAL_16
	queried_language : NATURAL_16
	
feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Constants

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

	names (id : NATURAL_16) : DS_LIST[TTF_NAME_RECORD]
		do
			create {DS_LINKED_LIST[TTF_NAME_RECORD]}Result.make
			from
				records.start
			until
				records.after
			loop
				if records.item_for_iteration.name_id = id then
					Result.put_last (records.item_for_iteration)
				end
				records.forth
			end
		end

feature {NONE} -- Implementation


	read_records_table (otf : OPEN_TYPE_FONT_FILE)
		local
			i : NATURAL_16
			name_record : TTF_NAME_RECORD
		do
			from
				max_offset := 0
				max_offset_name_count := 0
				i := 1
			until
				i > count
			loop
				create name_record.make_from_file (otf)
				if name_record.name_offset > max_offset then
					max_offset := name_record.name_offset
					max_offset_name_count := name_record.name_count
				end
				records.force (name_record, name_record.key)
				i := i + 1
			end
		end

	max_offset : NATURAL_16
	max_offset_name_count : NATURAL_16

invariant
	invariant_clause: True -- Your invariant here

end
