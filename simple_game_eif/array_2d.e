note
	description: "Summary description for {ARRAY_2D}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_2D

create
	make_filled

feature

	width, height: INTEGER
			-- dimentions of an array

	array: ARRAY [ARRAY [STRING]]
			-- main object

	make_filled (w, h: INTEGER; item_to_fill: STRING)
			-- constructor, that fill array with "item_to_fill"
		require
			width_exist: w > 0
			height_exist: h > 0
		local
			subarray: ARRAY [STRING]
			iterator: INTEGER
		do
			width := w
			height := h
			create subarray.make_filled (" ", 0, width - 1)
			create array.make_filled (subarray, 0, height - 1)
			from
				iterator := 0
			until
				iterator = height
			loop
				create subarray.make_filled (item_to_fill, 0, width - 1)
				array [iterator] := subarray
				iterator := iterator + 1
			end
		ensure
			y_size: array.count = height
			x_size: array [0].count = width
		end

	print_2d_array
			-- prints all the matrix
		local
			outer: STRING
		do
			outer := ""
			across
				array as subarray
			loop
				across
					subarray.item as element
				loop
					outer := outer + element.item + " "
				end
				outer := outer + "%N"
			end
				--			outer.mirror
			print (outer)
		end

feature
	-- row and column getters

	get_row (index: INTEGER): ARRAY [STRING]
			-- returns the row with appropriate index
		require
			index_is_in_valid_range: (index > -1) and (index < height)
		do
			Result := array [index]
		ensure
			Result.count = width
		end

	get_column (index: INTEGER): ARRAY [STRING]
			-- returns the column with appropriate index
		require
			index_is_in_valid_range: (index > -1) and (index < width)
		local
			itterator: INTEGER
		do
			create Result.make_filled (" ", 0, height - 1)
			from
				itterator := 0
			until
				itterator >= height
			loop
				Result [itterator] := array [itterator].at (index)
				itterator := itterator + 1
			end
		ensure
			result_size: Result.count = height
		end

feature
	-- getters and setters

	set_to (x, y: INTEGER; new_value: STRING)
			-- sets new_value to a place with coordinates (x, y)
		require
			validation_of_parameters (x, y)
		do
			array [y].at (x) := new_value
		ensure
			array [y].at (x).is_equal (new_value)
		end

	at alias "[]" (x, y: INTEGER): STRING
			-- returns the value of element with (x, y) coordinates
		require
			validation_of_parameters (x, y)
		do
			Result := array [y].at (x)
		end

feature
	-- requirements

	validation_of_parameters (x, y: INTEGER): BOOLEAN
			-- checks if the coordinates are in range of array
		do
			Result := x > -1 and x < width
			Result := Result and y > -1 and y < height
		end

invariant
	object_created: array /= Void
	has_width: width > 0
	has_height: height > 0

end
