note
	description: "Summary description for {LONGEST_COMMON_SUBSEQUENCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LONGEST_COMMON_SUBSEQUENCE

feature

	contain (s, chars: STRING): BOOLEAN
			-- checks if "s" contain all chars from "chars"
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > chars.count or not Result
			loop
				if not s.has (chars.at (i)) then
					Result := False
				end
				i := i + 1
			end
		end

	longest_common_subsequence (s1, s2: STRING): STRING
			-- searches for longest common subsequience
		require
				-- have no idea for requirements
			strings_exist: s1 /= Void and s2 /= Void
		local
			sub1, sub2, lcs1, lcs2: STRING
		do
			Result := ""
			if s1.is_empty or s2.is_empty then
				Result := ""
			elseif s1.at (s1.count).is_equal (s2.at (s2.count)) then
				sub1 := s1.substring (1, s1.count - 1)
				sub2 := s2.substring (1, s2.count - 1)
				Result := longest_common_subsequence (sub1, sub2) + s2.at (s2.count).out
			else
				sub1 := s1.substring (1, s1.count - 1)
				sub2 := s2.substring (1, s2.count - 1)
				lcs1 := longest_common_subsequence (sub1, s2)
				lcs2 := longest_common_subsequence (s1, sub2)
				if lcs1.count > lcs2.count then
					Result := lcs1
				else
					Result := lcs2
				end
			end
		ensure
			each_string_contain_that_chars: contain (s1, Result) and contain (s2, Result)
		end

end
