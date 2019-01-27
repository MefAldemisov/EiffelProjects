note
	description: "Summary description for {ROBOT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROBOT

create
	find_path

feature

	field: ARRAY2 [INTEGER]

	find_path (f: ARRAY2 [INTEGER])
			-- array2 cntain only 0 (robot wasn't here) and -1 (robot cannot go here)
		require
			array_has_not_ones: not f.has (1)
			finish_is_achivable: f.item (f.height, f.width) = 0
		do
			field := f
			field.item (1, 1) := 1
		end

	start: ARRAY2[INTEGER]
	do
		go (1, 1, 1)
		if have_won then
			go_back(field.height, field.width, field.item(field.height, field.width))
		end
		Result := field
	end


	go (y, x, n: INTEGER)
		require
			coordinates_are_appropriate: x <= field.width and y <= field.height
		do
			if not have_won then
				if y + 1 <= field.height and then move (y + 1, x, n) then
					go (y + 1, x, n + 1)
				end
				if not have_won and x + 1 <= field.width and then move (y, x + 1, n) then
					go (y, x + 1, n + 1)
				end
			end
		end

	move (y, x, n: INTEGER): BOOLEAN
		require
			x_is_valid: 0 < x and x <= field.width
			y_is_valid: 0 < y and y <= field.height
		do
			Result := False
			if field.item (y, x) = 0 then
				field.item (y, x) := n
				Result := True
			end
		ensure
			cellis_not_free: field.item (y, x) /= 0
		end

	have_won: BOOLEAN
			-- checks if the robot reached finish
		do
			Result := field.item (field.height, field.width) /= 0
		ensure
			Result = field.item (field.height, field.width) /= 0
		end

	go_back(y, x, n: INTEGER)
			-- returns tto the cell with value n - 1
	require
		x_is_valid: 0 < x and x <= field.width
		y_is_valid: 0 < y and y <= field.height
		n_is_valid: field.item (y, x) = n
	do
		if field.item (y, x) /= 1 then
			if field.item (y - 1, x) = n - 1 then
				field.item (y, x) := 1
				go_back(y - 1, x, n - 1)
			elseif field.item (y, x - 1) = n - 1 then
				field.item (y, x) := 1
				go_back(y, x - 1, n - 1)
			end
		end
	ensure
		field.item (y, x) = 1
	end

	invariant
		start_dont_cahge: field.item (1, 1) = 1
end
