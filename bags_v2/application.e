note
	description: "Bags application root class"
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
			-- Run application
		local
			bag1, bag2: BAG_CLASS
			cell1, cell2: CELL_INFO
		do
			create cell1.make ('a', 1)
			create cell2.make ('b', 2)
			create bag1.make (cell1)
			create bag2.make (cell2)
			bag1.add ('b', 2)
			bag2.add ('a', 1)
			bag1.add ('c', 3)
			bag2.add ('c', 1)
			bag2.add ('c', 2)
			print ("%NEQUALS: " + bag1.is_equal_bag (bag2).out)
			print ("%N" + bag1.min.out)
			print ("%N" + bag2.max.out)
			print ("%N")
		end

end
