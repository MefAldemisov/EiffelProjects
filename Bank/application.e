note
	description: "Bank application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			acc: BANK_ACCOUNT
			-- Run application.
		do
				--| Add your code here
			create acc.make ("S-one", 10000000)
			print ("%NOk%N")
			acc.withdraw (800000)
			print (acc.balance)
		end

end
