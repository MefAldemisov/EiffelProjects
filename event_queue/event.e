note
	description: "Summary description for {EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT

create
	make

feature {NONE}

	time_tag: INTEGER
			-- time tag of the event

feature

	make (time: INTEGER)
			-- create and set time_tag
		do
			time_tag := time
		ensure
			time_tag = time
		end

	get_time_tag: INTEGER
			-- returns the time tag of th event
		do
			Result := time_tag
		ensure
			Result = time_tag
		end

end
