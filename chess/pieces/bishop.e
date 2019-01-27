note
	description: "Summary description for {BISHOP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BISHOP
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
		type := "bishop"
		char := 'B'
	ensure then
		type.is_equal ("bishop")
	end

feature -- provide realization

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		do
			Result := False
			if ((get_y_dfference (new_position) /= get_x_dfference (new_position)) and (get_x_dfference (new_position) = 0 or get_y_dfference (new_position) = 0)) then
				Result := True
			end
		end


end
