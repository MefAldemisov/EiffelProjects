note
	description: "loop_painting application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	number_of_numbers_in_the_line: INTEGER
			-- nunber of numbers in the first half of the current line

	j: INTEGER
			-- itterator of loop of numbers in the line

	num: INTEGER
			-- number from input

	lines: INTEGER
			-- index of the current line

	amount_of_symbols: INTEGER
			-- total amount of symbols in the width of the figure

	iterator: INTEGER
			-- printed number

	half_of_line: STRING
			-- part of line, that includes numbers

	indent: STRING
			-- space symbol/ spaces between the hapfs of the line

	make
		do
			io.read_integer
			num := io.last_integer
			number_of_numbers_in_the_line := 1 -- start position
			amount_of_symbols := num * 3 + 5 --it is approximation for 2 digit numbers
				-- to be more precise, we should know the length of all numbers at the last string
			half_of_line := " " --only for initialization
			indent := " "
			iterator := 1
				-- loop through all lines
			from
				lines := 1
			until
				lines > num
			loop
					-- making of the first part of the line
				half_of_line := ""
				indent := " "
				from
					j := 1
				until
					j > number_of_numbers_in_the_line
				loop
					half_of_line := half_of_line + iterator.out + " "
					iterator := iterator + 1
					j := j + 1
				end
				print (half_of_line)
					-- printing of the indentation between columns
				indent.multiply (amount_of_symbols - half_of_line.count * 2) -- usually probems are here (to reduce them, change the approximation line)
				print (indent)
					-- making of the second part of the line
				half_of_line := ""
					-- iterator was increased by 1 at the last circle of the loop
				iterator := iterator - 1
				from
					j := 1
				until
					j > number_of_numbers_in_the_line
				loop
					half_of_line := half_of_line + iterator.out + " "
					iterator := iterator - 1 --go backward
					j := j + 1
				end
					-- prepare iterator for the next line
				iterator := iterator + number_of_numbers_in_the_line + 1
				print (half_of_line)
				print ("%N")
				if lines \\ 2 = 0 then
					number_of_numbers_in_the_line := number_of_numbers_in_the_line + 1
				else
					print (" ")
				end
				lines := lines + 1
			end
		end

end
