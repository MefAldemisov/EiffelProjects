note
	description: "Summary description for {EQUIPMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUIPMENT
create
	make
feature{NONE}

	is_primary: BOOLEAN

	rent: INTEGER

	make
	deferred
	end

feature
	set_rent(new_rent: INTEGER)
		-- sets the rent of the equipment
	require
		new_rent > 0
	do
		rent := new_rent
	ensure
		rent = new_rent
	end


end
