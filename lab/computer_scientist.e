note
	description: "Summary description for {COMPUTER_SCIENTIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPUTER_SCIENTIST

inherit

	SCIENTIST
		rename
			make as make_cs,
			introduce as introduce_cs
		redefine
			make_cs
		end

create
	make_cs

feature -- redefined creation

	make_cs (cs_name, biography: STRING; cs_id: INTEGER; pet: BOOLEAN)
			-- default creation
		do
			Precursor (cs_name, biography, cs_id, pet)
			discipline := "Computer scientist"
		end

end
