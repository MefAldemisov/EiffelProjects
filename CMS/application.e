note
	description: "CMS application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	c1: CONTACT
	c2: CONTACT
	c3: CONTACT

	manager: CMS

	make
			-- Run application.
		do
			create manager

			c1 := manager.create_contact("contact1", 1234567891, VOid, VOID, void);
			c2 := manager.create_contact("contact2", 1234567892, VOid, VOID, void);
			c3 := manager.create_contact("contact3", 1234567893, VOid, VOID, void);

			manager.add_emergency_contact(c1, c2)
			manager.add_emergency_contact(c2, c3)

			manager.edit_contact(c2, "email", "fgh@fgh")
			manager.remove_emergency_contact(c2)
			manager.remove_emergency_contact(c3)
			print(c1.call_emergency)
		end

end
