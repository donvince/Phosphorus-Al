class Node
  attr_accessor :owner, :neighbours, :buttons

  def initialize()
    @neighbours = []
    @buttons = 0
    @owner = " "
  end
  
  def add_button
    @buttons += 1
    
    if @buttons == @neighbours.count
      @buttons = 0
      disperse_buttons
      if @buttons == 0 
        @owner = " "
      end
    end
  end
  
  def disperse_buttons
    @neighbours.each do |neighbour|
       neighbour.owner = @owner
       neighbour.add_button
    end
  end
end

def create_grid(width, height)
  grid = Array.new(width) { Array.new(height) {Node.new} }
  
  for x in 0..width - 1
    for y in 0..height - 1
      puts x.to_s + ", " + y.to_s
      
      if x + 1 < width
        grid[x][y].neighbours << grid[x + 1][y]
        grid[x + 1][y].neighbours << grid[x][y]
      end

      if y + 1 < height
        grid[x][y].neighbours << grid[x][y + 1]
        grid[x][y + 1].neighbours << grid[x][y]
      end
    end
  end
  grid
end

def show_grid(grid)
  for x in 0..grid.length - 1
    line = ""
    for y in 0..grid[x].length - 1
      b = grid[x][y]
      line += "|" + b.owner + b.buttons.to_s + " of " + b.neighbours.count.to_s
    end
    line += "|"
    puts line
  end
end







