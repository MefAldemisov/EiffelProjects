note
	description: "Stack application root class"
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
			-- Run application.
		local
			stack: MY_BOUNDED_STACK [INTEGER]
		do
			print ("%N__START__%N")
			create stack.make (1)
			stack.push (4)
			stack.push (7)
			stack.push (3)
			print (stack.item)
			print (stack.item)
			stack.remove
			stack.remove
			print (stack.is_empty)
			stack.remove
			stack.remove
			across
				<<1, 2, 3, 4, 5, 6, 7, 8, 9, 10>> as digit
			loop
				stack.push (digit.item)
			end
			print (stack.has_space)
				--			stack.push (0)
			print (stack.item)
			print ("%N__FINISH__%N")
		end

end
