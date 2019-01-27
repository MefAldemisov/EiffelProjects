note
	description: "simple_game_eif application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization
	-- Run application.

	field: ARRAY_2D

	fullnes: ARRAY [INTEGER]

	player_index: INTEGER

	width, height: INTEGER

	make
		local
			flag: BOOLEAN
			change_column, change_index: INTEGER
		do
			io.put_string ("%NSTART%N")
			width := 5
			height := 10
			create field.make_filled (width, height, ".")
			create fullnes.make_filled (0, 0, width - 1)
			field.print_2d_array
			player_index := 1
			from
				flag := FALSE
			until
				flag = TRUE
			loop
				print ("Player number " + player_index.out + "%N")
				change_column := request
				change_index := fullnes.at (change_column)
				fullnes [change_column] := fullnes [change_column] + 1
				if player_index > 0 then
					field.set_to (change_column, change_index, "o")
				else
					field.set_to (change_column, change_index, "x")
				end
				flag := check_the_wining (change_column, change_index)
				field.print_2d_array
				player_index := player_index * (-1)
			end
			print ("%N%NPlayer, " + player_index.out + ", " + "you won!")
		end

	diagonal (x0, y0, delta: INTEGER): INTEGER
			-- check amount of the same elements per diagonal
		require
			x_is_in_array: 0 <= x0 and x0 < field.width
			y_is_in_array: 0 <= y0 and y0 < field.height
		local
			i, j: INTEGER
			stopper: BOOLEAN
			char: STRING
		do
			Result := 0
			stopper := FALSE
			char := field [i, j]
			from
				i := x0
				j := y0
			until
				i >= field.width or stopper or i < 0 or j < 0 or j >= field.height
			loop
				if field [i, j].is_equal (char) then
					Result := Result + 1
				else
					stopper := TRUE
				end
				i := i + delta
				j := j + delta
			end
			print (Result.out + "d%N")
		ensure
			right_start_of_cicle: Result >= 1
		end

	in_column (x0, y0, delta: INTEGER): INTEGER
			-- check amount of the same elements per column
		require
			x_is_in_array: 0 <= x0 and x0 < field.width
			y_is_in_array: 0 <= y0 and y0 < field.height
		local
			array: ARRAY [STRING]
			i: INTEGER
			stopper: BOOLEAN
			char: STRING
		do
			Result := 0
			create array.make_empty
			array := field.get_column (x0)
			char := field [x0, y0]
			from
				i := y0
			until
				i >= array.count or stopper or i < 0
			loop
				if array.at (i).is_equal (char) then
					Result := Result + 1
				else
					stopper := TRUE
				end
				i := i + delta
			end
			print (Result.out + "c%N")
		ensure
			right_start_of_cicle: Result >= 1
		end

	in_row (x0, y0, delta: INTEGER): INTEGER
			-- check amount of the same elemrnts per row
		require
			x_is_in_array: 0 <= x0 and x0 < field.width
			y_is_in_array: 0 <= y0 and y0 < field.height
		local
			array: ARRAY [STRING]
			i: INTEGER
			stopper: BOOLEAN
			char: STRING
		do
			Result := 0
			create array.make_empty
			array := field.get_row (y0)
			char := field [x0, y0]
			from
				i := x0
			until
				i >= array.count or stopper or i < 0
			loop
				if array.at (i).is_equal (char) then
					Result := Result + 1
				else
					stopper := TRUE
				end
				i := i + delta
			end
			print (Result.out + "r%N")
		ensure
			right_start_of_cicle: Result >= 1
		end

	check_the_wining (column, index: INTEGER): BOOLEAN
			-- checks if the current player won
		require
			column_is_appropriate: 0 <= column and column < field.width
			row_is_appropriate: 0 <= column and column < field.height
		local
			res_d, res_c, res_r: BOOLEAN
		do
			res_d := (diagonal (column, index, 1) + diagonal (column, index, -1) > 4)
			res_c := (in_column (column, index, 1) + in_column (column, index, -1) > 4)
			res_r := (in_row (column, index, 1) + in_row (column, index, -1) > 4)
			Result := res_d or res_c or res_r
		ensure
			Result = (diagonal (column, index, 1) + diagonal (column, index, -1) > 4) or (in_column (column, index, 1) + in_column (column, index, -1) > 4) or (in_row (column, index, 1) + in_row (column, index, -1) > 4)
		end

	request: INTEGER
			-- takes the next player' step
		do
			io.read_integer
			Result := io.last_integer
		end

invariant
	field.height > 2 or field.height > 2

end
