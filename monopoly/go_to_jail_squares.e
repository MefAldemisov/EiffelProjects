note
	description: "Summary description for {GO_TO_JAIL_SQUARES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GO_TO_JAIL_SQUARES

inherit

	SQUARE
		redefine
			land
		end

create
	make

feature {NONE}

	jail_index: INTEGER

	make (jail_cell_position: INTEGER)
		do
			jail_index := jail_cell_position
		ensure
			jail_index = jail_cell_position
		end

feature

	land (p: PLAYER)
			-- performs sending to a jail
		do
			p.send_to_a_jail
			p.move_to (jail_index)
		end

feature

	describe
			-- describes cell's performance to a player
		do
			print ("%NGo to jail: you are send to a jail :(")
		end

end
