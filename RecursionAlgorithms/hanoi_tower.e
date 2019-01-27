note
	description: "Summary description for {HANOI_TOWER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HANOI_TOWER

feature

	hanoi (n: INTEGER ; source, target, other: CHARACTER)
	-- Transfer n disks from source to target,
	-- using other as intermediate storage.
	require
		non_negative: n >= 0
		different1: source /= target
		different2: target /= other
		different3: source /= other
	do
		if n > 0 then
			hanoi (n - 1, source, other, target)
			move (source, target)
			hanoi (n - 1, other, target, source)
		end
	end

	move (source, target: CHARACTER)
	-- Prescribe move from source to target.
	require
		different: source /= target
	do
		io.put_character (source)
		io.put_string (" to ")
		io.put_character (target)
		io.put_new_line
	end

end
