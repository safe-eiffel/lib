indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PO_ECLI_ERROR_HANDLER

inherit
	PO_ERROR_HANDLER

create
	make_standard,
	make_null

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
