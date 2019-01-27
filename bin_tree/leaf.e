note
	description: "Summary description for {LEAF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAF [G]

create
	make

feature

	key: G
			-- value of character

	value: INTEGER
			-- frequency of character

	left_child: detachable LEAF [G]
			-- left(smaller one) bracnch

	right_child: detachable LEAF [G]
			-- right(greater) branch

	has_children: BOOLEAN
			-- true i left and right children exist

	make (k: G; v: INTEGER)
			-- constructor, k- characher, v-frequency
		require
			frequency_of_key_exist: v > 0
		do
			key := k
			value := v
			left_child := Void
			right_child := Void
			has_children := False
		end

	set_children (l, r: LEAF [G])
			-- sette for branches
		require
			l.value <= r.value
		do
			left_child := l
			right_child := r
			has_children := True
		ensure
			left_child = l
			right_child = r
			has_children = True
		end

invariant
	has_children = not (left_child = Void and right_child = Void)

end
