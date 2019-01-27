note
	description: "Summary description for {COURSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COURSE

create
	create_class

feature

	name: STRING

	identifier: STRING

	schedule: STRING

	max_students: INTEGER

	min_students: INTEGER

	create_class (name_s: STRING; idenifier_s: STRING)
		do
			name := name_s
			identifier := idenifier_s
			schedule := "Wednesdays all day"
			max_students := 160
			min_students := 3
			print ("Works")
		end

	to_string: STRING
		do
			Result := name + " " + identifier + "%NMax students " + max_students.out
		end

end
