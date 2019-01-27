note
	description: "Linear_algebra application root class"
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
			arr1, arr2: ARRAY2[INTEGER]
			i: INTEGER
			oper: MATRIX_OPER
			-- Run application.
		do
			print("---%N")
			create arr1.make_filled (2, 3, 3)
--			arr1.item(1, 1) := 1
--			arr1.item(1, 2) := 3
--			arr1.item(1, 3) := 3
--			arr1.item(2, 1) := 4
--			arr1.item(2, 2) := 5
--			arr1.item(2, 3) := 6
--			arr1.item(3, 1) := 7
--			arr1.item(3, 2) := 8
--			arr1.item(3, 3) := 9
			create oper
			print("Summ: ")
			print(oper.det(arr1))
		end

feature
	print_array(m: ARRAY2[INTEGER])
	local
		i, j: INTEGER
	do
		from
			i := 1
		until
			i > m.height
		loop
			from
				j := 1
			until
				j > m.width
			loop
				print(m.item(i, j).out + " ")
				j := j + 1
			end
			print("%N")
			i := i + 1
		end
	end

end
