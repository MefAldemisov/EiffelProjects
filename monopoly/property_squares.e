note
	description: "Summary description for {PROPERTY_SQUARES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_SQUARES

inherit

	SQUARE
		redefine
			land
		end

create
	make

feature {NONE}

	position: INTEGER
			-- position of the cell in the board

	name: STRING
			-- name of the cell in the board

	price: INTEGER
			-- price o the object

	rent: INTEGER
			-- rent of the object

	owner: detachable PLAYER
			-- owner of the property

feature

	is_owned: BOOLEAN
			-- if the property is owned by some player

	make (new_position, new_price, new_rent: INTEGER; cell_name: STRING)
			-- creates a property-cell
		do
			position := new_position
			price := new_price
			rent := new_rent
			name := cell_name
			is_owned := False
		ensure
			position = new_position
			price = new_price
			rent = new_rent
			name = cell_name
			is_owned = False
		end

	land (p: PLAYER)
			-- performs the step of the player
		do
			if (not is_owned) and request_the_decision then
				buy (p)
			elseif is_owned then
				pay_rent (p)
			end
		end

feature {NONE}

	request_the_decision: BOOLEAN
			-- returns if person would like to by the cell
		do
			print ("%NWould you like to by it?%N(Y/N)")
			io.read_line
			Result := io.last_string.is_equal ("Y")
		end

	buy (p: PLAYER)
			-- p pays price
		do
			p.add_property (Current)
			is_owned := True
			owner := p
			p.pay (price)
		end

	pay_rent (p: PLAYER)
			-- p pays rent to an owner
		do
			p.pay (rent)
			if attached owner as own then
				own.earn (rent)
			end
		end

feature {PLAYER}

	remove_owner
			-- removes the owner of the property
		do
			owner := Void
			is_owned := False
		ensure
			not is_owned
			owner = Void
		end

feature

	describe
			-- describes the content ofthe cell for player
		do
			print ("%NProperty: " + name + "%Nit's price: " + price.out + "%Nit's rent: " + rent.out)
			if is_owned then
				if attached owner as own then
					print ("%NIt's owner is: " + own.name)
				else
					print ("%NNobody owns it: ")
				end
			end
		end

end
