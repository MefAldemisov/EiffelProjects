note
	description: "Summary description for {BANK_ACCOUNT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANK_ACCOUNT

create
	make

feature

	name: STRING

	balance: INTEGER

	make (name_s: STRING; balance_s: INTEGER)
		do
			name := name_s
			balance := balance_s
			not_eough_cheque
			overflow_cheque
			print (balance.out)
		end

	overflow_cheque
		do
			if balance > 1000000 then
				print ("Balance is overflow")
				balance := 1000000
			end
		end

	not_eough_cheque
		do
			if balance < 100 then
				print ("Account can't be created. Put more money.")
			end
		end

	deposit (difference: INTEGER)
		do
			balance := balance + difference
			overflow_cheque
		end

	withdraw (difference: INTEGER)
		do
			balance := balance - difference
			not_eough_cheque
		end

end
