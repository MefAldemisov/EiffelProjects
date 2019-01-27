note
	description: "ctypt application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	-- TODO
	-- write make feature for spiral class
	-- remove 'answer' from other classes
	make
		local
			spir: SPIRAL_CIPHER
			arr: ARRAY2[CHARACTER]
			ch1, ch2: CHARACTER
			vir:VIGENERE_CIPHER
			comb: COMBINED_CIPHER

			-- Run application.
		do
			print("%N___START___%N")
			create spir.make
			create vir.pass_key ("BUSY")
			create comb.make
			print(comb.decrypt (comb.encrypt (read_string)))

		end

		read_string: STRING
		do
			io.readline
			Result := io.last_string.twin
		end

		read_arr: ARRAY2[CHARACTER]
		local
			i, j: INTEGER
		do
			create Result.make_filled('0', 4, 4)
			from
				i := 1
			until
				i = 5
			loop
				from
					j := 1
				until
					j = 5
				loop
					io.read_character
					Result.item(i, j) := io.last_character.twin
					j := j + 1
				end
				i := i + 1
			end
			print("CHACK:")
			print_arr(Result)
		end



	print_arr (arr: ARRAY2 [CHARACTER])
		local
			i, j: INTEGER
		do
			from
				i := 1
			until
				i > arr.height
			loop
				from
					j := 1
				until
					j > arr.width
				loop
					print (arr.item (i, j).out + " ")
					j := j + 1
				end
				print ("%N")
				i := 1 + i
			end
		end

end
