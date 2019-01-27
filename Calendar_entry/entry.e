note
	description: "Summary description for {ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY

create
	make

feature

	date: TIME

	owner: PERSON

	subject: STRING

	place: detachable STRING

	make (dt: TIME; own: PERSON; sbj: STRING; plc: detachable STRING)
	-- constructor
		do
			date := dt
			owner := own
			subject := sbj
			place := plc
		end

	set_subject (new_subject: STRING)
	-- set subject of the event
		do
			subject := new_subject
		end

	set_date (new_date: TIME)
	-- sets time of the event
		do
			date := new_date
		end

	get_owner: PERSON
	-- returns entry's owner
		do
			Result := owner
		end

	get_place: detachable STRING
	-- returns entry's place
		do
			Result := place
		end

	get_date: TIME
	-- returns the time of event
	do
		Result := date
	end

	to_string: STRING
	-- returnss readable entry information
		do
			Result := subject + " " + date.to_string
		end

end
