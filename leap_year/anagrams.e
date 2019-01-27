note
	description: "Summary description for {ANAGRAMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ANAGRAMS

feature

	anagrams (word: STRING): ARRAY [STRING]
			-- returns anagrams of a given string
		local
			sub_anagrams: ARRAY [STRING]
			char: CHARACTER
			i: INTEGER
		do
			create Result.make_empty
			if word.count > 1 then
				char := word.at (word.count)
				sub_anagrams := anagrams (word.substring (1, word.count - 1))
				across
					sub_anagrams as string
				loop
					Result.force (char.out + string.item, Result.count + 1)
					from
						i := 1
					until
						i > string.item.count
					loop

						Result.force (insert_char (string.item, char, i), Result.count + 1)
						i := i + 1
					end

				end
			else
				Result.force (word, 1)
			end
			Result.compare_objects
		ensure
			Result.count = factorial (word.count)
				-- some -> [for el in result(next) put letter in all places]
				-- som -> [som smo mos osm oms mos]
				-- so -> [so + os]
				-- s -> [s]
		end

feature {NONE}

	factorial (n: INTEGER): INTEGER
			-- returns the factorial of the given
		local
			i: INTEGER
		do
			Result := 1
			from
				i := 1
			until
				i > n
			loop
				Result := Result * i
				i := i + 1
			end
		end

	insert_char (string: STRING; char: CHARACTER; at: INTEGER): STRING
			-- inserts char to the given position
		do
			Result := string.substring (1, at) + char.out + string.substring (at + 1, string.count)
		end

end
