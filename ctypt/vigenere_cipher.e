note
	description: "Summary description for {VIGENERE_CIPHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VIGENERE_CIPHER

inherit

	CIPHER
		redefine
			encrypt,
			decrypt
		end

create
	pass_key

feature -- params

	key: STRING
		-- key for crypting
	hash: HASH_TABLE [INTEGER, CHARACTER]
		-- hash-table code-> char
	dehash: HASH_TABLE [CHARACTER, INTEGER]
		-- anti hash

feature -- for clients

	pass_key (k: STRING)
			-- create cipher, that will work with that key
		require
			not k.is_empty
		do
			key := k
			create hash.make (26)
			create dehash.make (52)
			fill_hashes
		ensure
			key.is_equal (k)
		end

	encrypt (s: STRING): STRING
		-- encrypt the provided string
		require else
			not s.is_empty
		do
			Result := crypt (s, 1)
		ensure then
			Result.count = s.count
		end

	decrypt (s: STRING): STRING
		-- decrypt the provided string
	require else
			not s.is_empty
		do
			Result := crypt (s, -1)
		ensure then
			Result.count = s.count
		end

feature {NONE}

	crypt (s: STRING; sign: INTEGER): STRING
		local
			i, j: INTEGER
		do
			create Result.make_empty
			from
				i := 1
				j := 0
			until
				i > s.count
			loop
				if s.at (i).is_upper then
					Result := Result + dehash [(hash [s.at (i)] + sign * (hash [key.at (j \\ key.count + 1)])) \\ 26 ].out
					j := j + 1
				else
					Result := Result + s.at (i).out
				end
				i := i + 1
			end
		ensure
			Result.count = s.count
		end

	fill_hashes
		local
			i: INTEGER
		do
			from
				i := 65
			until
				i > 90
			loop
				hash.put (i - 65, i.to_character_8)
				dehash.put (i.to_character_8, i - 65)
				dehash.put (i.to_character_8, (i - 65) - 26)
				i := i + 1
			end
		end
invariant
--	hash.capacity = dehash.capacity
	not key.is_empty
end
