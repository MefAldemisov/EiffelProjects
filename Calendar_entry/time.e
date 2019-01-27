note
	description: "Summary description for {TIME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TIME

create
	set_time

feature

	hour: INTEGER
	minute: INTEGER

	set_time(h: INTEGER; mi: INTEGER)
	-- constructor
		require
			too_small_hours: h >= 0
			too_big_hours: h < 24
			too_small_minutes: mi >= 0
			too_big_minutes: mi < 60
		do
			hour := h
			minute := mi
		end

	is_equa(t: TIME): BOOLEAN
	-- return true, if times are equal and fales-in other case
		do
			Result := (hour = t.hour) and (minute = t.minute)
		end

	to_string: STRING
	-- return time in the readable format
		do
			Result := hour.out + ":" + minute.out
		end

--	compare(t:TIME): INTEGER
--	-- if first one is more => -1
--	-- if equal             => 0
--	-- if first one is less => 1
--		do
--			if year < t.year then
--				Result := 1
--			elseif year = t.year then
--				if month < t.month then
--					Result := 1
--				elseif month = t.month then
--					if day < t.day then
--						Result := 1
--					elseif day = t.day then
--						if hour < t.hour then
--							Result := 1
--						elseif hour = t.hour then
--							if minute < t.minute then
--								Result := 1
--							elseif minute = t.minute then
--								Result := 0
--							else
--								Result := -1
--							end
--						else
--							Result := -1
--						end
--					else
--						Result := -1
--					end
--				else
--					Result := -1
--				end
--			else
--				Result := -1
--			end
--		end
end
