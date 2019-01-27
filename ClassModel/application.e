note
	description: "EffelProjects application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			c: COURSE

			-- Run application.
		do
				--| Add your code here
			create c.create_class ("ITP", "B18")
			print (c.to_string)
		end

end
