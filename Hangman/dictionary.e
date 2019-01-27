note
	description: "Summary description for {DICTIONARY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DICTIONARY

create
	make_filled, make

feature
	-- creations

	dictionary: ARRAY [STRING]

	make_filled (arr: ARRAY [STRING])
			-- create a dictionary based on array
		require
			contains_words: not arr.is_empty
		do
			dictionary := arr
			dictionary.compare_objects
		end

	make
			-- create empty dictionary
		do
			create dictionary.make_empty
			dictionary.compare_objects
		end

feature

	append_word (new_word: STRING)
			-- adds new word to the dictionary
		require
			dictionary_have_no_shuch_word: not dictionary.has (new_word)
		do
			dictionary.force (new_word, dictionary.count + 1)
		ensure
			word_added: dictionary.has (new_word)
		end

feature

	generate_end_index: INTEGER
			-- generates new index of array
		local
			t: TIME
		do
			create t.make_now
			Result := t.second \\ dictionary.count + 1
			print (Result)
		end

	get_word (min_length, max_length: INTEGER): STRING
			-- returns new word
		local
			i, lim: INTEGER
		do
			Result := " "
			lim := generate_end_index
			from
				i := 1
			until
				i > lim
			loop
				if min_length <= dictionary [i].count and dictionary [i].count <= max_length then
					Result := dictionary [i]
				end
				i := i + 1
			end
			if Result.count = 0 then
				print ("%NNo appropriate value in a dictionary%N")
			end
		end

	get_dictionary: ARRAY [STRING]
			-- returns the dictionary itself
		do
			Result := dictionary
		end

end
