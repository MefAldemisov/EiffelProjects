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
	email: STRING
	work_place: STRING

	make(name_s: STRING; number:INTEGER; mail: STRING; work: STRING)
	-- constructor
		do
			name := name_s
			phone_number := number
			email := mail
			work_place := work
		end

	get_name: STRING
	-- returns human's name
		do
			Result := name
		end

end
