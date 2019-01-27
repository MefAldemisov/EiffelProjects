note
	description: "Summary description for {MY_STACK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_STACK [G]

create
	make

feature

	make (first_element: G)
			-- creation of the stack and addition of the first element
		do
			create stack.make_filled (first_element, 1, 1)
		ensure
			element_is_in_the_stack: stack.has (first_element)
			first_element_setted: item = first_element
		end

	push (element: G)
			-- adds an element to the collection
		do
			stack.force (element, stack.count + 1)
		ensure
			size_changed: old stack.upper + 1 = stack.upper
			element_is_in_the_stack: stack.has (element)
			element_is_last: item = element
		end

	remove
			-- not bug, feature: rutines could be only procedures or functions, not all together!
			-- removes the most recently added element
		do
			stack.remove_tail (1)
		ensure
			size_changed: old stack.upper - 1 = stack.upper
		end

	item: G
			-- gives access to the top without modifying the stack
		do
			Result := stack [stack.count]
		ensure
			stack_is_the_same: old stack.is_equal (stack)
			result_is_in_the_stack: stack.has (Result)
			showed_last_element: Result = stack [stack.upper]
		end

	is_empty: BOOLEAN
			-- answers whether the stack has elements or not
		do
			Result := stack.is_empty
		ensure
			Result implies stack.upper = 0
		end

feature {NONE}

	stack: ARRAY [G]
			-- stack itself

end
