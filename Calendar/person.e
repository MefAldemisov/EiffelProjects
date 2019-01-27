note
	description: "Summary description for {PERSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON

create
	make

feature
	name: STRING
	phone_number: INTEGER
	work_place: STRING
	email: STRING

	make(n:STRING)
		do
			name := n
		end

end
