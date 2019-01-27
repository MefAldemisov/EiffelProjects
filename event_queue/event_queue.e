note
	description: "Summary description for {EVENT_QUEUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_QUEUE

create
	make

feature

	queue: ARRAY [EVENT]
			-- body of the queue

	min_length: INTEGER
			-- min length of the queue

feature

	make(length: INTEGER)
			-- cretes queue and fills it by 100000 elements
		require
			length >= 100000
		local
			i: INTEGER
			e: EVENT
		do
			min_length := length
			create e.make (1)
			create queue.make_filled (e, 1, length)
			from
				i := queue.lower
			until
				i > queue.upper
			loop
				create e.make (i)
				queue [i] := e
				i := i + 1
			end
		end

feature

	extract_by_tag_lower (limit: INTEGER)
			-- removes the elements, which are less than given tag
		local
			i: INTEGER
		do
			from
				i := queue.lower
			until
				i > queue.upper
			loop
				if queue [i].get_time_tag < limit then
					remove_item_number (i)
					i := i - 1
				end
				i := i + 1
			end
		ensure
			not has_elements_less_than (limit)
		end

	put (e: EVENT)
			-- puts event e into the queue
		do
			if time_tag_is_appropriate (e.get_time_tag) then
				queue.force (e, queue.upper + 1)
			end
		ensure
			time_tag_is_appropriate (e.get_time_tag) implies (old queue.count = queue.count - 1)
			time_tag_is_appropriate (e.get_time_tag) implies queue.has (e)
		end

	extract: EVENT
			-- extracts the element vith the least timt-tag from the queue
		require
			queue.count > min_length
		local
			i, min_value, min_index: INTEGER
		do
			min_index := queue.lower
			min_value := queue [min_index].get_time_tag
			from
				i := queue.lower + 1
			until
				i > queue.upper
			loop
				if queue [i].get_time_tag < min_value then
					min_index := i
					min_value := queue [min_index].get_time_tag
				end
				i := i + 1
			end
			Result := queue [min_index]
			remove_item_number (min_index)
		ensure
			old queue.count > 1 implies (old queue.count - 1 = queue.count)
		end

feature {NONE}

	remove_item_number (index: INTEGER)
			-- removes element number 'index' from the queue
		require
			queue.valid_index (index)
		local
			sub_queue: ARRAY [EVENT]
		do
			if index < queue.upper then
				sub_queue := queue.subarray (index + 1, queue.upper)
			else
				create sub_queue.make_empty
			end

			queue.remove_tail (sub_queue.count + 1)
			across
				sub_queue as element
			loop
				put (element.item)
			end
		ensure
			old queue.count - 1 = queue.count
		end

	time_tag_is_appropriate (t: INTEGER): BOOLEAN
			-- returns if the time_tag is appropriate for addition in the queue
		do
			Result := (not has_time_tag (t)) and (t >= 0)
		ensure
			Result = (not has_time_tag (t)) and (t >= 0)
		end

	has_elements_less_than (limit: INTEGER): BOOLEAN
			-- returns if queue contanis element less than given number
		do
			Result := True
			across
				queue as element
			loop
				Result := element.item.get_time_tag < limit
			end
		end

	has_time_tag (tag: INTEGER): BOOLEAN
			-- returns if the queue contains the event with such a tag
		do
			across
				queue as element
			loop
				Result := element.item.get_time_tag = tag
			end
		end

invariant
	queue.count >= min_length
	not has_elements_less_than (0)

end
