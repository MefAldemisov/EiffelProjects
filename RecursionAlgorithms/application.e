note
	description: "RecursionAlgorithms application root class"
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
			ps: POWER_SET
			rob: ROBOT
			f: ARRAY2[INTEGER]
		do
			print("%N--START---%N")
--			create ps
--			print("Power set result:%N")
--			print_two_dim_arr(ps.power_set (<<1, 2, 3, 4>>))
--			print("Finish%N")

			create f.make_filled (0, 4, 5)
			f.item (4,1) := -1
			create rob.find_path (f)
			print_arr2(rob.start)


		end

	print_arr2(arr: ARRAY2[INTEGER])
	local
		i, j: INTEGER
	do
		print("%NStart printing: %N")
		from
			i := 1
		until
			i > arr.width
		loop
			from
				j := 1
			until
				j > arr.height
			loop
				print(arr.item(j, i).out + " ")
				j := j + 1
			end
			i := i + 1
			print("%N")
		end
	end

	read_arr: ARRAY [INTEGER]
		local
			i, n: INTEGER
		do
			print ("Enter the length of an aray: ")
			io.read_integer
			n := io.last_integer
			print ("Enter one integer per row:%N")
			create Result.make_filled (0, 1, n)
			from
				i := 1
			until
				i > n
			loop
				io.read_integer
				Result.at (i) := io.last_integer
				i := i + 1
			end
			print ("%NYour array: %N")
			print_arr (Result)
		end

	print_two_dim_arr(arr: ARRAY[ARRAY[INTEGER]])
		do
			across
				arr as el
			loop
				print_arr (el.item)
				print("%N")
			end
		end

	print_arr (arr: ARRAY [INTEGER])
		do
			across
				arr as el
			loop
				print (el.item.out + " ")
			end
		end

end
