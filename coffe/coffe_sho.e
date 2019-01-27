note
	description: "Summary description for {COFFE_SHOP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COFFE_SHOP

create
	build

feature

	list: ARRAY[PRODUCT]

	add_item(product: PRODUCT)
		-- adds item to the list
	require
		not list.has(product)
	do
		list.force(product, list.count + 1)
	end

	print_items
		-- prints the list of items i the shop
	do
		across list as item loop
			print("%N" + item.item.description)
		end
	end

	build
		-- buils the coffe shop
	do
		create list.make_empty
	end

	profit: REAL
		-- returns profit of the coffe shop if all items are sold
	do
		Result := 0
		across list as item loop
			Result := Result + item.item.profit
		end
	end


end
