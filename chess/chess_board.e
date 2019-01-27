note
	description: "Class, that implements chess board"
	author: "MefAldemisov"
	date: "$18.11.2018$"
	revision: "$Revision$"

class
	CHESS_BOARD

create
	make

feature {NONE} -- hidden parameters

	chess_board: ARRAY2 [detachable PIECE]
			-- field of the game

	figures: ARRAY [PIECE]
			-- collection of all figures, which are alive

feature -- creation

	make
			-- default constructor
		do
			create chess_board.make_filled (Void, 8, 8)
			create figures.make_empty
			fill_default
			print (has_two_kings)
		end

feature {NONE} -- board filling

	fill_default
			-- fills the board in a default way
		do
			create_team ("white", 1, 2)
			create_team ("black", 8, 7)
		end

	create_team (colour: STRING; edge_row, pawns_row: INTEGER)
			-- creates and puts on the board team of the given colour
		do
			create_pawns (colour, pawns_row)
			create_mirrors (colour, edge_row)
			put_piece ("queen", colour, edge_row, 4)
			put_piece ("king", colour, edge_row, 5)
		end

	create_pawns (colour: STRING; pawns_row: INTEGER)
			-- creates pawns of a given colour
		local
			column: INTEGER
		do
			from
				column := 1
			until
				column > chess_board.width
			loop
				put_piece ("pawn", colour, pawns_row, column)
				column := column + 1
			end
		end

	create_mirrors (colour: STRING; edge_row: INTEGER)
			-- creates knights, rooks and bishops of the given colour
		do
			across
				<<1, -1>> as sign
			loop
				put_piece ("bishop", colour, edge_row, (9 + sign.item * 1) \\ 9)
				put_piece ("knight", colour, edge_row, (9 + sign.item * 2) \\ 9)
				put_piece ("rook", colour, edge_row, (9 + sign.item * 3) \\ 9)
			end
		end

feature {NONE} -- not for creation only (e.g. castling)

	put_piece (type, colour: STRING; row, column: INTEGER)
			-- puts new figure of choosen type on a position [row, column]
		local
			p: PIECE
			c: COORDINATES
		do
			create c.make (row, column)
			if type.is_equal ("king") then
				create {KING} p.make (colour, c)
			elseif type.is_equal ("queen") then
				create {QUEEN} p.make (colour, c)
			elseif type.is_equal ("pawn") then
				create {PAWN} p.make (colour, c)
			elseif type.is_equal ("bishop") then
				create {BISHOP} p.make (colour, c)
			elseif type.is_equal ("rook") then
				create {ROOK} p.make (colour, c)
			elseif type.is_equal ("knight") then
				create {KNIGHT} p.make (colour, c)
			end
			chess_board.put (p, row, column)
			if p /= Void then
				figures.force (p, figures.upper + 1)
			end
		ensure
			chess_board.item (row, column) /= Void
		end

feature -- hidden, but popular

	set (to: COORDINATES; what: detachable PIECE)
			-- sets the given pice to a given coordinates in the board
		require
			to.are_valid
		do
			chess_board.item (to.x, to.y) := what
		ensure
			at (to) = what
		end

	increace (p: COORDINATES; dx, dy: INTEGER): COORDINATES
			-- enreases the given coordinates on the ginven values
		do
			create Result.make (p.x + dx, p.y + dy)
		ensure
			x_is_appropinately_set: Result.x = p.x + dx
			y_is_appropinately_set: Result.y = p.y + dy
		end

feature -- simplify

	at (c: COORDINATES): detachable PIECE
			-- returns the element by the given COORDINATES
		require
			c.are_valid
		do
			Result := chess_board.item (c.x, c.y)
		ensure
			Result = chess_board.item (c.x, c.y)
		end

	is_type (position: COORDINATES; name: STRING): BOOLEAN
			-- checks if the figure has such a type
		require
			position.are_valid
		do
			Result := False
			if attached at (position) as piece then
				if piece.type.is_equal (name) then
					Result := True
				end
			end
		end

feature -- main

	can_move (p1, p2: COORDINATES; user_colour: STRING): BOOLEAN
			-- returns if the figure can move to a given destination
		require
			p1.are_valid
			p2.are_valid
			at (p1) /= Void
		local
			path: ARRAY [COORDINATES]
		do
			Result := False
			if attached at (p1) as piece then
				Result := (p1.x /= p2.x) or (p2.y /= p1.y)
				Result := piece.can_move (p2) and (piece.colour.is_equal (user_colour)) and Result
				if not piece.colour.is_equal (user_colour) then
					print ("%NNot appropriate colour")
				end
				if attached at (p2) as destination then
					Result := Result and (destination.colour /= piece.colour)
				end
				if Result and (not piece.type.is_equal ("knight")) then
					path := get_path_to (piece, p2)
					across
						path as step
					loop
						Result := Result and (at (step.item) = Void)
					end
				end
				if piece.type.is_equal ("pawn") then
					if (at (p2) /= Void) xor (p2.x = p1.x) then
						Result := True and Result
					end
				end
			end
		end

	move_piece (p1, p2: COORDINATES; user_colour: STRING)
			-- move piece to a given position (if it is possible)
		require
			can_move (p1, p2, user_colour)
		do
			if at (p2) /= Void then
				eat (p2)
			end
			if attached at (p1) as figure then
				figure.move (p2)
			end
			set (p2, at (p1))
			set (p1, Void)
		ensure
			at (p1) = Void
			at (p2) /= Void
		end

feature {NONE} -- for contracts

	connected: BOOLEAN
			-- returns if all the coordinates of the figures are the same, a their coordiates in the board
		do
			Result := True
			across
				figures as figure
			loop
				Result := Result and (at (figure.item.position) = figure.item)
			end
		end

feature -- exit condition checker

	has_two_kings: BOOLEAN

			-- returns if both kings are alive
		do
			Result := get_kings.count = 2
		ensure
			Result = (get_kings.count = 2)
		end

feature {NONE} -- path

	get_path_to (p: PIECE; destination: COORDINATES): ARRAY [COORDINATES]
			-- returns the path to the given point
			-- have no cells between point and destination
		require
			destination.are_valid
		local
			dx, dy: INTEGER
		do
			dx := destination.x.three_way_comparison (p.position.x)
			dy := destination.y.three_way_comparison (p.position.y)
			Result := fill_way (p.position, destination, dx, dy)
		end

	fill_way (position, destination: COORDINATES; dx, dy: INTEGER): ARRAY [COORDINATES]
			-- returns the array of positions from position to destination by step = dx, dy
		require
			position.are_valid
			destination.are_valid
		local
			cell: COORDINATES
		do
			create Result.make_filled (position, 1, 1)
			create cell.make (position.x, position.y)
			from
			invariant
				cell.are_valid
			until
				(cell.x = destination.x) and (cell.y = destination.y)
			loop
				cell := increace (cell, dx, dy)
				Result.force (cell, Result.count + 1)
			end
			Result := Result.subarray (2, Result.upper - 1)
		end

feature {NONE} -- eats

	eat (position: COORDINATES)
			-- removes the given figure from the 'figures' array
		require
			position.are_valid
			at (position) /= Void
		local
			eaten: BOOLEAN
			i: INTEGER
		do
			i := 1
			from
			until
				eaten
			loop
				if figures [i] = at (position) then
					eaten := True
				else
					i := i + 1
				end
			end
				-- shifting of the array
			from
			until
				(i + 1) > figures.count
			loop
				figures [i] := figures [i + 1]
				i := 1 + i
			end
			figures.remove_tail (1)
			set (position, Void)
		ensure
			old figures.count - 1 = figures.count
			at (position) = Void
		end

feature -- show

	show
			-- prints the field
		local
			i, j: INTEGER
		do
			print ("%N| | A| B| C| D| E| F| G| H|")
			from
				i := 1
			until
				i > chess_board.height
			loop
				print ("%N|" + i.out + "|")
				from
					j := 1
				until
					j > chess_board.width
				loop
					print (get_chars (chess_board.item (i, j)) + "|")
					j := j + 1
				end
				i := i + 1
			end
			print ("%N")
		end

feature {NONE} -- printing hidden

	get_chars (piece: detachable PIECE): STRING
			-- returns the symbol for plotting
		do
			Result := "  "
			if attached piece as p then
				if p.colour.is_equal ("black") then
					Result := "*"
				else
					Result := " "
				end
				Result := Result + p.char.out
			end
		ensure
			Result.count = 2
		end

feature {NONE} -- contains the array of all kigs

	get_kings: ARRAY [KING]
			-- returns the array of kings
		do
			create Result.make_empty
			across
				figures as piece
			loop
				if piece.item.type.is_equal ("king") then
					if attached {KING} piece.item as king then
						Result.force (king, Result.count + 1)
					end
				end
			end
		end

feature -- returns king of the given colour

	get_king (colour: STRING): KING
			-- returns the king of the appropriate colour
		do
			Result := get_kings [1]
			across
				get_kings as king
			loop
				if king.item.colour.is_equal (colour) then
					Result := king.item
				end
			end
		ensure
			figures.has (Result)
			get_kings.has (Result)
		end

feature {GAME} -- kings checks (Lab 13.b)

	player_has_check (colour: STRING): BOOLEAN
			-- checks if the player has check (works with GAME class)
		do
			Result := is_check (colour, get_king (colour).position)
			if Result then
				get_king (colour).set_checked
			end
		end

	player_has_mate (colour: STRING): BOOLEAN
			-- don't ask me, why it is special feature
		do
			Result := is_check_mate (get_king (colour))
		end

feature {NONE} --hidden part of checking check

	is_check (king_colour: STRING; king_place: COORDINATES): BOOLEAN
			-- if the king is check
			-- he is under the attack of some firures of the opposite team
			-- can take not only the king as an argument, but any position in te board
		require
			king_place.are_valid
		local
			i: INTEGER
		do
			Result := False
			from
				i := figures.lower
			until
				(i > figures.upper) or Result
			loop
				Result := can_be_attaced_by (king_colour, king_place, figures [i])
				i := i + 1
			end
		end

	can_be_attaced_by (king_colour: STRING; king_place: COORDINATES; piece: PIECE): BOOLEAN
			-- 'i' - index of the attacer
		do
			if not piece.colour.is_equal (king_colour) then
				if can_move (piece.position, king_place, piece.colour) then
					Result := True
					print ("Attacker: " + piece.type)
				end
			end
		end

	is_check_mate (k: KING): BOOLEAN
			-- if the king is check mate
			-- (king has no movement to run out of the check)
		require
			is_check (k.colour, k.position)
		do
			Result := True
			across
				king_possible_positions (k) as pos
			loop
				if not is_check (k.colour, pos.item) then
					Result := False
				end
			end
		end

feature {NONE} -- kings checks addition

	king_possible_positions (k: KING): ARRAY [COORDINATES]
			-- returns the possible next positions of the king
		local
			possible_movements: ARRAY [INTEGER]
			new_position: COORDINATES
		do
			create Result.make_empty
			possible_movements := <<1, 0, -1>>
			across
				possible_movements as i
			loop
				across
					possible_movements as j
				loop
					new_position := increace (k.position, i.item, j.item)
					if new_position.are_valid and then can_move (k.position, new_position, k.colour) then
						Result.force (new_position, Result.count + 1)
					end
				end
			end
		ensure
			Result.count <= 9
		end

feature -- pawns end

	end_pawn (pawn: PIECE; change_pawn_on: STRING)
			-- turning pawn onto the desired piece
		require
			pawn_is_at_the_enge_of_the_board: pawn.position.x \\ 7 = 1
		do
			eat (pawn.position)
			put_piece (change_pawn_on, pawn.colour, pawn.position.x, pawn.position.y)
		ensure
			at (old pawn.position) /= Void
			is_type (old pawn.position, change_pawn_on)
		end

feature -- castling

	preform_castling_if_it_is_valid (bishops_coordinates: COORDINATES)
			-- perfrms castling by a given root
		require
			bishops_coordinates.are_valid
			is_type (bishops_coordinates, "bishop")
		local
			king_coordinates: COORDINATES
		do
			create king_coordinates.make (bishops_coordinates.x, 5)
			if attached {BISHOP} at (bishops_coordinates) as b then
				if attached {KING} at (king_coordinates) as k then
					if (not (k.moved or b.moved)) and (not k.was_checked) then
						select_castling_position (k, b, bishops_coordinates)
					end
				end
			end
		end

feature {NONE} -- castling hidden

	select_castling_position (k: KING; b: BISHOP; b_old: COORDINATES)
			-- selects the coordinates of king and bishop after the given castling
		require
			b_old.are_valid
		do
			if b_old.y = 1 then
				select_parameters_for_castling (k, b, 3, 4, b_old.x)
			else
				select_parameters_for_castling (k, b, 7, 6, b_old.x)
			end
		end

	select_parameters_for_castling (k: KING; b: BISHOP; ky_new, by_new, bx_old: INTEGER)
			-- converts digits to coordiates and calls castling
		local
			b_new, k_new: COORDINATES
		do
			create b_new.make (bx_old, by_new)
			create k_new.make (bx_old, ky_new)
			if castling_is_posible (k, b, k_new, b_new) then
				castling_reverse (k, b, k_new, b_new)
			end
		end

feature {NONE} -- revesing

	castling_is_posible (k: KING; b: BISHOP; k_new, b_new: COORDINATES): BOOLEAN
			-- checks if the castling is posible
			-- requirements can be checked earlier
		require
			k_new.are_valid
			b_new.are_valid
			not (k.moved or b.moved)
			not k.was_checked
		do
			Result := can_move (b.position, b_new, b.colour)
			Result := Result and then not is_check (k.colour, b_new)
			Result := Result and then not is_check (k.colour, k_new)
		ensure
			Result implies can_move (b.position, b_new, b.colour)
			Result implies not is_check (k.colour, b_new)
			Result implies not is_check (k.colour, k_new)
		end

	castling_reverse (k: KING; b: BISHOP; k_new, b_new: COORDINATES)
			-- performs castling
		require
			castling_is_posible (k, b, k_new, b_new)
		local
			init: COORDINATES -- default coordinates of the king
		do
			init := k.position
			move_piece (init, b_new, k.colour)
			eat (b.position)
			move_piece (k.position, k_new, k.colour)
			put_piece ("bishop", b.colour, init.x, init.y)
				-- the rook is moved and king is moved
			move_piece (init, b_new, k.colour)
		ensure
			k.moved
			at (k_new) /= Void
			at (b_new) /= Void
			is_type (k_new, "king")
			is_type (b_new, "bishop")
		end

invariant
	board_has_valid_sides: (chess_board.width = 8) and (chess_board.height = 8)
	coordinates_of_figures_are_equal_to_their_boards_coordinates: connected

end
