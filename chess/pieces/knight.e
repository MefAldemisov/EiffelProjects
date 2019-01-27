note
	description: "Summary description for {KNIGHT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KNIGHT

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
		type := "knight"
		char := 'K'
	ensure then
		type.is_equal ("knight")
	end

feature -- provide realization

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		do
			Result := False
			if ((get_x_dfference (new_position).abs = 2 and get_y_dfference (new_position).abs = 1) or (get_y_dfference (new_position).abs = 2 and get_x_dfference (new_position).abs = 1)) then
				Result := True
			end
		end



end
