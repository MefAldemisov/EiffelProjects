note
	description: "Summary description for {INCOME_TAX_SQUARES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INCOME_TAX_SQUARES

inherit

	SQUARE
		redefine
			land
		end

feature

	land (p: PLAYER)
			-- rmoves 10% of player's money
		local
			lost: REAL_64
		do
			lost := p.get_money * 0.1
			p.pay (lost.rounded)
		ensure then
			old p.get_money > p.get_money
		end

feature

	describe
			-- describes the cell to a player
		do
			print ("%NIncome tax: you lost 10%% of your money :(")
		end

end
