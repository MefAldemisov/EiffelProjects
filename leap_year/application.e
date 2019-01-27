note
	description: "leap_year application root class"
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
			-- Run application.

		do
			test_leap_year
			test_anagrams
		end

feature{NONE}
	test_leap_year
		-- tests 'leap_year' function
	local
		le: LEAP_YEAR
	do
		create le
		print("%NStart leap_year's test:")
		check le.is_leap (1600) end
		print("%N1 passed")
		check not le.is_leap (300) end
		print("%N2 passed")
		check not le.is_leap (2) end
		print("%N3 passed")
		check le.is_leap (32) end
		print("%N4 passed")
		print("%NTest compleded!%N")
	end

feature{NONE}

	test_anagrams
		-- testes 'anagrams' function
	local
		an: ANAGRAMS
	do
		create an
		print("%NStart leap_year's test:")
		check compare_arrays(an.anagrams ("a"), <<"a">>) end
		print("%N1 passed")
		check compare_arrays(an.anagrams ("ab"), <<"ba", "ab">>) end
		print("%N2 passed")
		check compare_arrays (an.anagrams ("abc"), <<"cba", "bca", "bac", "cab", "acb", "abc">>) end
		print("%N3 passed")
		print("%NTest compleded!%N")
	end

feature{NONE}

	print_array(a: ARRAY[STRING])
	do
		across a as e loop
			print(e.item + " ")
		end
		print("%N")
	end

	compare_arrays(arr1, arr2: ARRAY[STRING]): BOOLEAN
	do
		arr1.compare_objects
		arr2.compare_objects
		Result := arr1.is_equal (arr2)
	end



end
