require 'pry'
class Game
  attr_accessor :grid
  def initialize(row = 6, col = 7)
    @grid = Array.new(row) { Array.new col, '' }
  end

  def drop_piece_at(c, pos)
    coord = nil
    grid.each_index do |idx|
      next unless (!grid[idx + 1].nil? && !grid[idx + 1][pos].empty?) || grid[idx + 1].nil?

      grid[idx][pos] = c
      coord = [idx, pos]
      break
    end
    coord
  end

  def check_win(coord)
    # checks horizontally
    char = grid[coord[0]][coord[1]]
    count = grid[coord[0]].reduce(0) do |acc, ele|
      unless ele.empty?
        char == ele ? acc += 1 : acc = 0
      end
      acc
    end
    return true if count >= 4

    false
  end
end
