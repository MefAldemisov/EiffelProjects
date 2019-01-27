note
	description: "Summary description for {MY_BINARY_TREE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_BINARY_TREE [G -> COMPARABLE]

create
	make

feature -- creation

	make (root: G; l: detachable MY_BINARY_TREE [G]; r: detachable MY_BINARY_TREE [G])
			-- constructor for the tree
		require
			tree_is_balanced: (l = Void or else l.info < root) and (r = Void or else root <= r.info)
		do
			info := root
			left := l
			right := r
		ensure
			set_root: info = root
			set_left: left = l
			set_right: right = r
		end

feature -- obliged methods

	info: G
			-- the value of the current node.

	height: INTEGER
			-- a query that returns the height of the tree
		do
			Result := sub_height (left).max (sub_height (right))
			Result := Result + 1
		ensure
			Result = sub_height (left).max (sub_height (right)) + 1
		end

	add (t: MY_BINARY_TREE [G])
			-- a command that adds tree t as left or right subtree
		require
			tree_exists: t /= Void
		do
			if info < t.info then
				right := t
			else
				left := t
			end
		ensure
			tree_added_to_curren: (info < t.info and right = t) or (t.info <= info and left = t)
		end

feature {NONE} -- unvisible params

	left: detachable MY_BINARY_TREE [G]
			-- the left subtree

	right: detachable MY_BINARY_TREE [G]
			-- the right subtree

	sub_height (tree: detachable MY_BINARY_TREE [G]): INTEGER
			-- returns the height of the tree, that might be void
		do
			Result := 0
			if tree /= Void then
				Result := tree.height
			end
		ensure
			Result >= 0
		end

end
