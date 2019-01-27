note
	description: "Summary description for {CONTACT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT

feature

	name: detachable STRING -- the name of the contact;

	phone_number: INTEGER -- a 10 digit number. The phone number of the contact;

	work_place: detachable STRING -- the work place of the contact;

	email: detachable STRING --the email of the contact;

	call_emergency: detachable CONTACT -- the contact person to call in case of an emergency.

	set_name (name_s:detachable STRING)
		do
			name := name_s
		end

	set_phone_number (number: INTEGER)
		do
			phone_number := number
		end

	set_work_place (place: detachable STRING)
		do
			work_place := place
		end

	set_email (mail: detachable STRING)
		do
			email := mail
		end

	set_call_emergency (call: detachable CONTACT )
		do
			call_emergency := call
		end

end
