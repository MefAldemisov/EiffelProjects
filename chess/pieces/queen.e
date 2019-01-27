note
	description: "Summary description for {QUEEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QUEEN

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
		type := "queen"
		char := 'Q'
	ensure then
		type.is_equal ("queen")
	end

feature -- provide realization

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		local
			rooks, bishops: BOOLEAN
		do
			Result := False
			rooks := get_x_dfference (new_position).abs = get_y_dfference (new_position).abs
			bishops := ((get_x_dfference (new_position) /= get_y_dfference (new_position)) and (get_y_dfference (new_position) = 0 or get_x_dfference (new_position) = 0))
			if rooks or bishops then
				Result := True
			end
		end

end
