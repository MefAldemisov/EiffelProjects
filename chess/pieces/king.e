note
	description: "Summary description for {KING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KING
inherit
	PIECE
	redefine
		make
	end

create
	make

feature -- type realization

	make (c: STRING; p: COORDINATES)
		-- type of the given figure
	do
		Precursor(c, p)
		type := "king"
		char := '@'
		was_checked := False
	ensure then
		type.is_equal ("king")
	end

feature -- provide realization

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		do
			Result := False
			if (get_y_dfference (new_position).abs = 1 and get_x_dfference (new_position).abs <= 1) or (get_x_dfference (new_position).abs = 1 and get_y_dfference (new_position).abs <= 1) then
				Result := True
			end
		end

feature --king only

	was_checked: BOOLEAN
		-- if the king was checked during the game

	set_checked
		-- sets king checked
	do
		was_checked := True
	end
end
