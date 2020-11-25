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
    check_win_horizontal(coord) || check_win_vertical(coord) ||
      check_win_diagonal_up(coord)
  end

  private

  def check_win_horizontal(coord)
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

  def check_win_vertical(coord)
    char = grid[coord[0]][coord[1]]
    vertical_arr = []
    (0...grid.length).each { |n| vertical_arr << grid[n][coord[1]] }
    count = vertical_arr.reduce(0) do |acc, ele|
      unless ele.empty?
        char == ele ? acc += 1 : acc = 0
      end
      acc
    end
    return true if count >= 4

    false
  end

  def check_win_diagonal_up(coord)
    # get highest point of diagonal line
    unless coord[0].zero?
      x = 0
      y = coord[1] + coord[0]
    end
    # iterate down
    diagonal_arr = []
    loop do
      diagonal_arr << grid[x][y] unless grid[x].nil?
      break if y.zero?

      x += 1
      y -= 1
    end
    char = grid[coord[0]][coord[1]]
    count = diagonal_arr.reduce(0) do |acc, ele|
      unless ele.nil?
        unless ele.empty?
          char == ele ? acc += 1 : acc = 0
        end
      end
      acc
    end
    return true if count >= 4

    false
  end
end
game = Game.new
arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
game.drop_piece_at('x', 0)
game.drop_piece_at('x', 1)
game.drop_piece_at('o', 2)
game.drop_piece_at('o', 3)
game.drop_piece_at('x', 0)
game.drop_piece_at('o', 1)
game.drop_piece_at('x', 2)
game.drop_piece_at('x', 3)
game.drop_piece_at('x', 1)
game.drop_piece_at('o', 2)
game.drop_piece_at('o', 3)
game.drop_piece_at('x', 2)
game.drop_piece_at('x', 3)
coord = game.drop_piece_at('x', 3)
game.grid.each do |ele|
  ele.each { |pi| print "[#{pi.empty? ? ' ' : pi}]" }
  puts
end
p game.check_win(coord)
