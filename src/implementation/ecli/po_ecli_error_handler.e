indexing
	description: "Error handlers for ECLI queries/cursors."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PO_ECLI_ERROR_HANDLER

inherit
	PO_ERROR_HANDLER

create
	make_standard,
	make_null,
	make_tee

feature {NONE} -- Initialization

	make_tee (an_error_handler : UT_ERROR_HANDLER) is
			-- make a T with `an_error_handler'.
		require
			an_error_handler_not_void: an_error_handler /= Void
		do
			set_info_file (an_error_handler.info_file)
			set_error_file (an_error_handler.error_file)
			set_warning_file (an_error_handler.warning_file)
		end

feature -- Basic operations

	report_query_error (an_adapter, a_feature : STRING; a_query : ECLI_QUERY) is
			-- Report Query error in {`an_adapter'}.`a_feature' for `a_query'.
		require
			an_adapter_not_void: an_adapter /= Void
			a_feature_not_void: a_feature /= Void
			a_query_not_void: a_query /= Void
		local
			error : PO_ECLI_ERROR
		do
			create error.make_query_error (an_adapter, a_feature, a_query)
			report_error (error)
		end

end
