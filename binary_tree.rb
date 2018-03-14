class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value=nil, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

	def to_s
		parent = @parent.value if @parent != nil
		left_child = @left_child.value if @left_child != nil
		right_child = @right_child.value if @right_child != nil
		string = "value: #{@value}, parent: #{parent}, left_child: #{left_child}, right_child:#{right_child}"
		return string
	end
end

class Tree

	def initialize
		@root = nil
		@array = []
	end

	def build_tree(array)
		array = array.shuffle
		array.each_with_index do |data, index|
			if index == 0
				@root = Node.new(data)
				@array.push(@root) #for to_s
			else
				insert(@root,data,"", @root)
			end
		end
	end

	def insert(node, value, pos, parent)
		if node == nil
			child_node = Node.new(value)
			child_node.parent = parent
			@array.push(child_node)
			if pos == "left"
				parent.left_child = child_node 
			else
				parent.right_child = child_node
			end
		elsif node.value <= value
			insert(node.right_child, value, "right", node)
		elsif node.value > value
			insert(node.left_child, value, "left",node)
		end
	end

	def breadth_first_search(value)
		queue = []
		queue.push(@root)

		while !queue.empty?
			node = queue.shift
			return node if node.value == value
			queue.push(node.left_child) if node.left_child != nil
			queue.push(node.right_child) if node.right_child != nil
		end

		return nil
	end

	def depth_first_search(value)
		stack = []
		stack.push(@root)

		while !stack.empty?
			node = stack.pop
			return node if node.value == value
			stack.push(node.left_child) if node.left_child != nil
			stack.push(node.right_child) if node.right_child != nil
		end
		return nil
	end

	def dfs_rec(value, node=@root)
		if node.value == value
			return node
		end
		left = dfs_rec(value, node.left_child) if node.left_child != nil
		right = dfs_rec(value, node.right_child) if node.right_child != nil
		left or right
	end

	def to_s
		string = ""
		@array.each do |node|
			string += node.value.to_s
			right = node.right_child.value if node.right_child != nil
			left = node.left_child.value if node.left_child != nil
			string += " left: #{left}, right: #{right}\n"
		end
		return string
	end

end

tree = Tree.new

tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.to_s

node = tree.breadth_first_search(7)
puts node.to_s

node = tree.depth_first_search(8)
puts node.to_s

node = tree.dfs_rec(4)
puts node.to_s