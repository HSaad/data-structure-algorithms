class Node
	attr_accessor :value, :parent

	def initialize(value=nil, parent=nil)
		@value = value
		@parent = parent
	end

	def to_s
		parent = @parent.value if @parent != nil
		string = "value: #{@value}, parent: #{parent}"
		return string
	end
end

class Game
	attr_accessor :board_array, :visited, :unvisited

	def initialize
		@board_array = []
		@visited = []
		@unvisited = []
		draw_board
	end

	def draw_board
		8.times do |i|
			8.times do |j|
				@board_array.push([i,j])
			end
		end
	end

	def to_s
		string = ""
		@board_array.each do |pos|
			string += pos.to_s
		end
		return string
	end
end

class Knight
	attr_accessor :game

	def initialize(game=nil)
		@game = game
	end

	#Using breadth first search (unvisited acts as queue)
	def possible_moves(start_node, destination)
	
		if start_node.value == destination
			return start_node
		else
			game.visited << start_node
			game.unvisited = game.unvisited + (set_parent(start_node,  possible_positions(start_node.value)) - game.visited)
			game.unvisited.each do |position_node|
				if position_node.value == destination
					return position_node
				end
				game.visited << position_node
			end
			possible_moves(game.unvisited.shift,destination) if game.unvisited.first != nil 
		end
	end

	#link possible positions with their starting(parent) position/node
	def set_parent(node, array)
		node_array = []
		array.each do |position|
			child_node = Node.new(position, node)
			node_array << child_node
		end
		return node_array
	end

	def possible_positions(position)
		array_positons = []
		array_positons.push([position[0] + 2, position[1] + 1]) if position[0] + 2 < 8 && position[1] + 1 < 8
		array_positons.push([position[0] + 1, position[1] + 2]) if position[0] + 1 < 8 && position[1] + 2 < 8
		array_positons.push([position[0] - 2, position[1] - 1]) if position[0] - 2 >= 0 && position[1] - 1 >= 0
		array_positons.push([position[0] - 1, position[1] - 2]) if position[0] - 1 >= 0 && position[1] - 2 >= 0
		array_positons.push([position[0] + 2, position[1] - 1]) if position[0] + 2 < 8 && position[1] - 1 >= 0
		array_positons.push([position[0] - 2, position[1] + 1]) if position[0] - 2 >= 0 && position[1] + 1 < 8
		array_positons.push([position[0] + 1, position[1] - 2]) if position[0] + 1 < 8 && position[1] - 2 >= 0
		array_positons.push([position[0] - 1, position[1] + 2]) if position[0] - 1 >= 0 && position[1] + 2 < 8
		return array_positons
	end

	#turn node into path by adding parent to path array
	def knight_moves(start, destination)
		node = possible_moves(Node.new(start), destination)
		path = []
		while node.parent != nil
			path.push(node.value)
			node = node.parent
		end
		path.push(start)
		print_path(path.reverse)
	end

	def print_path(array)
		puts "You made it in #{array.length - 1} moves! Heres your path: "
		array.each do |position|
			puts position.inspect
		end
	end

end

game = Game.new

k = Knight.new(game)
k.knight_moves([0,0],[1,2])
k.knight_moves([0,0],[3,3])
k.knight_moves([3,3],[0,0])
k.knight_moves([3,3], [4,3])