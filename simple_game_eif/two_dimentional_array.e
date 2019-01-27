note
	description: "Summary description for {TWO_DIMENTIONAL_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWO_DIMENTIONAL_ARRAY
create
	make

feature

	array: ARRAY [STRING]

	width, height: INTEGER

	make (w, h: INTEGER; fill_symbol: STRING)
		do
			create array.make_filled (fill_symbol, 0, w * h - 1)
			width := w
			height := h
		end

	at (x, y: INTEGER): STRING
		do
			Result := array [y * width + x]
		end

	set_to (x, y: INTEGER; value: STRING)

		require
			x_is_appropriate: x > -1 and x < width
			y_is_appropriate: y > -1 and y < height
		do
			array [y * width + x] := value
		ensure
			setted: at(x, y) = value
			dimentions_are_static: old width = width
		end

	get_row (index: INTEGER): ARRAY [STRING]
		require
			too_small_index: index > -1
			too_big_index: index < height
		local
			iterator: INTEGER
		do
			create Result.make_filled (" ", 0, width - 1)
			from
				iterator := 0
			until
				iterator >= width
			loop
				Result [iterator] := array [index * width + iterator]
				iterator := iterator + 1
			end
		end

	get_column (index: INTEGER): ARRAY [STRING]
		require
			too_small_index: index > -1
			too_big_index: index < height
		local
			iterator: INTEGER
		do
			create Result.make_filled (" ", 0, height - 1)
			from
				iterator := 0
			until
				iterator >= height
			loop
				Result [iterator] := array [iterator * width + index]
				iterator := iterator + 1
			end
		end

	print_line (a: ARRAY [STRING])
		do
			across
				a as el
			loop
				print (el.item + " ")
			end
		end

	print_two_dem_array
		local
			iterator: INTEGER
		do
			from
				iterator := 0
			until
				iterator >= height
			loop
				print_line (get_row (iterator))
				print ("%N")
				iterator := iterator + 1
			end
		end

	invariant
	-- static for all feature
		dimentions_are_correct: width > 2 or height > 2

end
