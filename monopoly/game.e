note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

create
	make

feature {NONE}
	-- parameters

	players: ARRAY [PLAYER]
			-- list of players

	max_rounds: INTEGER = 200
			-- max rounds, game can continue

	dice: DICE
			-- dice to throw

feature
	-- construnctor

	make
			-- creation
		do
			describe_game
			create dice.make
			fill_players_array
		end

feature
	-- game itself

	start
			-- performs the game mechanizm
		local
			rounds: INTEGER
				-- index of rounds, played totally
			player_index: INTEGER
			-- index of the current player
		do
			from
				rounds := 1
				player_index := 1
			until
				(rounds > max_rounds) or players.count = 1
			loop
				print ("%N%N" + players [player_index].name + ", your turn:")
				print("%N(now you have " + players [player_index].money.out + "K)")
				if not players [player_index].in_jail then
					players [player_index].move_on (dice.throw + dice.throw)
				else
					players [player_index].move_on (0)
				end
				if players [player_index].lose then
					drop (player_index)
				end
				player_index := player_index + 1
				if player_index > players.count then
					print("%N%NNew round number " + rounds.out + "%N%N")
					rounds := rounds + 1
					player_index := 1
				end
			end
			get_winners
			print ("%N_________END_________")
		end

feature {NONE}

	get_winners
			-- prints the winners of the game
		local
			max_money: INTEGER
		do
			max_money := players [1].money
			across
				players as player
			loop
				if player.item.money > max_money then
					max_money := player.item.money
				end
			end
			across
				players as player
			loop
				if player.item.money = max_money then
					print ("%NConderatulations!%N" + player.item.name + ", you won!!!")
				end
			end
		end

feature {NONE} -- dropper

	drop (index: INTEGER)
			-- drops the player
		require
			players [index].lose
		local
			i: INTEGER
			new_players_array: ARRAY [PLAYER]
		do
			create new_players_array.make_filled (players [index], 1, players.count - 1)
			from
				i := 1
			until
				i > new_players_array.count
			loop
				if i < index then
					new_players_array [i] := players [i]
				elseif i > index then
					new_players_array [i - 1] := players [i]
				end
				i := i + 1
			end
			players := new_players_array
		ensure
			old players.count = players.count + 1
		end

feature {NONE} -- filler

	fill_players_array
			-- fills the array of players
		local
			player: PLAYER
			index: INTEGER
			board: GAME_BOARD
		do
			create board.fill
			create player.make ("default", board)
			create players.make_filled (player, 1, amount_of_players_request)
			from
				index := 1
			until
				index > players.count
			loop
				create player.make (name_request (index), board)
				players [index] := player
				index := index + 1
			end
		ensure
			not has_player_named ("default")
		end

feature {NONE} -- description

	describe_game
			-- prints the game's rules
		do
			print ("%N__________START___________%N")
			print ("Welcome to maonololy!")
			print ("%NThe game comes with a board divided into 20 squares, a pair of four-sided dice, and can accommodate 2 to 6 players.")
			print ("%NIt works as follows:")
			print ("%N- Players have money and can own properties. Each player starts with Rub 1500K and no properties.")
			print ("%N- All players start from the first square ('Go').")
			print ("%N- One at a time, players take a turn: roll the dice and advance their respective tokens clockwise on the board. After reaching square 20 a token moves to square 1 again.")
			print ("%N- Certain squares take effect on the player, when her/his token passes or lands on the square. In particular it can change the player's amount of money.")
			print ("%N- If after taking a turn a player has a negative amount of money the player retires from the game. All his property becomes unowned.")
			print ("%N- A round consists of all players taking their turns once.")
			print ("%N- The game ends either if there is only one player left or after 100 rounds. The winner is the player with the most money after the end of the game. Ties (multiple winners) arepossible.")
			print ("%N____________________________")
		end

feature {NONE} -- requests

	amount_of_players_request: INTEGER
			-- returns the amount of players
		do
			print ("%NEnter the number of players(from 2 to 6): ")
			io.read_integer
			Result := io.last_integer.twin
			if not (2 <= Result and Result <=6) then
				print("Incorrect number of players")
				Result := amount_of_players_request
			end
		end

	name_request (n: INTEGER): STRING
			-- retrns the name of player umber n
		do
			print ("%NEnter the name of the player number " + n.out + ": ")
			io.read_line
			Result := io.last_string.twin
		end

feature {NONE} -- for conteracts

	has_player_named (name: STRING): BOOLEAN
			-- returns if there is a player with such name in a list
		do
			Result := False
			across
				players as player
			loop
				Result := player.item.name.is_equal (name)
			end
		end

invariant
	1 <= players.count
	players.count <= 6

end
