note
	description: "contains a list of members of the LAB. Also contains features: and introduce all.."
	author: "MefAldemisov"
	date: "12.11.2018"
	revision: "$Revision$"

class
	LAB

create
	make

feature

	list: ARRAYED_LIST[SCIENTIST]

feature

	make
	do
		create list.make (100)
	end

	add_member(s: SCIENTIST)
	do
		list.force(s)
	end

	remove_member(s: SCIENTIST)
	do
		list.search (s)
		list.remove
	end

	introduce_all
	do
		across list as sc loop
			print("%N" + sc.item.name)
		end
	end
end
