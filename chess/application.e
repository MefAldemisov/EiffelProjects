note
	description: "Chess application root class"
	author: "MefAldemisov"
	date: "$20.11.2018$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			game: GAME
		do
			across
				<<1, 2, 3, 4>> as test_index
			loop
				create game.run (True, "test" + test_index.item.out + ".txt")
			end
			print ("%N%N---TESTS WERE SUCESSFUL!---%N")
		end

end
