note
	description: "Summary description for {BIOLOGIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BIOLOGIST

inherit

	SCIENTIST
	rename
		make as make_bio,
		introduce as introduce_bio
	redefine
		make_bio, introduce_bio
	end



create
	make_bio

feature -- redefined creation

	make_bio (cs_name, biography: STRING; cs_id: INTEGER; pet: BOOLEAN)
			-- default creation
		do
			Precursor(cs_name, biography, cs_id, True)
			discipline := "Biologist"
			pet_name := " hidden "
		end

	set_pets_name(n: STRING)
			-- sets the name of the pet, if biologist wants
		do
			pet_name := n
		end

feature -- special for biologist

	introduce_bio: STRING
			--	 used to introduce each scientist: his/her name and id
	do
		Result := Precursor
		Result := Result + "%NPet's name: " + pet_name
	end

feature {NONE}

	pet_name: STRING
			-- name of the pet

invariant
	has_pet = True

end
