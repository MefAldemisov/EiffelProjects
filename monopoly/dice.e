note
	description: "Summary description for {DICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DICE

inherit

	RANDOMIZER

create
	make

feature

	throw: INTEGER
			-- returns the random integer with bound 6
		do
			print ("%NDice throws...")
			Result := get_number_in_range (6) + 1
			print ("%NYou are lucky, you get: " + Result.out)
		end

end
