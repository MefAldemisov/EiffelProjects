note
	description: "Summary description for {MY_BOUNDED_STACK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_BOUNDED_STACK [G]

inherit

	MY_STACK [G]
		redefine
			push
		end

create
	make

feature

	push (element: G)
			-- pushs element in the tp of the stack
		do
			Precursor (element)
		ensure then
			has_space
		end

	has_space: BOOLEAN
			-- if the stack has space to add
		do
			Result := stack.upper <= capacity
		ensure
			Result = (capacity >= stack.upper)
		end

feature {NONE}

	capacity: INTEGER = 10
			--  max size of the stack

invariant
	has_space: capacity >= stack.upper

end
