note
	description: "Summary description for {PERSONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSONS

create
	make, make_empty

feature

	name: STRING

	age: INTEGER

	make_empty
			-- creates "default" person with name " "
		do
			name := " "
		end

	make
			-- asks for a name of the person and creates obj
		do
			print ("%NEnter your name: ")
			io.read_line
			name := io.last_string.twin
			print ("%NHey, " + name + "!%N")
		end

	add_age
			-- asks for an age of the person and adds such a feature
		do
			print ("Enter your age: ")
			io.read_integer
			age := io.last_integer.twin
			print ("Hey, " + name + ", " + age.out + " years old!")
		end

invariant
	not name.is_empty

end
