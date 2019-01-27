note
	description: "Summary description for {LEAP_YEAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAP_YEAR

feature

	is_leap(year: INTEGER): BOOLEAN
		-- reurns if the yar is leap
	do
		Result := (year \\ 400 = 0) or ((year \\ 4 = 0) and (year \\ 100 /= 0))
		print((year \\ 400 = 0))
		print((year \\ 4 = 0))
		print((year \\ 100 = 1))
	ensure
		Result = (year \\ 400 = 0) or ((year \\ 4 = 0) and (year \\ 100 /= 0))
	end


end
