note
	description: "Summary description for {PRODUCT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PRODUCT

inherit
	ANY
		undefine
			default_create
		end


feature{NONE}

	price_public: REAL
			-- price of the product for customers

	price: REAL
			-- price of the product for the shop

	default_create
	do
		price_public := 10.5
		price := 0.0
	end
feature

	description: STRING
		deferred
		end

	set_price_public (new_public_price: REAL)
			-- change the prices of products
		do
			price_public := new_public_price
		ensure
			price_public = new_public_price
		end

	set_price (new_price: REAL)
			-- change the prices of products
		do
			price := new_price
		ensure
			price = new_price
		end

feature {COFFE_SHOP}

	profit: REAL
			-- gives the profit of selling all the products in the coffee shop
		do
			Result := price_public - price
		ensure
			Result = price_public - price
		end

invariant
	price < price_public

end
