note
	description: "Summary description for {CAKE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CAKE

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
		set_price (50.4)
		set_price_public (149.99)
	end

	description: STRING
		-- describes the product
	do
		Result := "Cake"
	end

end
