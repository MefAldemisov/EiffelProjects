note
	description: "Summary description for {BAG_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAG_CLASS

create
	make

feature

	elements: ARRAY[CELL_INFO]
	values: ARRAY[CHARACTER]

	make(first_cell: CELL_INFO)
			-- constructor
	require
		first_character_exist: first_cell.number_copies > 0
	do
		create elements.make_filled (first_cell, 0, 0)
		create values.make_filled(first_cell.value, 0, 0)
	ensure
		new_element_is_added: elements[0].value = first_cell.value and values.has(first_cell.value)
	end

	add (val: CHARACTER; n: INTEGER)
			-- adds n copies of value val to the bag
	require
		value_exist: n > 0
	local
		new_value: CELL_INFO
	do
		if values.has (val) then
			new_value := find_value(val)
			new_value.add_copy
		else
			create new_value.make(val, n)
			elements.conservative_resize_with_default (new_value, 0, elements.count)
--			elements[elements.count - 1] := new_value
			values.conservative_resize_with_default (new_value.value, 0, values.count)
--			values[values.count - 1] := new_value.value
		end
	end

	find_value(val: CHARACTER): CELL_INFO
			-- searches the cell_info with value val
		require
			val_is_in_elements: values.has (val)
		do
			create Result.make (val, 1)
			across
				elements as element
			loop
				if
					element.item.value.is_equal(val)
				then
					Result := element.item
				end
			end
		ensure
			find_required: Result.get_value.is_equal(val)
		end


	remove (val: CHARACTER; n: INTEGER)
			-- that removes as many copies of val as possible, up to n.
	require
		val_is_in_elements: values.has (val)
	local
		cell: CELL_INFO
	do
		cell := find_value (val)
		cell.reduce_number (n)
	end

	min: CHARACTER
			-- returns the minimum element
		require
			values_exist: values.count > 0
		do
			Result := values [0]
			across values as val
			loop
				if val.item < Result
				then
					Result := val.item
				end
			end
		ensure
			Result <= values [0]
		end

	max: CHARACTER
			-- returns the minimum element
		require
			values_exist: values.count > 0
		do
			Result := values [0]
			across values as val
			loop
				if val.item > Result
				then
					Result := val.item
				end
			end
		ensure
			Result >= values [0]
		end

	print_values
	do
		print("%N")
		across values as v
		loop
			print(v.item.out + " ")
		end
		print("%N")
	end


	is_equal_bag (b: BAG_CLASS): BOOLEAN
			--returns TRUE if b is equal to the Current bag
	require
		second_is_not_empty: not b.elements.is_empty
	local
		self_cell, other_cell: CELL_INFO
		b_index: INTEGER
	do
		-- size checking
		if
			values.count = b.values.count
		then
			Result := True
		else
			Result := False
		end
		-- elements checking
		print("Current result "+ Result.out+ "%N")
		print_values
		print("%N")
		b.print_values
		from
			b_index := 0
			other_cell := b.elements.at (b_index)
		until
			(not Result) or b_index = b.elements.count - 1
		loop
			if
				values.has (other_cell.value)
			then
				print("in if%N")
				self_cell := find_value (other_cell.value)
				if
					self_cell.get_value /= other_cell.get_value
				then
					Result := False
				else
					print("Are equal: " + other_cell.get_value.out + " " + self_cell.get_value.out)
				end
			else
				Result := False
			end
			b_index := b_index + 1
			other_cell := b.elements.at (b_index)
--		variant
--			b.elements.count - b_index
		end
	ensure
		belive_me: True
	end
end
