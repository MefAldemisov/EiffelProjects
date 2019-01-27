note
	description: "coffe application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			cap: CAPUCHINO
			esp: ESPRESSO
			cake: CAKE
			coffe_shop: COFFE_SHOP
		do
			create cap
			create esp
			create cake
			cap.set_price_public (150)
			cap.set_price (120)
			esp.set_price_public (150)
			esp.set_price (100)
			cake.set_price_public (350)
			cake.set_price (200)
			create coffe_shop.build
			coffe_shop.add_item (cap)
			coffe_shop.add_item (esp)
			coffe_shop.add_item (cake)
			coffe_shop.print_items
			print ("%NProfit: " + coffe_shop.profit.out)
		end

end
