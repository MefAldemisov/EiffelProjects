note
	description: "Summary description for {COFFE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COFFE

inherit

	PRODUCT
		undefine
			default_create
		redefine
			description
		end

	ANY
		undefine
			default_create
		end

create
	default_create

feature

	default_create
	do
		set_price (10.5)
		set_price_public (50.5)
	end

	description: STRING
			-- describes the produnct
		do
			Result := "Coffe"
		end

end
