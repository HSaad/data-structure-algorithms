class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value=nil, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end
end

class Tree

	def initialize
	end

	def build_tree(array)
		array.each do |data|
			node = Node.new(data)
			
		end
	end
end