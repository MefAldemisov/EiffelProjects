note
	description: "Summary description for {CELL_PROPERTY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SQUARE

feature

	land (p: PLAYER)
			-- does, what the cell requires
		do
		end

	go_through (p: PLAYER)
			-- does, what cell requres in case player only go through
			-- usually nothing
		do
		end

	describe
			-- prints iformation about the cell
		deferred
		end

end
