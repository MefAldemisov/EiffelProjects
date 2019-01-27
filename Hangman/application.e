note
	description: "Hangman application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	comm: COMMUNICATION

	dict: DICTIONARY

	make
			-- Run application.
		do
			create dict.make_filled (<<"integer", "hello", "cat", "word", "innopolis", "eiffel">>)
			create comm.make (dict)
			comm.start
		end

end
