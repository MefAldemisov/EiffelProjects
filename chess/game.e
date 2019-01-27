note
	description: "Chess game itself"
	author: "MefAldemisov"
	date: "20.11.2018"
	revision: "$Revision$"

class
	GAME

create
	run

feature {NONE} -- parameters

	players: ARRAY [PLAYER]
			-- list of chess's players

	board: CHESS_BOARD
			-- chess board to play in

	is_tested: BOOLEAN
			-- if the game is tested

	test_values: detachable ARRAY [STRING]
			-- values to test on

	test_index: detachable INTEGER
			-- index of the itteration across the test data

	test_file_name: STRING
			-- name of the test file

feature -- the only, visible featuer for a client

	run (is_test: BOOLEAN; file_name: STRING)
			-- start of the game
		local
			user: PLAYER
		do
			is_tested := is_test
			test_file_name := file_name
			if not is_test then
				print ("Hi!%NWelcome to chess game!%NEnter the name of the first player (white pieces): ")
				create players.make_filled (create_user ("white"), 1, 2)
				print ("%NEnter the name of the second user: ")
				players [2] := create_user ("black")
			else
				create user.make ("player_1", "white")
				create players.make_filled (user, 1, 2)
				create user.make ("player_2", "black")
				players [2] := user
				test_index := 1
				test_values := get_test_values
			end
			create board.make
			board.show
			cicle
		end

feature {NONE} -- user creator

	create_user (colour: STRING): PLAYER
			-- returns new player
		do
			io.read_line
			create Result.make (io.last_string.twin, colour)
		end

feature {NONE} -- testing

	get_test_values: ARRAY [STRING]
			-- reads the array from file
		local
			file: PLAIN_TEXT_FILE
		do
			create Result.make_empty
			create file.make_open_read (test_file_name)
			from
				file.read_line
			until
				file.exhausted
			loop
				Result.force (file.last_string.twin, Result.count + 1)
				file.read_line
			end
			file.close
		end

	test_index_is_valid: BOOLEAN
			-- checks if the index of the itteration across the test data is valid
		require
			is_tested
		do
			Result := False
			if attached test_index as index then
				if attached test_values as values then
					Result := index <= values.count
				end
			end
		end

feature {NONE} -- loop across players, requesting their next term

	cicle
			-- body of the game
		local
			player_index: INTEGER
		do
			print ("Let's start")
			from
				player_index := 1
			until
				(not board.has_two_kings) or (is_tested and then (not test_index_is_valid))
			loop
				if board.player_has_check (players [player_index].colour) then
					print ("%NCheck!")
					if board.player_has_mate (players [player_index].colour) then
						print ("%NCheck-mate!")
					end
				end
				print (players [player_index].name + ", your turn:%N")
				turn (players [player_index].colour)
				board.show
				player_index := 3 - player_index
			end
			player_index := 3 - player_index
			print ("%NCongratulations!%N" + players [player_index].name + " (" + players [player_index].colour + ")" + ", you win!")
			if is_tested and then (not test_index_is_valid) then
				print ("%NTest was successful!")
			end
				-- edition mode only
				--			io.read_line
				--			if io.last_string.is_equal ("-r") then
				--				restart
				--			end
		end

feature {NONE} -- turn of the player

	turn (colour: STRING)
			-- requests and performs the movement of a piece
		local
			c: detachable COORDINATES
			t: detachable COORDINATES
		do
			print ("Enter the figure's initial position/ 'castling' in case of castling: (e.g A1)%N")
			c := get_coordinates
			print ("Enter the target position/bishop's coordinates in case of castling: (e.g A1)%N")
			t := get_coordinates
			if t /= Void then
				if c /= Void then
					try_moving (c, t, colour)
				else
					try_castling (t, colour)
				end
			end
		end

feature {NONE} -- conditional performance of the different types of pieces

	try_castling (bishop_coord: COORDINATES; colour: STRING)
			-- tryes castling if it is posible
		do
			if not board.get_king (colour).moved then
				board.preform_castling_if_it_is_valid (bishop_coord)
				if not board.get_king (colour).moved then
					print ("%NCastling was not perfrmed")
					rerequest (colour)
				end
			else
				print ("%NKing was already moved!")
				rerequest (colour)
			end
		end

	try_moving (c, t: COORDINATES; colour: STRING)
			-- tryes to move the piece if it is posible
		local
			p: PIECE
		do
			if board.at (c) /= Void or board.at (t) /= Void then
				if board.can_move (c, t, colour) then
					board.move_piece (c, t, colour)
					p := board.at (t)
					try_pawn_end (p)
				else
					rerequest (colour)
				end
			else
				print ("%NThere is no figure there!")
				rerequest (colour)
			end
		end

	try_pawn_end (p: detachable PIECE)
			-- checks if the piece is a pawn and then performs it's en if requires
		do
			if attached p as piece and then piece.type.is_equal ("pawn") then
				if (piece.position.x \\ 7 = 1) then
					board.end_pawn (piece, change_pawn_on)
				end
			end
		end

feature {NONE} -- system support

	rerequest (colour: STRING)
			-- naming is my cup of tea
		do
			print ("%NCoordinates are wrong. Try again%N")
			turn (colour)
		end

	read: STRING
			-- reads the term of the user
		do
			create Result.make_empty
			if is_tested then
				if attached test_values as values then
					if attached test_index as index then
						Result := values [index]
						print (Result + "%N")
						test_index := index + 1
					end
				end
			else
				io.readword
				Result := io.last_string
			end
		end

feature {NONE} -- data reading

	change_pawn_on: STRING
			-- selects the figure, pawn should became
		do
			print ("%NYour pawn ends the board, choose the figure to substitude it:%N1. queen%N2. rook%N3. bishop%N(Enter the appropriate number without the dot)")
			io.read_integer
				-- cruthch (in case user is stupid, it is better)
			inspect io.last_integer.twin
			when 1 then
				Result := "queen"
			when 2 then
				Result := "rook"
			else
				Result := "bishop"
			end
		end

	get_int_from_letter (letter: CHARACTER): INTEGER
			-- returns coordinate in therms of numbers
		do
			Result := letter.code - 64
		ensure
			Result = letter.code - 64
		end

	get_coordinates: detachable COORDINATES
			-- requests the coordinates from the user
			-- or Void if castling
		local
			term, sub_x: STRING
			x, y: INTEGER
		do
			term := read
			if not term.is_equal ("castling") then
				y := get_int_from_letter (term.at (1))
				sub_x := term.substring (term.count, term.count)
				if (y <= 0 or y >= 9) or (not sub_x.is_integer) then
					print ("Format is not correct, retry%N")
					Result := get_coordinates
				else
					x := sub_x.to_integer
					create Result.make (x, y)
					if not Result.are_valid then
						print ("Such cell doesn't exist. Retry:%N")
						Result := get_coordinates
					end
				end
			else
				Result := Void
			end
		end

feature {NONE} -- edition mode only

	restart
			-- restarts all the game
		local
			g: GAME
		do
			create g.run (True, test_file_name)
		end

end
