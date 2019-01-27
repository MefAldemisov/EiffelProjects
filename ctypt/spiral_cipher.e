note
	description: "Summary description for {SPIRAL_CIPHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPIRAL_CIPHER

inherit

	CIPHER
		redefine
			encrypt,
			decrypt
		end

	-- TODO
	-- split rotate_without_last_column on rotate and cut the last row

create
	make

feature {NONE} -- parameters

	s: STRING
			-- string to be encrypted/ decrypted

	matrix: ARRAY2 [CHARACTER]
			-- matrix, used in encryption/ decryption process

feature -- for clients

	make
		-- default create procedure
	do
		create s.make_empty
		create matrix.make_filled (' ', 1, 1)
	end

	encrypt (str: STRING): STRING
			-- encrypts the given string with the spiram cipher
		local
			size: INTEGER
			empty_char: CHARACTER
		do
				-- 1. find the size of the matrix
				-- 2. make empty matrix
				-- 3. fill the matrix
				-- 4. read the matrix:

			empty_char := 'n'
			s := str
			size := find_the_closest_square (s.count)
			create matrix.make_filled (empty_char, size, size)
			fill_matrix_by_string
			Result := read_by_spiral (empty_char)
		ensure then
			Result.count = str.count
		end

	decrypt (str: STRING): STRING
			-- 1. find the size of the matrix
			-- 2. make matrix, filled with 'a' - lovercase letter, while others should be uppercase
			-- 3. count amout of spaces at the end of the matrix and put them
			-- 4. fill the matrix
			-- 5. read matrix by line
			-- 6. if size \\ 2 = 0 -> reverse it (at that moment 'matrix' is rotated on 180 deg)
		local
			size: INTEGER
			empty_char: CHARACTER
		do
			empty_char := 'n'
			s := str
			size := find_the_closest_square (s.count)
			create matrix.make_filled (empty_char, size, size)
			add_spaces (size * size - s.count)
			fill_matrix_by_code (empty_char)
			Result := read_by_line
			Result.mirror
		end

feature {NONE} -- encoding

	fill_matrix_by_string
			-- fills the matrix by te given string
		require
			s.count <= matrix.count
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= s.count
			loop
				matrix.item (i // matrix.height + 1, i \\ matrix.width + 1) := s.at (i + 1)
				i := i + 1
			end
		end

	read_by_spiral (empty_char: CHARACTER): STRING
			-- returns the coded string
		do
			Result := read_last_column (empty_char)
			matrix := rotate_without_one_column
			from
			until
				matrix.width = 1
			loop
				Result := Result + read_last_column (empty_char)
				matrix := rotate_without_one_column
			end
			Result := Result + matrix.item (1, 1).out
		end

	read_last_column (empty_char: CHARACTER): STRING
			-- reads last column of the given array
		local
			i: INTEGER
		do
			create Result.make_empty
			from
				i := 1
			until
				i > matrix.height
			loop
				if not matrix.item (i, matrix.width).is_equal (empty_char) then
					Result := Result + matrix.item (i, matrix.width).out
				end
				i := i + 1
			end
		end

	rotate_without_one_column: ARRAY2 [CHARACTER]
			-- returns matrix, rotated on -90 degree without its last column
		do
			matrix := remove_last_column
			Result := rotate
		end

	remove_last_column: ARRAY2 [CHARACTER]
			-- removes last column of the 'matrix'
		local
			i, j: INTEGER
		do
			create Result.make_filled (' ', matrix.height, matrix.width - 1)
			from
				i := 1
			until
				i > Result.height
			loop
				from
					j := 1
				until
					j > Result.width
				loop
					Result.item (i, j) := matrix.item (i, j)
					j := j + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- decoding

	add_spaces (n: INTEGER)
			-- adds n spaces to the last n cells of the array
		local
			i, j: INTEGER
			-- i - row index
			-- j - column index
		do
			from
				i := 1
				j := 1
			until
				(matrix.width * (i - 1)) + j > n
			loop
				matrix.item (matrix.height - i + 1, matrix.width - j + 1) := ' '
				if j < matrix.width then
					j := j + 1
				else
					j := 1
					i := i + 1
				end
			end
		end

	fill_matrix_by_code (empty_char: CHARACTER)
			-- fills marix by the coded string
		require
			matrix.width = matrix.height
		local
			i, j, counter, size, steps: INTEGER
		do
			size := matrix.height
			if size \\ 2 = 1 then
				matrix := rotate
				matrix := rotate
			end
				-- fill the first element
			i := (size + 1) // 2
			j := (size + 1) // 2
			matrix.item (i, j) := s.at (s.count)
			s := s.substring (1, s.count - 1)
			from
				counter := 1
			until
				counter = size
			loop
				move_down (i, j, counter)
				i := i + counter
				move_right (i, j, counter)
				j := j + counter
				matrix := rotate
				matrix := rotate
				i := size + 1 - i
				j := size + 1 - j
				counter := counter + 1
			end
			move_down (i, j, counter - 1)
		ensure
			not matrix.has(empty_char)
		end

	move_down (i, j, counter: INTEGER)
			-- fills 'counter' elements under the element (i, j)
		local
			steps: INTEGER
		do
			from
				steps := 1
			until
				steps > counter
			loop
				if not matrix.item (i + steps, j).is_equal (' ') then
					matrix.item (i + steps, j) := s.at (s.count)
					s := s.substring (1, s.count - 1)
				end
				steps := steps + 1
			end
		end

	move_right (i, j, counter: INTEGER)
			-- fills 'counter' elements righter then element (i, j)
		local
			steps: INTEGER
		do
			from
				steps := 1
			until
				steps > counter
			loop
				if not matrix.item (i, j + steps).is_equal (' ') then
					matrix.item (i, j + steps) := s.at (s.count)
					s := s.substring (1, s.count - 1)
				end
				steps := steps + 1
			end
		end

	read_by_line: STRING
		local
			i, j: INTEGER
		do
			create Result.make_empty
			from
				i := 1
			until
				i > matrix.height
			loop
				from
					j := 1
				until
					j > matrix.width
				loop
					Result := Result + matrix.item (i, j).out
					j := j + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- both algorithms

	find_the_closest_square (n: INTEGER): INTEGER
			-- finds the closest upper number, that has an INT square value
		require
			root_is_real: n >= 0
		do
			Result := 0
			from
				Result := 0
			until
				Result * Result >= n
			loop
				Result := Result + 1
			end
		ensure
			result_is_the_smallest: Result * Result >= n and (Result - 1) * (Result - 1) < n
		end

	rotate: ARRAY2 [CHARACTER]
			-- rotates matrix on -90 deg
		local
			i, j: INTEGER
		do
			create Result.make_filled (' ', matrix.width, matrix.height)
			from
					-- i for columns in matrix
				i := 1
			until
				i > matrix.width
			loop
				from
					j := 1
				until
						-- j for rows in matrix
					j > matrix.height
				loop
					Result.item (Result.height - i + 1, j) := matrix.item (j, i)
					j := j + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- support

	print_arr (arr: ARRAY2 [CHARACTER])
		local
			i, j: INTEGER
		do
			from
				i := 1
			until
				i > arr.height
			loop
				from
					j := 1
				until
					j > arr.width
				loop
					print (arr.item (i, j).out + " ")
					j := j + 1
				end
				print ("%N")
				i := 1 + i
			end
		end

end
