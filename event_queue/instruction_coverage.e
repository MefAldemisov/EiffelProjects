note
	description: "Summary description for {INSTRUCTION_COVERAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSTRUCTION_COVERAGE
inherit
	COVERAGE
create
	make

feature
	make
	do
		score := 0
	end

	score: INTEGER

	print_score
		do
			print("%N.. " + score.out + "%%")
		end

	run
	local
		q: EVENT_QUEUE
		e: EVENT
	do
		create q.make(100001)
		score := score + 26
		create e.make (0)
		print_score
		q.put (e)
		check
			put_works: q.queue.count = 100002
		end
--		if q.queue.count = 100002 then
			score := score + 12
			print_score
--		end
		if 0 = q.extract.get_time_tag then
			score := score + 18*2
			print_score
		end
		q.put (e)
		q.extract_by_tag_lower (1)
		if q.queue.count = 100001 then
			score := score + 13*2
			print_score
		end
	end

-- Non-contract weue on the class:
--	make 69-19=50- total
--	extract_by_tag_lower (limit: INTEGER)
--		do
--			from
--				i := queue.lower
--			until
--				i > queue.upper
--			loop
--				if queue [i].get_time_tag < limit then
--					remove_item_number (i)
--				end
--				i := i + 1
--			end
--		end
--	put (e: EVENT)
--		do
--			if time_tag_is_appropriate (e.get_time_tag) then
--				queue.force (e, queue.upper + 1)
--			end
--		end
--	extract: EVENT
--		do
--			min_index := queue.lower
--			min_value := queue [min_index].get_time_tag
--			from
--				i := queue.lower + 1
--			until
--				i < queue.upper
--			loop
--				if queue [i].get_time_tag < min_value then
--					min_index := i
--					min_value := queue [min_index].get_time_tag
--				end
--				i := i + 1
--			end
--			Result := queue [min_index]
--			remove_item_number (min_index)
--		end



end
