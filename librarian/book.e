note
	description: "Summary description for {BOOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOK

create
	create_book

feature

	deadline: detachable DATE
			-- the last day, when person can use a book for free

	taken: detachable DATE
			-- date, when the book was taken

	restriction: INTEGER
			-- age restriction of the book

	name: STRING
			-- title of the book

	author: STRING
			-- author of the book

	cost: INTEGER
			-- cost of the book

	is_best_seller: BOOLEAN
			-- if the book is best seller

feature

	create_book (n, a: STRING; min_age, book_cost: INTEGER; best_seller: BOOLEAN)
			-- bought of the book by the library
		do
			name := n
			author := a
			restriction := min_age
			cost := book_cost
			is_best_seller := best_seller
		ensure
			title_is_properly_set: name = n
			author_is_properly_set: author = a
			age_restriction_is_properly_set: restriction = min_age
			cost_is_properly_set: cost = book_cost
			popularity_is_properly_set: is_best_seller = best_seller
		end

	is_overdue: BOOLEAN
			-- is current date bigger, then deadline
		local
			now: DATE
		do
			create now.make_now
			Result := False
			if attached deadline as d then
				if now.is_less (d) then
					Result := True
				end
			end
		end

	checkout (d: DATE)
			-- book became taken
		local
			duration: DATE_DURATION
		do
			taken := d
			create duration.make_by_days (d.days_in_week * (3 - is_best_seller.to_integer))
			deadline := d.plus (duration)
		end

	return
			-- returns book to the library
		do
			deadline := Void
			taken := Void
		end

	fine: INTEGER
			-- payment for the book
		do
			Result := 0
			if is_overdue then
				Result := overduration * 100
			end
			if Result > cost then
				Result := cost
			end
		end

feature {NONE}

	overduration: INTEGER
			-- length of oveduration period
		local
			now: DATE
		do
			Result := 0
			create now.make_now
			if attached deadline as d then
				Result := now.relative_duration (d).day
			end
		end

end
