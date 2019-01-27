note
	description: "Summary description for {CELL_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CELL_INFO

create
	make

feature

	value: CHARACTER
			-- value of the cell

	number_copies: INTEGER
			-- number of copies of value

	make (v: CHARACTER; n: INTEGER)
			-- constructor
		require
			n > 0
		do
			value := v
			number_copies := n
		ensure
			value_setted: value /= Void
			number_copies_setted: number_copies /= Void
		end

	add_copy (n: INTEGER)
		require
			it_will_be_addition: n > 0
		do
			number_copies := number_copies + n
		ensure
			changed: number_copies - old number_copies = n
		end

	reduce_number (n: INTEGER)
			-- changes the number_copies
		require
			n <= number_copies
		do
			number_copies := n
		ensure
			difference_is_more_than_null: old number_copies - number_copies >= 0
		end

invariant
	has_enough_copies: number_copies > 0

end
