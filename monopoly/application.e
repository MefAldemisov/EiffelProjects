note
	description: "monopoly application root class"
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
			-- Run application
		local
			game: GAME
		do
			create game.make
			game.start
		end

end
