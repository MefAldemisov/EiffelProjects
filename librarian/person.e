note
	description: "Summary description for {PERSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON

create
	make_account

feature -- parameters

	name: STRING
			-- name of the person

	address: STRING
			-- address of the person

	phone_number: STRING
			-- contact phone number

	library_card_number: STRING
			-- ID of person

	list_of_books: ARRAY [BOOK]
			-- list of books, given to that person

	date_of_birth: DATE
			-- person's date of birth

	is_child: BOOLEAN
			-- 'true' if person's age is less then 12
		do
			Result := date_of_birth.relative_duration (now).year.is_less (12)
		ensure
			Result = date_of_birth.relative_duration (now).year.is_less (12)
		end

feature -- main available operations

	make_account (n, a, p, card: STRING; d: DATE)
			-- creates a new librarian user
		do
			name := n
			address := a
			phone_number := p
			library_card_number := card
			date_of_birth := d
			create list_of_books.make_empty
		ensure
			name_is_properly_set: name.is_equal (n)
			address_is_properly_set: address.is_equal (a)
			phone_number_is_properly_set: phone_number.is_equal (p)
			library_card_number_is_properly_set: library_card_number.is_equal (card)
			date_of_birth_is_properly_set: date_of_birth.is_equal (d)
		end

	check_out_book (book: BOOK)
			-- check out book
		require
			person_can_take_that_book: can_checkout (book)
		do
			list_of_books.force (book, list_of_books.count + 1)
			book.checkout (now)
		ensure
			size_changed: old list_of_books.count + 1 = list_of_books.count
		end

	return_the_book (book: BOOK): INTEGER
			-- return the fine for the book
		require
			person_has_such_a_book: list_of_books.has (book)
		do
			Result := 0
			if book.is_overdue then
				Result := book.fine
			end
			list_of_books.remove_tail (index_of_book (book))
			book.return
		ensure
			size_changed: old list_of_books.count - 1 = list_of_books.count
		end

	sum_of_fines: INTEGER
			-- returns sum, that persom ought to pay to the library
		do
			across
				list_of_books as book
			loop
				Result := book.item.fine
			end
		end

	amount_of_taken_books: INTEGER
			-- returns the amount of books, taken by the person
		do
			Result := list_of_books.count
		end

feature {NONE} -- for implementation only

	index_of_book (book: BOOK): INTEGER
			-- returns the index of the book in the person's list
		require
			list_contains_such_a_book: list_of_books.has (book)
		do
			from
				Result := 1
			until
				(not list_of_books.valid_index (Result)) or else list_of_books.at (Result).is_equal (book)
			loop
				Result := Result + 1
			end
		ensure
			book_is_here: list_of_books.at (Result).is_equal (book)
		end

	now: DATE
			-- returns the current date
		do
			create Result.make_now
		end

feature -- for contracts

	can_checkout (book: BOOK): BOOLEAN
			-- returns 'true' if the person can take a book
		do
			Result := is_child implies ((date_of_birth.relative_duration (now).year >= book.restriction) and (list_of_books.count < 5))
		ensure
			Result = is_child implies ((date_of_birth.relative_duration (now).year >= book.restriction) and (list_of_books.count < 5))
		end

end
