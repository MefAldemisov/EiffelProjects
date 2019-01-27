note
	description: "Summary description for {POWER_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_SET

feature

	is_sorted (arr: ARRAY [INTEGER]): BOOLEAN
			-- checks if aray is sorted
		local
			i: INTEGER
		do
			Result := True
			from
				i := 2
			until
				(i > arr.count) or (Result = False)
			loop
				if arr.at (i) < arr.at (i - 1) then
					Result := False
				end
				i := i + 1
			end
		end


	all_except_one(set: ARRAY[INTEGER]; except: INTEGER): ARRAY[INTEGER]
			-- returns the array without a variable with value "except"
	do
		create Result.make_empty
		across set as element loop
			if
				element.item /= except
			then
				Result.force(element.item, Result.count + 1)
			end
		end
	end

	power_set(set: ARRAY[INTEGER]): ARRAY[ARRAY[INTEGER]]
			--main method
	require
		is_sorted(set)
	local
		i: INTEGER
		multiset: ARRAY[ARRAY[INTEGER]]
	do
		create Result.make_empty
		Result.force (set, 1)
		from
			i := 1
		until
			i > set.count
		loop
			multiset := power_set(all_except_one(set, set.at(i)))
			append_new(Result, multiset)
			i := i + 1
		end
	end

	append_new(place_to_append, appendance: ARRAY[ARRAY[INTEGER]])
	do
		place_to_append.compare_objects
		across appendance as element loop
			if not place_to_append.has(element.item) then
				place_to_append.force(element.item, place_to_append.count + 1)
			end
		end
	end

end
