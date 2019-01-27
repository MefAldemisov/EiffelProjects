note
	description: "Summary description for {MATRICES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MATRIX_OPER

feature
	have_the_same_sizes (m1, m2: ARRAY2[INTEGER]): BOOLEAN
		do
			Result := m1.height = m2.height
			Result := Result and m1.width = m2.width
		end

	add (m1, m2: ARRAY2 [INTEGER]): ARRAY2 [INTEGER]
			--returns the addition of matrices: m1+m2
		require
			appropriate_sizes: have_the_same_sizes(m1, m2)
		local
			i, j: INTEGER
		do
			Result := m1
			from
				i := 1
			until
				i > m1.height
			loop
				from
					j := 1
				until
					j > m1.width
				loop
					Result.item (i, j) := m1.item (i, j) + m2.item (i, j)
					j := j + 1
				end
				i := i + 1
			end
		end

	minus (m1, m2: ARRAY2 [INTEGER]): ARRAY2 [INTEGER]
			-- returns the subtraction of matrices: m1−m2
		require
			appropriate_sizes: have_the_same_sizes(m1, m2)
		local
				i, j: INTEGER
		do
			Result := m1
			from
				i := 1
			until
				i > m1.height
			loop
				from
					j := 1
				until
					j > m1.width
				loop
					Result.item (i, j) := m1.item (i, j) - m2.item (i, j)
					j := j + 1
				end
				i := i + 1
			end
		end

	row_col_multiplication(m1, m2: ARRAY2[INTEGER]; row, col: INTEGER): INTEGER
		local
			itterator: INTEGER
		do
			Result := 0
			from
				itterator := 1
			until
				itterator > m1.height
			loop
				Result := Result + m1.item(row, itterator) * m2.item(itterator, col)
				itterator := itterator + 1
			end
		end


	prod (m1, m2: ARRAY2 [INTEGER]): ARRAY2 [INTEGER]
			-- returns the product of matrices: m1m2
		require
			appropriate_sizes: m1.width = m2.height

		local
			i, j: INTEGER
		do
			create Result.make_filled(0, m1.height, m2.width)
			from
				i := 1
			until
				i > m1.height
			loop
				from
					j := 1
				until
					j > m1.width
				loop
					Result.item (i, j) := row_col_multiplication(m1, m2, i, j)
					j := j + 1
				end
				i := i + 1
			end
		end

feature
	cut_next_matrix(m: ARRAY2[INTEGER]; closed_row: INTEGER): ARRAY2[INTEGER]
	local
		row, column, new_row: INTEGER
	do
		create Result.make_filled (0, m.width - 1, m.width - 1)
		from
			row := 1
			new_row := 1
		until
			row > m.height
		loop
			if row /= closed_row then
				from
					column := 2
				until
					column > m.width
				loop
					Result.item(new_row, column - 1) := m.item(row, column)
					column := column + 1
				end
				new_row := new_row + 1
			end
			row := row + 1
		end

	end

	det (m: ARRAY2 [INTEGER]): INTEGER
			-- returns the determinant of matrix m: det(m)
		require
			is_squared: m.width = m.height
		local
			i, sign: INTEGER
		do
			if m.width > 2 then
				from
					i := 1
					sign := 1
				until
					i > m.height
				loop
					Result := Result + det(cut_next_matrix(m, i)) * m.item (i, 1) * sign
					i := i + 1
					sign := sign * (- 1)
				end
			elseif m.width = 2 then
				-- for matrix 2x2
				Result := m.item (1, 1) * m.item (2, 2) - m.item (1, 2) * m.item (2, 1)
			else
				-- for matrix 1x1
				Result := m.item (1, 1)
			end
		end

end
