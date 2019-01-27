note
	description: "Summary description for {ROOT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROOT

feature
	print_name
		deferred
		end

	function: STRING
	do
		Result := "Mama ama criminal"
	end
end
