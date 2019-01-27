note
	description: "bin_tree application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE}

	encoding: HASH_TABLE [STRING, CHARACTER]
			-- hash-table: character -> haffman code

	leafs: ARRAY [LEAF [CHARACTER]]
			-- tree of characters

	make
		local
			frequency: HASH_TABLE [INTEGER, CHARACTER]
				-- hash-table: chracter -> frequency
			input, output: STRING
			-- input of the user
		do
				-- HAFFMAN ALGORITHM
			print ("%N__START__%NEnter the string:")
			io.read_line
			input := io.last_string
			frequency := find_frequency (input)
			leafs := fill_leafs (frequency)
			sort_leafs
			haffman_builder
			create encoding.make (frequency.count)
			deep_search ("", leafs [leafs.lower])
			print ("%NCode:%N" + code (input))
			print ("%NEncodig-coding result:%N")
			output := decode (code (input))
			print (output.is_equal (input))
		end

feature {NONE} -- decoding and coding itself

	code (s: STRING): STRING
			-- codes string with Haffman algorithm
		require
			not s.is_empty
			s_contains_only_sumbols_from_encoding: has_only (s, encoding.current_keys)
		do
			Result := ""
			across
				s as ch
			loop
				if attached encoding [ch.item] as add then
					Result := Result + add
				end
			end
		end

	decode (s: STRING): STRING
			-- decodes given string using haffman tree
		require
			containd_only_1_and_0: has_only (s, <<'0', '1'>>)
		local
			i: INTEGER
			leaf: detachable LEAF [CHARACTER]
		do
			Result := ""
			from
				i := 1
			until
				i > s.count
			loop
				leaf := leafs [leafs.upper]
					-- searches for the next edge of the tree
				from
				until
					leaf /= Void and then not leaf.has_children
				loop
					if leaf /= Void then
						if s.at (i) = '0' then
							leaf := leaf.left_child
						else
							leaf := leaf.right_child
						end
						i := i + 1
					end
				end
					-- changes the result
				if attached leaf as l then
					Result := Result + l.key.out
				end
			end
		end

feature {NONE} -- haffman backward algorithm

		-- 'generates encoding hash-table := char- haffman code'
		-- 'initial string is empty and forvards from the root to the leafs'
		-- 'recursively if not char go left, then go right'

	deep_search (s: STRING; leaf: detachable LEAF [CHARACTER])
		do
			if attached leaf as l and then l.has_children then
					-- go left
				deep_search (s + "0", l.left_child)
					-- go right
				deep_search (s + "1", l.right_child)
			elseif attached leaf as l then
				encoding.put (s, l.key)
			end
		end

feature {NONE} -- haffman forward alogorithm

	haffman_builder
			-- builds tree for haffman code
		local
			leaf: LEAF [CHARACTER]
		do
				-- 'uniter two the smallest branches in the "leafs" into one leaf'
				-- 'searches for an appropriate place of the leaf in the tree and puts in there'

			from
			until
				leafs.count < 2
			loop
				create leaf.make (' ', leafs [leafs.lower].value + leafs [leafs.lower + 1].value)
				leaf.set_children (leafs [leafs.lower], leafs [leafs.lower + 1])
				put_leaf (leaf)
				leafs := leafs.subarray (leafs.lower + 2, leafs.upper)
			end
		end

	put_leaf (leaf: LEAF [CHARACTER])
			-- finds and shifts place for a new leaf and put it onto the array
		local
			i: INTEGER
		do
				-- 'find appropriate index for the leaf'
				-- 'shift elements of the array to the right to make free space for new item'
			i := leafs.lower
			from
				i := leafs.lower
			until
				i > leafs.upper or else leafs [i].value > leaf.value
			loop
				i := i + 1
			end
				-- put new item
			shift_right_from (i)
			leafs.force (leaf, i)
		ensure
			is_sorted
		end

	shift_right_from (start: INTEGER)
			-- shift all values of the array to the right by one
		local
			i: INTEGER
		do
			from
				i := leafs.upper
			until
				i < start
			loop
				leafs.force (leafs [i], i + 1)
				i := i - 1
			end
		ensure
			leafs.valid_index (start) implies old leafs.upper = leafs.upper - 1
		end

	sort_leafs
			-- sorts leafs in array by their values
		require
			leafs_are_not_empty: not leafs.is_empty
		local
			i, j, min_value, min_index: INTEGER
			changer: LEAF [CHARACTER]
		do
			from
				i := leafs.lower
			until
				i > leafs.upper
			loop
				min_value := leafs [i].value
				min_index := i
					-- find local minimum
				from
					j := i + 1
				until
					j > leafs.upper
				loop
					if leafs [j].value < min_value then
						min_value := leafs [j].value
						min_index := j
					end
					j := j + 1
				end
					-- put local minimum to its place
				changer := leafs [i]
				leafs [i] := leafs [min_index]
				leafs [min_index] := changer
				i := i + 1
			end
		ensure
			is_sorted
		end

	fill_leafs (freq: HASH_TABLE [INTEGER, CHARACTER]): ARRAY [LEAF [CHARACTER]]
			-- returns the array of leafs in a current frequency
		require
			frequency_contais_elements: not freq.is_empty
		local
			leaf: LEAF [CHARACTER]
			i, val: INTEGER
			keys: ARRAY [CHARACTER]
		do
			keys := freq.current_keys
			create leaf.make (keys [1], 1)
			create Result.make_filled (leaf, 1, freq.count)
			from
				i := 1
			until
				i > Result.count
			loop
				val := freq [keys [i]]
				create leaf.make (keys [i], val)
				Result [i] := leaf
				i := i + 1
			end
		ensure
			leangth_are_the_same: Result.count = freq.count
		end

	find_frequency (s: STRING): HASH_TABLE [INTEGER, CHARACTER]
			-- returns hash-table char-> frequency
		require
			string_is_not_empty: not s.is_empty
		do
			create Result.make (s.count)
			across
				s as ch
			loop
				if not Result.has (ch.item) then
					Result.put (1, ch.item)
				else
					Result.force (Result [ch.item] + 1, ch.item)
				end
			end
		ensure
			sum_of_values (Result) = s.count
		end

feature {NONE} -- for contracts

	has_only (s: STRING; chars: ARRAY [CHARACTER]): BOOLEAN
			-- checks if the given string conains only the given range of chars
		do
			Result := True
			across
				s as ch
			loop
				if not chars.has (ch.item) then
					Result := False
				end
			end
		end

	is_sorted: BOOLEAN
			-- chaecks if the leafs are sorted
		local
			i: INTEGER
		do
			Result := True
			from
				i := leafs.lower + 1
			until
				(i > leafs.upper) or not Result
			loop
				if leafs [i - 1].value > leafs [i].value then
					Result := False
				end
				i := i + 1
			end
		end

	sum_of_values (hash_table: HASH_TABLE [INTEGER, CHARACTER]): INTEGER
			-- returns sum of values in the hash-table
		local
			keys: ARRAY [CHARACTER]
			i: INTEGER
		do
			keys := hash_table.current_keys
			from
				i := 1
			until
				i > keys.count
			loop
				Result := Result + hash_table [keys [i]]
				i := i + 1
			end
		end

end
