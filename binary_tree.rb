class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value=nil, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

	def to_s
		return @value
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
			@array.push(child_node)
			if pos == "left"
				parent.left_child = child_node 
			else
				parent.right_child = child_node
			end
			child_node.parent = node
		elsif node.value <= value
			insert(node.right_child, value, "right", node)
		elsif node.value > value
			insert(node.left_child, value, "left",node)
		end
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

tree.build_tree([1,2,3,4,5,6,7,8,9])
puts tree.to_s