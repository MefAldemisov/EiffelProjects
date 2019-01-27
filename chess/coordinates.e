note
	description: "Coordinates in the cess board."
	author: "MefAldemisov"
	date: "$15.11.2018$"
	revision: "$Revision$"

class
	COORDINATES

create
	make

feature -- parameters

	x, y: INTEGER
			-- coordinates theirself

feature -- constructor

	make (x_new, y_new: INTEGER)
			-- default constructor
		do
			x := x_new
			y := y_new
		ensure
			x_is_appropriately_set: x = x_new
			y_is_appropriately_set: y = y_new
		end

feature -- procedire

	are_valid: BOOLEAN
			-- returns if the coordinate are alid for chess gam
		do
			Result := is_valid (x) and is_valid (y)
		ensure
			Result = is_valid (x) and is_valid (y)
		end

feature {NONE} -- hidden content

	is_valid (i: INTEGER): BOOLEAN
			-- returns if one coordinate is valid
		do
			Result := (0 < i) and (i <= 8)
		ensure
			Result = ((0 < i) and (i <= 8))
		end

end
