class Game
  attr_accessor :grid
  def initialize(row = 6, col = 7)
    @grid = Array.new(row) { Array.new col }
  end
end
