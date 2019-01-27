note
	description: "Calendar_entry application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization
	calendar: CALENDAR
	person: PERSON
	d1: DATE
	d2: DATE
	t1: TIME
	t2: TIME
	e1: ENTRY
	e2: ENTRY
	e3: ENTRY

	make
			-- Run application.
		do
			create calendar.make
			create person.make("Maxim", 1234567899, "maxpopov2001@mail.ru", "student")
			create t1.set_time(13, 10)
			create t2.set_time(14, 20)
			create e1.make (t1, person, "dogs cleaning", "professora-popova h20")
			create e2.make (t1, person, "chemistry exam", "PTSH")
			create e3.make (t2, person, "lanch", "KFC")
			create d1.make (6)
			create d2.make (8)
			calendar.add_date (d1)
			calendar.add_date (d2)
			calendar.add_entry (e1, d1)
			calendar.add_entry (e2, d1)
			calendar.add_entry (e3, d2)
			print(calendar.printable_month)
			print("%N")
			print(calendar.in_conflict(6).count)
		end

end
