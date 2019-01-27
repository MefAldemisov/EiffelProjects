note
	description: "Summary description for {IN_JAIL_SQUARES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IN_JAIL_SQUARES

inherit

	SQUARE
		redefine
			land
		end

feature

	describe
			-- describes the cell's performance to a player
		do
			print ("In jail: ")
		end

feature

	tax: INTEGER = 50

	land (p: PLAYER)
			-- preforms check on staying in jail
		local
			dice: DICE
		do
			if p.in_jail then
				create dice.make
				if request_the_decision or  (p.days_in_jail = 3) then
					print("%NYou ought to pay tax!")
					p.pay (tax)
					p.stay_in_jail (False)
				elseif dice.throw = dice.throw then
					p.stay_in_jail (False)
					p.move_on (2)
				else
					p.stay_in_jail (True)
				end
			end
		end

feature {NONE}

	request_the_decision: BOOLEAN
			-- returns if person would like to by the cell
		do
			print ("%NWould you like to pay for exit?%N(Y/N)")
			io.read_line
			Result := io.last_string.twin.is_equal ("Y")
		end

end
