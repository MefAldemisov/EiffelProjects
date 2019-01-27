note
	description: "Summary description for {RANDOMIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOMIZER

create
	make

feature{NONE}

	previous: INTEGER

feature

	get_number_in_range (range: INTEGER): INTEGER
			-- returns random number in a given range
		do
			previous := rd.next_random(previous)
			Result := previous \\ range
		ensure
			0 <= Result
			Result < range
		end

feature {NONE}

	rd: RANDOM
			-- embeded random

	make
			-- sets random seed equal to time
		local
			time: TIME
		do

			create time.make_now
			previous := time.compact_time
			create rd.set_seed (previous)
		end

end
