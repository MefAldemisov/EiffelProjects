note
	description: "Summary description for {GO_SQUARES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GO_SQUARES

inherit

	SQUARE
		redefine
			go_through
		end

feature {NONE}

	earning: INTEGER = 200

feature

	go_through (p: PLAYER)
			-- encrease money, person has
		do
			p.earn (earning)
			print ("%Npass through 'Go' cell: you earned " + earning.out)
		end

feature

	describe
			-- describes the content ofthe cell for player
		do
			print ("%N'Go' cell")
		end

end
