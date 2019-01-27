note
	description: "Summary description for {DATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DATE

create
	make

feature
	date: INTEGER
	events: LINKED_LIST[ENTRY]

	make(d: INTEGER)
	-- construntor
	do
		date := d
		create events.make
	end

	append_event(ev: ENTRY)
	-- adds event into the list of events
	do
		events.extend(ev)
	end

	get_events: LINKED_LIST[ENTRY]
	-- get the list of events
	do
		Result := events
	end

	to_string: STRING
	-- returns readable form of the day
	do
		 Result := date.out+"%N"
		 across events as el loop
		 	Result := Result + el.item.to_string + "%N"
		end
	end

end
