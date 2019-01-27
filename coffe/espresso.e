note
	description: "Summary description for {ESPRESSO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESPRESSO

inherit

	COFFE
		redefine
			description
		end

feature

	description: STRING
			-- describes the product
		do
			Result := Precursor + ", espresso"
		end

end
