note
	description: "Access to shared XML factory tools"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_SHARED_FACTORY_TOOLS

feature -- Access

	xml_tools : XML_FACTORY_TOOLS
			-- xml factory tools
		once
			create Result
		end
		
end -- class XML_SHARED_FACTORY_TOOLS
