note
	description: "Summary description for {RANGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANGE

create
	make

feature
	-- baisic

	left, right: INTEGER
			-- boundaties of the range

	make (l, r: INTEGER)
			-- cnstructor
		require
			range_exist: l < r
		do
			left := l
			right := r
		ensure
			boundaries_setted: left = l and right = r
		end

	length: INTEGER
			-- amount of items in the range
		do
			Result := right - left
		end

	to_string: STRING
		do
			Result := "from " + Current.left.out + " to " + Current.right.out
		end

	is_equal_range (other: like Current): BOOLEAN
			-- checks if ranges are eqial
		require
			range_exist: other /= Void
		do
			Result := other.left = Current.left
			Result := Result and other.right = Current.right
			Result := Result or (Current.is_empty and other.is_empty)
		ensure
			Result = ((other.left = Current.left) and (other.length = Current.length) or (Current.is_empty and other.is_empty))
		end

	is_empty: BOOLEAN
			-- checks if the range is not empty
		do
			Result := Current.length = 0
		end

feature
	-- including ranges

	is_super_range_of (other: like Current): BOOLEAN
			-- returns if the Current range includes other range
		require
			other /= Void
		do
			Result := Current.includes (other.right) and Current.includes (other.left) or other.is_empty
		ensure
			Result = Current.includes (other.right) and Current.includes (other.left) or other.is_empty
		end

	is_sub_range_of (other: like Current): BOOLEAN
			-- returns if the other range includes Current
		require
			other /= Void
		do
			Result := other.is_super_range_of (Current)
		ensure
			Result = other.is_super_range_of (Current)
		end

	includes (i: INTEGER): BOOLEAN
			-- if i is in Current range
		do
			Result := Current.left <= i and i <= Current.right
		end

feature
	-- overlaping

	left_overlaps (other: like Current): BOOLEAN
			-- ranges have intersection from the left side of the Current
		require
			other /= Void
		do
			Result := other.includes (Current.left)
		ensure
			Result = (Current.left < other.right and Current.left > other.left)
		end

	right_overlaps (other: like Current): BOOLEAN
			-- ranges have intersection from the right side of the Current
		require
			other /= Void
		do
			Result := other.includes (Current.right)
		ensure
			Result = other.left_overlaps (Current)
		end

	overlaps (other: like Current): BOOLEAN
			-- if the ranges got an intercetion
		require
			other /= Void
		do
			Result := Current.right < other.left
			Result := Result or Current.left < other.right
			Result := Result or other.is_empty
		ensure
			Result = Current.left_overlaps (other) or Current.right_overlaps (other) or other.is_empty
		end

feature
	-- range-returned

	add (other: like Current): RANGE
			-- returns the Range from summation of the ranges
		require
			Current.overlaps (other)
		do
			create Result.make (Current.left.min(other.left), Current.right.max(other.right))
		ensure
			other.is_sub_range_of (Result) and Current.is_sub_range_of (Result)
		end

	subtract (other: like Current): RANGE
			-- returns the range of walues, that are in the both ranges
		require
			Current.overlaps (other)
		do
			create Result.make (Current.left.max(other.left), Current.right.min (other.right))
		ensure
			other.is_super_range_of (Result) and Current.is_super_range_of (Result)
		end

invariant
	left <= right

end
