note
	description: "Summary description for {C}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	C

inherit
	A
	select
		print_name
	end
	B
	rename
		print_name as print_b
	end
end
