note
	description: "Summary description for {VECTOR_OPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VECTOR_OPER

feature
	cross_product (v1, v2: ARRAY [INTEGER]): ARRAY [INTEGER]
			--returns the cross product of vectors v1 and v2
			require
				v1.count = v2.count
			local
				i: INTEGER
				mo: MATRIX_OPER
				coefficients: ARRAY2[INTEGER]
			do
				create mo
				create coefficients.make_filled (0, v1.count, v1.count)
				Result := v1
				from
					i := 1
				until
					i > v1.count
				loop
					coefficients.item (2, i) := v1[i]
					coefficients.item (3, i) := v2[i]
					i := i + 1
				end

				from
					i := 1
				until
					i > v1.count
				loop
					Result[i] := mo.det(mo.cut_next_matrix (coefficients, i))
					i := i + 1
				end
			end

	dot_product (v1, v2: ARRAY [INTEGER]): INTEGER
			-- returns the scalar product of vectors v1 and v2
			require
				v1.count = v2.count
			local
				i: INTEGER
			do
				from
					i := 1
				until
					i > v1.count
				loop
					Result := Result + v1[i] * v2[i]
					i := i + 1
				end
			end

	abs(v1: ARRAY[INTEGER]): REAL_64
	require v1.count > 0
	do
		across v1 as el loop
			Result := Result + el.item.power (2.0)
		end
		Result := Result.power(0.5)
	ensure
		Result >= 0

	end
	triangle_area (v1, v2: ARRAY [INTEGER]): INTEGER
			-- assuming that a triangle is constructed on vectors v1 and v2, triangle_area returns the area of that triangle.
			-- ||a|| ||b|| sin\alpha / 2
			-- sin \alpha = sqtr(1-cos^2\alpha)
			-- cos\alpha = a*b/||a|| ||b||
		local
			cos_a, sin_a: REAL_64
		do
			cos_a := dot_product(v1, v2)/abs(v1)/abs(v2)
			sin_a := (1-cos_a.power(2.0)).power(0.5)
			Result := (abs(v1)*abs(v2)*sin_a).rounded
		ensure
			reult_is_bounded: Result >= 0
			cos_is_real: -1 <= dot_product(v1, v2)/abs(v1)/abs(v2) and dot_product(v1, v2)/abs(v1)/abs(v2) <= 1
		end

end
