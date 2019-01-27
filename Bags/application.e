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
			create cell1.make ( 'a' , 1)
			create cell2.make ('b', 2)
			create bag1.make (cell1)
			bag1.print_values
			create bag2.make (cell2)
			bag2.print_values
			bag1.add ('b', 2)
			bag2.add ('a', 1)
			bag1.add ('c', 3)
			bag2.add ('c', 2)
			print("%NEQUALS : ")
			print(bag1.is_equal_bag (bag2))
			print("%N")
			print(bag1.min)
			print("%N")
			print(bag2.max)
			print("%N")

		end

end
