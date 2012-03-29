class Atom
  attr_accessor :owner, :neighbours, :neutrons

  def initialize()
    @neighbours = []
    @neutrons = 0
    @owner = " "
  end
  
  def add_neutron(player)
    return false if @owner != " " and @owner != player
    
    @owner = player
    @neutrons += 1
    
    if @neutrons == @neighbours.count
      @neutrons = 0
      disperse_neutrons
      if @neutrons == 0 
        @owner = " "
      end
    end
    return true
  end
  
  def disperse_neutrons
    @neighbours.each do |neighbour|
       neighbour.owner = @owner
       neighbour.add_neutron(@owner)
    end
  end
end

class Grid2d
  attr_accessor :width, :height
  
  def initialize(width, height)
    @width = width
	  @height = height
	  @grid = Array.new(width * height) { Atom.new }
	
    for x in 0..width - 1
	  for y in 0..height - 1
        if x + 1 < width
          self[x, y].neighbours << self[x + 1, y]
          self[x + 1, y].neighbours << self[x, y]
        end

	    if y + 1 < height
		  self[x, y].neighbours << self[x, y + 1]
		  self[x, y + 1].neighbours << self[x, y]
	    end
	  end
    end
  end
  
  def [](x, y)
    return nil if x >= @width or y >= @height or x < 0 or y < 0
    return @grid[x + y * width]
  end
  
  def has_winner?
    first_owner  = self[0, 0].owner
    @grid.all? {|i| i.owner != " " and i.owner == first_owner}
  end
end

def show_grid(grid)
  for y in 0..grid.height - 1
    line = ""
    for x in 0..grid.width - 1
      b = grid[x, y]
      line += "|" + b.owner + b.neutrons.to_s + " of " + b.neighbours.count.to_s
    end
    line += "|"
    puts line
  end
end

def start_game
  puts "Player 1?"
  player_one = gets.chomp
  puts "Player 2?"
  player_two = gets.chomp
  
  puts "Width?"
  width = gets.chomp.to_i
  puts "Height?"
  height = gets.chomp.to_i

  game_map = Grid2d.new(width, height)
  
  player_ones_move = true
  
  until game_map.has_winner? do
    show_grid(game_map)
    current_player = player_ones_move ? player_one : player_two
    puts current_player
    puts "x?"
    x = gets.chomp.to_i
    puts "y?"
    y = gets.chomp.to_i
    
    if game_map[x, y].add_neutron(current_player)
      player_ones_move = !player_ones_move
    else
      puts "Invalid move, try again!"
    end
    
  end
end





