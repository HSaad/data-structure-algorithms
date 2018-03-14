class Node
	attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value=nil, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@children = []
	end

	def to_s
		parent = @parent.value if @parent != nil
		
		string = "value: #{@value}, parent: #{parent}, children: #{children.inspect}"
		return string
	end
end

class Game
	attr_accessor :board_array

	def initialize
		@board_array = []
		board
	end

	def board
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
	attr_accessor :position, :game, :root

	def initialize(position=nil, game=nil)
		@position = position
		@game = game
	end

	def possible_moves()
		tree = {}
		array = @game.board_array

		array.each do |position|
			tree[position] = possible_positions(position)
		end
		return tree
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

	def knight_moves

	end

	def to_s
		return position.to_s
	end
end

game = Game.new
#puts game.to_s

knight = Knight.new([1,2],game)
puts knight.possible_moves