note
	description: "Summary description for {MERGE_SORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MERGE_SORT

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

	merge (arr1, arr2: ARRAY [INTEGER]): ARRAY [INTEGER]
			-- merge two sorted arrays into one sorted array
		require
			arrays_are_sorted: is_sorted (arr1) and is_sorted (arr2)
		local
			i, j, k: INTEGER
		do
			create Result.make_filled (0, 1, arr1.count + arr2.count)
			from
				i := arr1.lower;
				j := arr2.lower;
				k := Result.lower
			until
				k > Result.count
			loop
					-- I don't know how to optimize that piece of code
				if j > arr2.upper then
					Result.at (k) := arr1.at (i)
					i := i + 1
				elseif i > arr1.upper then
					Result.at (k) := arr2.at (j)
					j := j + 1
				elseif arr1.at (i) < arr2.at (j) then
					Result.at (k) := arr1.at (i)
					i := i + 1
				else
					Result.at (k) := arr2.at (j)
					j := j + 1
				end
				k := k + 1
			end
		ensure
			is_sorted (Result)
		end

	sort (arr: ARRAY [INTEGER]): ARRAY [INTEGER]
			-- sorts one int array
		require
			array_is_not_empty: arr.count > 0
		local
			arr1, arr2: ARRAY [INTEGER]
		do
				-- splitting the array
			if arr.count > 1 then
				arr1 := arr.subarray (arr.lower, arr.lower + arr.count // 2 - 1)
				arr2 := arr.subarray (arr.lower + arr.count // 2, arr.upper)
				arr1 := sort (arr1);
				arr2 := sort (arr2)
					-- merging the arrays
				Result := merge (arr1, arr2)
			else
				Result := arr
			end
		ensure
			is_sorted (Result)
		end

end
