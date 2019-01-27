note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make

feature -- paameters

	name: STRING
			-- name of the player

feature {GAME}

	position: INTEGER
			-- position of the player onto the board

	lose: BOOLEAN
			-- if the player should be retired

	money: INTEGER
			-- money the person have


feature {GAME, IN_JAIL_SQUARES}

	in_jail: BOOLEAN
			-- if player is in jail

feature {NONE}

	board: GAME_BOARD
			-- game board, player is at

	default_sum: INTEGER = 1500
			-- default sum, player has

	properties: ARRAY [PROPERTY_SQUARES]
			-- property of the player

feature {IN_JAIL_SQUARES}

	days_in_jail: INTEGER
			-- days, player spendin jail

	stay_in_jail (stay: BOOLEAN)
			-- change the state of the player, if required
		require
			in_jail
		do
			if stay then
				days_in_jail := days_in_jail + 1
			else
				days_in_jail := 0
				in_jail := False
			end
		ensure
			in_jail implies stay
		end

feature

	make (player_name: STRING; new_board: GAME_BOARD)
			-- player creation proedure
		do
			name := player_name
			money := default_sum
			position := 1
			create properties.make_empty
			lose := False
			in_jail := False
			days_in_jail := 0
			board := new_board
		ensure
			name = player_name
			money = default_sum
			position = 1
			in_jail or lose = False
			days_in_jail = 0
			board.size = new_board.size
		end

feature {GO_TO_JAIL_SQUARES, GAME, IN_JAIL_SQUARES} -- movements

	move_on (steps: INTEGER)
			-- moves the person to a 'steps' steps futher
		local
			steps_done: INTEGER
		do
			from
				steps_done := 1
			until
				steps_done > steps
			loop
				position := position \\ board.size + 1
				board.at (position).go_through (Current)
				steps_done := steps_done + 1
			end
			print("%NYour position is " + position.out)
			board.at (position).describe
			board.at (position).land (Current)
		end

	move_to (new_position: INTEGER)
			-- moves person to a new position throught the map
		require
			0 <= new_position
		do
			position := new_position
		ensure
			position = new_position
		end

feature {INCOME_TAX_SQUARES}

	get_money: INTEGER
			-- returns maount, that player has
		do
			Result := money
		ensure
			Result = money
		end

feature {GO_TO_JAIL_SQUARES}

	send_to_a_jail
			-- sends player to a jail?
		do
			in_jail := True
		end

feature {SQUARE}

	add_property (new_property: PROPERTY_SQUARES)
			-- adds new property to a person
		require
			not new_property.is_owned
		do
			properties.force (new_property, properties.count + 1)
		ensure
			properties.has (new_property)
		end

	pay (sum: INTEGER)
			-- decrease money, player has, on 'sum' value
		require
			sum > 0
		do
			change_money (- sum)
				-- probably it is not the best solution
			if money < 0 then
				lose := True
					-- remove all property
				across
					properties as property
				loop
					property.item.remove_owner
				end
				print ("%N" + name + ", you lose :(")
			end
		ensure
			old money = money + sum
		end

	earn (sum: INTEGER)
			-- increase money, player has, on 'sum' value
		require
			sum >= 0
		do
			change_money (sum)
		ensure
			old money + sum = money
		end

feature {NONE}

	change_money (on: INTEGER)
			-- changes the mony on a given value
		do
			money := money + on
		ensure
			money = old money + on
		end

invariant
	lose implies money > 0
	days_in_jail < 4

end
