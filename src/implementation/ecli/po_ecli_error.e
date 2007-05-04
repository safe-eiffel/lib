indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PO_ECLI_ERROR

inherit
	PO_ERROR

create
	make_query_error

feature {NONE} -- Initialization

	make_query_error (an_adapter, a_feature : STRING; a_query : ECLI_QUERY) is
			-- Report Query error in {`an_adapter'}.`a_feature' for `a_query'.
		require
			an_adapter_not_void: an_adapter /= Void
			a_feature_not_void: a_feature /= Void
			a_query_not_void: a_query /= Void
		do
			default_template := tpl_query_error
			code := code_query_error
			create parameters.make (1, 6)
			parameters.put (code, 1)
			parameters.put (an_adapter, 2)
			parameters.put (a_feature, 3)
			parameters.put (a_query.native_code.out, 4)
			parameters.put (a_query.diagnostic_message, 5)
			parameters.put (a_query.sql, 6)
		ensure
			default_template_set: default_template = tpl_query_error
			code_set: code = code_query_error
		end

feature {NONE} -- Implementation

	tpl_query_error : STRING is "[$1] {$2}.$3 : Qery Error Native-code='$4' Message=<<$5>> Query=<<$6>>"

	code_query_error : STRING is "EPOM-E-SQLERR"
	
end
