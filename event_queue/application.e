note
	description: "event_queue application root class"
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
			instructions: INSTRUCTION_COVERAGE
			-- Run application.
		do
			create instructions.make
			instructions.run
		end

end
