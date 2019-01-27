note
	description: "Summary description for {COMMUNICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMUNICATION

create
	make

feature
	-- main

	n_players, n_guesses, n_guessed_letters: INTEGER

	word, answer: STRING

	players: ARRAY [PERSONS]

	make (dict: DICTIONARY)
			--initializing of the game
		do
			print ("%N------Start------")
			print ("%NRULES:The system thinks of the word and you task is to find out what was that word.%NIn each guess you can check only one letter. If you succed- you can continue, else- the next player makes a guess.")
			print ("%NEnter the number of players: ")
			io.read_integer
			n_players := io.last_integer.twin
			print ("%NWho will play?%N")
			players_filler (n_players)
			print ("%NEnter the maximum number of gueses: ")
			io.read_integer
			n_guesses := io.last_integer.twin
			word := dict.get_word (n_players, n_guesses)
			create answer.make_filled ('_', word.count)
			if n_guesses < word.count then
				print ("%NIt's imposible to win!!!%N")
			end
		end

	players_filler (n: INTEGER)
			-- fills the array of players
		local
			player: PERSONS
			i: INTEGER
		do
			create player.make_empty
			create players.make_filled (player, 1, n)
			from
				i := 1
			until
				i > n
			loop
				create player.make
				players [i] := player
				i := i + 1
			end
		end

	start
			-- start of the game
		local
			i, steps: INTEGER
			old_val: STRING
		do
			old_val := " "
			from
				steps := 1
			until
				not answer.has ('_') or steps >= n_guesses
			loop
				i := 1
				from
					i := 1
				until
					i > n_players or steps >= n_guesses or not answer.has ('_')
				loop
					print (answer.has ('_'))
					print ("%NGuess " + i.out + " from " + n_guesses.out)
					old_val.copy (answer)
					guess (i)
					if answer.is_equal (old_val) then
						i := i + 1
						steps := steps + 1
					end
				end
				if not answer.has ('_') then
					print ("%NCongratulations, " + players [i].name + ", you have won!!!")
				end
			end
		end

feature
	-- main part of the game

	guess (index_of_player: INTEGER)
			-- request for next step
		local
			letter: CHARACTER
			index: INTEGER
		do
			print ("%N" + players [index_of_player].name + ", enter the letter: ")
			io.read_character
			letter := io.last_character.twin
			print ("Enter its position: ")
			io.read_integer
			index := io.last_integer.twin
			check_guess (index, letter)
		end

	check_guess (index: INTEGER; letter: CHARACTER)
			-- changes the answer, if the step was correct
		require
			index_in_valid_range: word.valid_index (index)
			letter_is_lowercase: letter.is_lower
		do
			if word.at (index).is_equal (letter) then
				print ("%NYou were right:")
				n_guessed_letters := n_guessed_letters + 1
				answer.at (index) := letter
			else
				print ("%NYou were wrong:")
			end
			print (answer + "%N")
		ensure
			answer_changes_no_more_then_on_lone_letter: ans_changes (old answer, answer)
			all_letters_in_answer_are_equal_to_letters_of_word: no_diff_letters
		end

feature
	-- support routines

	ans_changes (old_word, new_word: STRING): BOOLEAN
			-- checks if there are more than two different letters between two words
		local
			number_of_changes, itterator: INTEGER
		do
			from
				itterator := 1
			until
				itterator > old_word.count
			loop
				if old_word.at (itterator) /= new_word.at (itterator) then
					number_of_changes := number_of_changes + 1
				end
				itterator := itterator + 1
			end
			Result := number_of_changes < 1
		end

	no_diff_letters: BOOLEAN
			-- chaecks if all letters in answer are equal to the letters in word
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > answer.count or not Result
			loop
				if answer.at (i) /= word.at (i) and answer.at (i) /= '_' then
					Result := False
				end
				i := i + 1
			end
		end

invariant
	answer_and_word_have_the_same_length: word.count = answer.count
	amount_of_staps_is_appropriate: n_guesses >= word.count

end
