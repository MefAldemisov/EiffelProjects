note
	description: "Summary description for {CMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS

feature

	create_contact (name: detachable STRING; phone_number: INTEGER; place: detachable STRING; mail: detachable STRING; call: detachable CONTACT): CONTACT -- which creates a contact (what information should ‘. . .’ be?)
		do
			create Result
			Result.set_name (name)
			Result.set_phone_number (phone_number)
			Result.set_work_place(place)
			Result.set_email(mail)
			Result.set_call_emergency(call)
		end

	edit_contact (c: CONTACT; field_name: STRING; new_value: STRING) -- which edits contact c accordingly (what information should ‘. . .’ be?)
		do
				--inspect field_name
				--	when "name" then
				--		c.set_name(new_value)
				--	when "work_place" then
				--		c.set_work_place(new_value)
				--	when "email" then
				--		c.set_email(new_value)
				--end

			if field_name.is_equal ("name") then
				c.set_name (new_value)
			elseif field_name.is_equal ("work_place") then
				c.set_work_place (new_value)
			elseif field_name.is_equal ("new_vale") then
				c.set_email (new_value)
			elseif field_name.is_equal ("phone") then
				c.set_phone_number (new_value.to_integer)
			end
		end

	add_emergency_contact (c1: CONTACT; c2: detachable CONTACT) -- a command that adds ‘c2’ as emergency contact of ‘c1’;
		do
			c1.set_call_emergency (c2)
		end

	remove_emergency_contact (c: CONTACT) -- a command that removes c’s emergency contact (if any)
		do
			add_emergency_contact(c, Void)
		end

end
