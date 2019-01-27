note
	description: "One arbitrary piece in the board."
	author: "MefAldemisiv"
	date: "11.11.2018"
	revision: "$Revision$"

deferred class
	PIECE

feature -- parameters

	colour: STRING
			-- contains tha colour of the piece

	position: COORDINATES
			-- contains the position of the given figure in the board

	type: STRING
			-- type of the given figure

	char: CHARACTER
			-- character, denotinf that figure in the board

	moved: BOOLEAN
			-- true, if the figure was moved during the game

feature -- creation

	make (c: STRING; p: COORDINATES)
			-- default creation procedure
		require
			position_is_valid: p.are_valid
			colour_is_valid: c.is_equal ("black") or c.is_equal ("white")
		do
			colour := c
			position := p
			moved := False
		ensure
			moved = False
			colour_properly_set: colour = c
			position_properly_set: position = p
		end

feature -- movement

	can_move (new_position: COORDINATES): BOOLEAN
			-- checks if the figure can move to the given bosition by the rules of its own behaviour
		require
			new_position.are_valid
		deferred
		end

	move (new_position: COORDINATES)
			-- moves figure to the given position
		require
			can_move (new_position)
		do
			moved := True
			position := new_position
		ensure
			moved = True
			position = new_position
		end

feature{NONE}
	-- technical

	get_x_dfference(c: COORDINATES): INTEGER
	do
		Result := c.x - position.x
	end


	get_y_dfference(c: COORDINATES): INTEGER
	do
		Result := c.y - position.y
	end

	sign: INTEGER
		-- returs the sign of the figure's movement direction
	do
		Result := 1
		if colour.is_equal ("black") then
			Result := -1
		end
	end

invariant
	position_is_valid: position.are_valid
	colour_is_valid: colour.is_equal ("black") or colour.is_equal ("white")

end
