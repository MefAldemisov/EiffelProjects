note
	description: "Summary description for {CAPUCHINO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CAPUCHINO

inherit

	COFFE
		redefine
			description
		end

feature

	description: STRING
			-- describes the product
		do
			Result := Precursor + ", capuchino"
		end

end
