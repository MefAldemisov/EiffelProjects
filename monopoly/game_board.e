note
	description: "Summary description for {GAME_BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_BOARD

create
	fill

feature {NONE}

	board: ARRAY [SQUARE]
			-- board itself

	fill
			-- fills the board with its cells
		local
			free: FREE_PARCING_SQUARES
		do
			property_names := <<"Christ the Redeemer", "Luang Pho To", "Alyosha monument", "Tokyo Wan Kannon", "Luangpho Yai", "The Motherland", "Awaji Kannon", "Rodina-Mat' Zovyot!", "Great Buddha of Thailand", "Laykyun Setkyar", "Spring Temple Buddha", "Statue of Unity">>
			property_price := <<60, 60, 80, 100, 120, 160, 220, 260, 280, 320, 360, 400>>
			property_rent := <<2, 4, 4, 6, 8, 12, 18, 22, 22, 28, 35, 50>>
			create free
			create board.make_filled (free, 1, 20)
			cicle
		end

feature

	at (i: INTEGER): SQUARE
			-- returns the cell in thet index
		do
			Result := board [i]
		ensure
			Result = board [i]
		end

	size: INTEGER
			-- returns the size of the board
		do
			Result := board.count
		ensure
			Result = board.upper
		end

feature {NONE}

	property_names: ARRAY [STRING]
			-- array of property's names

	property_price: ARRAY [INTEGER]
			-- array of property's proices

	property_rent: ARRAY [INTEGER]
			-- array of property's rents

feature {NONE}

	cicle
			-- moves throught the array and fills it
		require
			(property_names.count = property_price.count) and (property_rent.count = property_price.count)
		local
			index, i: INTEGER
			cell: SQUARE
		do
			from
				index := 1 -- index in the board
				i := 1 -- index in of properties
			until
				index > board.count
			loop
				inspect index
				when 1 then
					create {GO_SQUARES} cell
				when 4 then
					create {INCOME_TAX_SQUARES} cell
				when 6 then
					create {IN_JAIL_SQUARES} cell
				when 9, 13, 19 then
					create {CHANCE_SQUARES} cell
				when 11 then
					create {FREE_PARCING_SQUARES} cell
				when 16 then
					create {GO_TO_JAIL_SQUARES} cell.make (6)
				else
					create {PROPERTY_SQUARES} cell.make (i, property_price [i], property_rent [i], property_names [i])
					i := i + 1
				end
				board[index] := cell
				index := index + 1
			end
		end

end
