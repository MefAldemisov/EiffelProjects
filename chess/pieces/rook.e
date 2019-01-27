note
	description: "Summary description for {ROOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROOK

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
		type := "rook"
		char := 'R'
	ensure then
		type.is_equal ("rook")
	end

feature -- provide realization

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		do
			Result := False
			if (get_x_dfference (new_position).abs = get_y_dfference (new_position).abs) then
				Result := True
			end
		end

end
