note
	description: "Summary description for {CHANCE_SQUARES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHANCE_SQUARES

inherit

	SQUARE
		redefine
			land
		end

feature {NONE}

	last_earning: INTEGER
			-- the last encreasing of the buind

	max_value: INTEGER = 200
			-- max value, that player can get here

feature

	land (p: PLAYER)
			-- adds random sum, less then max_value to a player account
		local
			rd: RANDOMIZER
		do
			create rd.make
			last_earning := rd.get_number_in_range (max_value)
			p.earn (last_earning)
		end

	describe
			-- describes the curren cell
		do
			print ("%NChance: you earned " + last_earning.out)
		end

end
