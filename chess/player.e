note
	description: "Player of the chess game"
	author: "MefAldemisov"
	date: "$11.11.2018$"
	revision: "$Revision$"

class
	PLAYER

create
	make

feature

	name: STRING
			-- name of the player

	colour: STRING
			-- colour of the person's pieces

feature -- create

	make (player_name: STRING; player_colour: STRING)
			-- default creation procedure
		require
			player_colour.is_equal ("white") or player_colour.is_equal ("black")
		do
			name := player_name
			colour := player_colour
		ensure
			name_is_prpperly_set: name = player_name
			colour_is_prpperly_set: colour = player_colour
		end

end
