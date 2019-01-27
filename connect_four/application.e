note
	description: "connect_four application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE}

	field: TWO_DIMENTIONAL_ARRAY

	player_index: INTEGER

		--	fullnes: ARRAY [INTEGER]

	width, height: INTEGER

	flag: BOOLEAN
			--	change_column, change_index, change_linear_index: INTEGER

	make
		do
			io.put_string ("STRRT&%N")
			width := 10
			height := 10
			create field.make (width, height, ".")
				--			create fullnes.make_filled (0, 0, width)
			print ("Now will be print%N")
			field.print_two_dem_array
		end
				--			player_index := 1
				--			from
				--				flag := TRUE
				--			until
				--				flag = FALSE
				--			loop
				--				print ("Player number " + player_index.out + "%N")
				--				change_column := request
				--				change_index := fullnes.at (change_column)
				--				change_linear_index := change_index * width + change_column
				--				if player_index > 0 then
				--					field.put ("o", change_linear_index)
				--				else
				--					field.put ("x", change_linear_index)
				--				end
				--				array_printer (field, width)
				--				flag := check_the_wining(change_column, change_index)
				--				player_index := player_index * (-1)
				--			end
	

		--	request: INTEGER
		--		do
		--			io.read_integer
		--			Result := io.last_integer
		--		end

		--	weights: ARRAY[INTEGER]

		--	start_dot: ARRAY[INTEGER]

		--	symbol: STRING

		--	find_coordinate(x, y:INTEGER):INTEGER
		--		do
		--			Result := x * weights[0] + y * weights[1]
		--		end

		--	check_by_step(x_step, y_step:INTEGER): INTEGER
		--	-- one-derecrional srepper
		--		local
		--			x, y, coordinate: INTEGER
		--			stopor: BOOLEAN
		--		do
		--			-- forward
		--			x := start_dot.at (0)
		--			y := start_dot.at (1)
		--			Result := 0
		--			stopor := TRUE
		--			from
		--				coordinate := find_coordinate(x, y)
		--			until
		--				coordinate >= field.count and Result < 3 and stopor and coordinate > 0
		--			loop
		--				x := x + x_step
		--				y := y + y_step
		--				coordinate := find_coordinate(x, y)
		--				if field[coordinate].is_equal (symbol)
		--					then
		--						Result := Result + 1
		--					else
		--						stopor := FALSE
		--				end
		--			end
		--		end

		--	two_side_checker(x_step, y_step: INTEGER):BOOLEAN
		--		do
		--			Result := (check_by_step(x_step, y_step) + check_by_step(-x_step, -y_step)) > 2
		--		end

		--	check_the_wining(x, y: INTEGER): BOOLEAN
		--		do
		--			create weights.make_filled (1, 0, 1)
		--			weights[0] := width
		--			create start_dot.make_filled(y, 0, 1)
		--			start_dot[0] := x
		--			symbol := field.at (find_coordinate(x, y))
		--			Result := two_side_checker(1, 1) or two_side_checker(0, 1) or two_side_checker(1, 0)
		--		end

end
