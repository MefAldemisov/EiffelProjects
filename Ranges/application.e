note
	description: "Ranges application root class"
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
			r1, r2: RANGE
			-- test ranges
		do
				--| Add your code here
			print ("%NStart...%N")
			create r1.make (1, 10)
			create r2.make (5, 12)
			r1.
			print (r1.subtract (r2).to_string)
		end

end
