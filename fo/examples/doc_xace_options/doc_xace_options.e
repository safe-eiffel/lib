indexing

	description:

		"EFOTUTORIAL System's root class"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	DOC_XACE_OPTIONS

inherit

	KL_SHARED_EXECUTION_ENVIRONMENT
	KL_SHARED_FILE_SYSTEM

	FO_MEASUREMENT_ROUTINES

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			create options_file.make ("E:\Eiffel\gobo\doc\gexace\options.txt")
			create factory.make ("style_catalog.xml", create {UT_ERROR_HANDLER}.make_standard)
			options_file.open_read
			options_file.read_options
			options_file.close
			filter_options
			create_document
			create_index
			put_document

		end

feature -- Access

	current_option : XACE_OPTION

	options_file : XACE_OPTIONS_FILE

	current_document : FO_DOCUMENT

	current_writer : FO_DOCUMENT_WRITER

	system_options : DS_ARRAYED_LIST[STRING]
	cluster_options : DS_ARRAYED_LIST[STRING]
	class_options : DS_ARRAYED_LIST[STRING]
	feature_options : DS_ARRAYED_LIST[STRING]

	current_options : XACE_OPTIONS

	current_target_prefix: STRING

feature -- Basic operations

	filter_options is
			-- Filter options keeping ise_ecf options only
		do
			create system_options.make (options_file.system_options.count)
			filter_ise_ecf_options (system_options, options_file.system_options.options)
			create cluster_options.make (options_file.cluster_options.count)
			filter_ise_ecf_options (cluster_options, options_file.cluster_options.options)
			create class_options.make (options_file.class_options.count)
			filter_ise_ecf_options (class_options, options_file.class_options.options)
			create feature_options.make (options_file.feature_options.count)
			filter_ise_ecf_options (feature_options, options_file.feature_options.options)
		end

	create_document is
			-- Create document
		local
			header : FO_HEADER_FOOTER
			footer : FO_HEADER_FOOTER
			page_count : FO_PAGE_COUNT
			page_number : FO_CURRENT_PAGE_NUMBER
		do
			create current_writer.make ("Xace_options.pdf")
--			current_writer.open
			factory.create_document (current_writer)
			current_document := factory.last_document
			-- Open Document
			current_document.open
			-- Header
			factory.create_block ("Header")
			create header.make (factory.last_block.margins, mm(3))
			factory.create_inline ("Header")
			header.append (factory.last_inline)
			header.append_string ("Gexace Options Documentation")
			header.center_justify
			-- Footer
			factory.create_block ("Footer")
			create footer.make (factory.last_block.margins, mm(3))
			factory.create_inline ("Footer")
			footer.append (factory.last_inline)
			footer.append_string ("Page ")
			footer.append (create {FO_CURRENT_PAGE_NUMBER}.make)
			footer.append (create {FO_INLINE}.make (" of "))
			footer.append (create {FO_PAGE_COUNT}.make)
			footer.center_justify
			-- Set header/footer
			current_document.set_header (header)
			current_document.set_footer (footer)
			-- Treat options
			current_target_prefix := tprefix_system
			put_option_section (system_options, options_file.system_options)
			current_target_prefix := tprefix_cluster
			put_option_section (cluster_options, options_file.cluster_options)
			current_target_prefix := tprefix_class
			put_option_section (class_options, options_file.class_options)

			put_summary (<< [system_options, options_file.system_options],
							[cluster_options, options_file.cluster_options],
							[class_options, options_file.class_options]>>)
--			current_document.close
--			current_writer.close
		end

	create_index is
			-- Create index
		do

		end

	put_summary ( a : ARRAY[TUPLE[names: DS_LIST[STRING];options : XACE_OPTIONS]]) is
		local
			title : FO_BLOCK
			section : FO_BLOCK
		do
			-- Title
			factory.create_block ("Heading 1")
			title := factory.last_block
			title.enable_page_break_before
			factory.create_inline ("Heading 1")
			factory.last_inline.append_string ("Summary")
			title.append (factory.last_inline)

			-- Option | Description | values | default
			current_document.append_block (title)
		end

	put_document is
			-- Put document
		do
			current_document.close
		end

	put_option_section (names : DS_ARRAYED_LIST[STRING]; options : XACE_OPTIONS) is
		local
			paragraph_split : ST_SPLITTER
			paragraphs : DS_LIST[STRING]
		do
			create paragraph_split.make_with_separators ("%N")
			current_document.append_block (title_block (options.name))
			paragraphs := paragraph_split.split_greedy (options.description)
			from
				paragraphs.start
			until
				paragraphs.after
			loop
				current_document.append_block (title_description_block (paragraphs.item_for_iteration))
				paragraphs.forth
			end
			names.do_all (agent put_named_option (?,options))
		end

	put_named_option (a_name : STRING; options : XACE_OPTIONS) is
		local
			option : XACE_OPTION
			block : FO_BLOCK
			table : FO_TABLE
			l_description : STRING
		do
			option := options.options.item (a_name)
			block := option_title_block (option.name)
--			block.set_target (create {FO_TARGET}.make (current_target_prefix + option.name))
			current_document.append_block (block)
			table := new_option_table
--			description
			if option.description /= Void then
				l_description := option.description.twin
				l_description.replace_substring_all ("%N  ", " ")
			end
			put_option_item_row (table, "Description", l_description)
--			example
			put_option_item_row (table, "Example", option.example)
--			values
			put_option_item_row_values (table, "Values", option.values)
--			default_value
			put_option_item_row (table, "Default", option.default_value)
--			nota_bene
			put_option_item_row (table, "Note", option.nota_bene)
--			ise_ecf := Void
			put_option_item_row_correspondence (table, "ECF", option.ise_ecf)
			current_document.append_table (table)
		end

	put_option_item_row (table : FO_TABLE; title : STRING; value : STRING)
		local
			v : STRING
		do
			if value /= Void then
				v := value.twin
				v.replace_substring_all ("%N  ", "%N")
				if v.item(1)=' ' then
					v.remove_head (1)
				end
				table.append_new_row
				table.last_row.put (new_cell_block (title, t_style_name_cell), 1)
				table.last_row.put (new_cell_block (v, t_style_description_cell), 2)
			end
		end

	put_option_item_row_values (table : FO_TABLE; title : STRING; values : DS_LIST[STRING])
		local
			v : STRING
			b : FO_BLOCK
			i : FO_INLINE
		do
			put_option_item_row (table, title, "")
			b ?= table.last_row.item(2)
			from
				create v.make (10)
				values.start
			until
				values.after
			loop
				b.append (factory.new_inline (values.item_for_iteration, "DescriptionCellValue"))
				if values.item_for_iteration /= values.last then
					b.append (factory.new_inline (" | ", "DescriptionCell"))
				end
				values.forth
			end
		end

	put_option_item_row_correspondence (table : FO_TABLE; title : STRING; value : STRING)
		local
			v : STRING
			b : FO_BLOCK
			i : FO_INLINE
			split : ST_SPLITTER
			values : DS_LIST[STRING]
			s : STRING
		do
			put_option_item_row (table, title, "")
			b ?= table.last_row.item(2)
			if value /= Void then
				v := value .twin
				v.replace_substring_all ("->", "%/174/")
				create split.make_with_separators ("%/174/")
				values := split.split (v)
				from
					values.start
				until
					values.after
				loop
					factory.create_inline ("DescriptionCellValue")
					i := factory.last_inline
					s := values.item_for_iteration.twin
					s.replace_substring_all ("%N  ", "%N")
					if s.count >= 2 and then s.substring (1, 2).is_equal ("  ") then
						s.remove_head (2)
					end
					if s.count > 1 then
						from
						until
							s.count < 1 or else s.item (1) /= '%N'
						loop
							s.remove_head (1)
						end
						from
						until
							s.count < 1 or else s.item(s.count) /= '%N'
						loop
							s.remove_tail (1)
						end
					end
					i.append_string (s)
					b.append (i)
					if values.item_for_iteration /= values.last then
						create i.make_with_font (" %/174/ ", symbol_font)
						b.append (i)
					end
					values.forth
				end
			end
		end

	symbol_font : FO_FONT
		local
			sff : FO_SHARED_FONT_FACTORY
		do
			create sff
			sff.font_factory.find_font_weight_style_encoding ("Symbol", "", "", "StandardEncoding", pt(12))
			Result := sff.font_factory.last_font
		end

	new_arrowright_inline : FO_INLINE
		do
			create Result.make_with_font (" %/174/ ", symbol_font)
		end
	title_block (a_title : STRING) : FO_BLOCK
		do
			factory.create_block_inline ("Heading 1")
			Result := factory.last_block
			Result.append_string (a_title)
		end

	title_description_block (a_string: STRING) : FO_BLOCK
		do
			factory.create_block_inline ("Normal")
			Result := factory.last_block
			Result.append_string (a_string)
		end

	option_title_block (a_title: STRING) : FO_BLOCK
		do
			factory.create_block_inline ("Heading 2")
			Result := factory.last_block
			Result.append_string (a_title)
		end

	filter_ise_ecf_options (names : DS_ARRAYED_LIST[STRING]; options : DS_HASH_TABLE[XACE_OPTION,STRING]) is
			--
		local
			c : DS_HASH_TABLE_CURSOR[XACE_OPTION,STRING]
			sorter : DS_HEAP_SORTER [STRING]
		do
			from
				c := options.new_cursor
				c.start
			until
				c.off
			loop
				if c.item.is_ise_ecf then
					names.put_last (c.key)
				end
				c.forth
			end
			create sorter.make (create {KL_COMPARABLE_COMPARATOR[STRING]}.make)
			sorter.sort (names)
		end

feature -- Constants

	tprefix_system : STRING = "syst#"
	tprefix_class: STRING = "clas#"
	tprefix_cluster: STRING = "clus#"
	tprefix_feature: STRING = "feat#"

	t_style_name_cell : STRING = "NameCell"
	t_style_description_cell : STRING = "DescriptionCell"

feature -- Implementation

	factory : FO_CONFIGURABLE_FACTORY

	new_table_margins : FO_MARGINS
		do
			create Result.set (mm(2), mm(2), mm(2), mm(2))
		end

	new_cell_margins : FO_MARGINS
		do
			create Result.set (mm(2), mm(2), mm(2), mm(0))
		end

	new_cell_block (content, style : STRING) : FO_BLOCK
		local
			inline : FO_INLINE
		do
			factory.create_block_inline (style)
			Result := factory.last_block
			Result.append_string (content)
		end

	new_option_table : FO_TABLE
		do
			create Result.make (2, << cm (1), cm (4)>>)
			Result.set_align (create {FO_ALIGNMENT}.make_justify)
			-- Justification makes widths relative.
			Result.set_margins (new_table_margins)
		end

end -- class EFOTUTORIAL
