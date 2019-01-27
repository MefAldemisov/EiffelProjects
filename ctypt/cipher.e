note
	description: "Summary description for {CIPHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CIPHER

feature -- deferred

	encrypt(s: STRING): STRING
		deferred
		end


	decrypt(s: STRING): STRING
		deferred
		end

end
