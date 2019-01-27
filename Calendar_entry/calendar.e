note
	description: "Summary description for {CALENDAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR

create make

feature

	days: LINKED_LIST[DATE]
	--linked list of days

	make
	-- constructor
		do
			create days.make
		end

	add_date(d: DATE)
	-- adds a new date to the curicculum
	do
		days.extend (d)
	end

	add_entry(e: ENTRY; d: DATE)
	--adds entry e to the day d
		do
			d.append_event (e)
		end

	edit_subject (e: ENTRY; new_subject: STRING)
	-- a command that replaces e’s subject by new_subject;
		do
			e.set_subject (new_subject)
		end

	edit_date (e: ENTRY; new_date: TIME)
	-- a command that replaces e’s date by new_date;
		do
			e.set_date (new_date)
		end

	get_owner_name (e: ENTRY): STRING
	-- a query that returns the name of e’s owner;
		do
			Result := e.get_owner.get_name
		end


	in_conflict (day: INTEGER): LINKED_LIST [ENTRY]
	-- a query that returns the list of entries that overlap (in time or place). It returns an empty list otherwise;
		local
			j, k: INTEGER
			list : LINKED_LIST[ENTRY]
		do
			create Result.make
			create list.make
			across days as d loop
				if d.item.date = day then
					list := d.item.get_events
				end
			end
			if list.count > 0 then
--				across list as ev loop
					from j := 1
					until j >= list.count
					loop
						from
							k := 1
						until
							k >= list.count
						loop
							if
								list.at(j).get_date.is_equa(list.at(k).get_date)
							then
								Result.extend(list.at(j))
							end
							k := k + 1
						end
						j := j + 1
					end
--				end
			else
				print("Error: That date is out of list!")
			end
		end

	printable_month: STRING
	-- a query that returns a printable version of the month, including the events of each day;
		do
			Result := "To this month:%N"
			across days as d loop
				Result := Result + d.item.to_string + "%N"
			end
		end


--	in_conflict (e1: ENTRY; e2: ENTRY): BOOLEAN
--	-- old version of in_conflict unction from previous task
--		local
--			flag: BOOLEAN
--		do
--			flag := FALSE
--			if attached e1.get_place as place then
--				if attached e2.get_place as place2 then
--			  		flag := place.is_equal (place2)
--			  	end
--			end
--			if flag /= TRUE then
--				Result := e1.date.is_equal (e2.date)
--			else
--				Result := flag
--			end
--		end

end
