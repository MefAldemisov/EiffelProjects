note
	description: "Summary description for {COMBINED_CIPHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMBINED_CIPHER

inherit

	CIPHER
		redefine
			encrypt,
			decrypt
		end

create
	make

feature {NONE} -- parameters

	list: ARRAY [CIPHER]

	answer: STRING

feature

	make
		do
			create list.make_empty
			create answer.make_empty
		end

	add_cipher (c: CIPHER)
			-- adds new cipher to the list
		do
			list.force (c, list.count + 1)
		end

	encrypt (s: STRING): STRING
			-- encrypts the given message with all ciphers in the list
		require else
			not s.is_empty
		do
			Result := s
			across
				list as cr
			loop
				Result := cr.item.encrypt (Result)
			end
		ensure then
			Result.count = s.count
		end

	decrypt (s: STRING): STRING
			-- decrypts the given message with all ciphers in the list
		require else
			not s.is_empty
		local
			i: INTEGER
		do
			Result := s
			from
				i := list.count
			until
				i < 1
			loop
				Result := list [i].decrypt (Result)
				i := i - 1
			end
		ensure then
			Result.count = s.count
		end

end
