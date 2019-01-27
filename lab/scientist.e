note
	description: "Summary description for {SCIENTIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCIENTIST

feature -- required features

	has_pet: BOOLEAN
		-- if the sientist has a pet

	short_biography: STRING
		-- returns he biography of the person

	id: INTEGER
		-- individual number of a scientist

	name: STRING
		-- scientist's name

	discipline: STRING
		-- “Computer scientist”, “Biologist” or “Bio-informatician”

	introduce: STRING
		--	 used to introduce each scientist: his/her name and id
	do
		Result := "Name: " + name
		Result := Result + "%Nid: " + id.out
	end

feature -- creation procedure

	make(cs_name, biography: STRING; cs_id: INTEGER; pet: BOOLEAN)
	do
		name:=cs_name
		short_biography := biography
		id := cs_id
		has_pet := pet
	end

invariant
--	<<"Computer scientist", "Biologist", "Bio-informatician">>.has(discipline)

end
