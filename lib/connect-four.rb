require 'pry'
class Game
  attr_accessor :grid
  def initialize(row = 6, col = 7)
    @grid = Array.new(row) { Array.new col, '' }
  end

  def drop_piece_at(c, pos)
    grid.each_index do |idx|
      if (!grid[idx + 1].nil? && !grid[idx + 1][pos].empty?) || grid[idx + 1].nil?
        grid[idx][pos] = c
        break
      end
    end
    grid
  end
end
