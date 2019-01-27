note
	description: "Summary description for {BIOINFORMATIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BIOINFORMATIC

inherit

	BIOLOGIST
		redefine
			make_bio,
			introduce_bio
		select
			make_bio,
			introduce_bio
		end

	COMPUTER_SCIENTIST


create
	make_bio

feature

	make_bio (cs_name, biography: STRING; cs_id: INTEGER; pet: BOOLEAN)
			-- default creation
	do
		Precursor {BIOLOGIST} (cs_name, biography, cs_id, pet)
		discipline := "Bio-informatician"
		bio := "none"
	end

	set_bio(new_bio: STRING)
		-- sets the bio of the bio-informatician
	do
		bio := new_bio
	end

	introduce_bio: STRING
		-- itroduces a scientist
	do
		Result := Precursor {BIOLOGIST}
		Result := Result + "Bio: " + bio
	end

feature {NONE}

	bio: STRING
			-- bio of the scientist

end
