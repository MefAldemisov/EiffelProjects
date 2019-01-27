note
	description: "Summary description for {PAWN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAWN

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
			Precursor (c, p)
			type := "pawn"
			char := 'p'
		ensure then
			type.is_equal ("pawn")
		end

feature -- provide realization

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		local
			default_row: INTEGER
		do
			Result := False
			if (get_x_dfference (new_position) = 1 * sign) and (get_y_dfference (new_position).abs <= 1) then
				Result := True
			end
				-- check_the_first_step
			inspect colour.at (1)
			when 'w' then
				default_row := 2
			else
				default_row := 7
			end
			if
				(position.x = default_row) and ((get_y_dfference (new_position) = 0) and (get_x_dfference (new_position) = 2 * sign))
			then
				Result := True
			end
		end

end
