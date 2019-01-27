note
	description: "Summary description for {PRIMARY_EQUIPMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRIMARY_EQUIPMENT
inherit
	EQUIPMENT
	redefine
		make
	end

feature

	make(will_be_primary: BOOLEAN)
		-- creation procedure
	do
		is_primary := will_be_primary
	ensure
		is_primary = will_be_primary
	end
end
