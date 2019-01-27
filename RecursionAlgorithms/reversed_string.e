note
	description: "Summary description for {REVERSED_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REVERSED_STRING

feature

	reverse_iter (s: STRING): STRING
			-- iterative string inverting
		require
			string_is_not_empty: s.count /= 0
		local
			i: INTEGER
		do
			Result := ""
			from
				i := s.count
			until
				i = 0
			loop
				Result := Result + s.at (i).out
				i := i - 1
			end
		ensure
			works_as_embeded: Result.is_equal (embeded_reverse (s))
		end

	embeded_reverse (s: STRING): STRING
			-- embeded string inverting
		do
			s.mirror
			Result := s
		end

	reverse_rec (s: STRING): STRING
			-- recursive string inverting
		require
			string_is_not_empty: s.count /= 0
		do
			if s.count = 1 then
				Result := s
			else
				Result := s.at (s.count).out + reverse_rec (s.substring (1, s.count - 1))
			end
		ensure
			works_as_embeded: Result.is_equal (embeded_reverse (s))
		end

end
