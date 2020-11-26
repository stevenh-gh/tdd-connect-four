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
      check_win_diagonal_up(coord) || check_win_diagonal_down(coord)
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
    # get highest diagonal point
    x = coord[0]
    y = coord[1]
    next_x = x - 1
    next_y = y + 1
    until grid[next_x].nil?
      x = next_x
      y = next_y
      next_x = x - 1
      next_y = y + 1
    end
    # get diagonal elements
    diagonal_arr = []
    next_x = x + 1
    next_y = y - 1
    until grid[next_x].nil?
      diagonal_arr << grid[x][y]
      x = next_x
      y = next_y
      next_x = x + 1
      next_y = y - 1
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

  def check_win_diagonal_down(coord)
    # get top of diagonal
    x = coord[0]
    y = coord[1]
    next_x = x - 1
    next_y = y - 1
    until grid[next_x].nil?
      x = next_x
      y = next_y
      next_x = x - 1
      next_y = y - 1
    end
    # get diagonal elements
    diagonal_arr = []
    next_x = x + 1
    next_y = y + 1
    until grid[next_x].nil?
      diagonal_arr << grid[x][y]
      x = next_x
      y = next_y
      next_x = x + 1
      next_y = y + 1
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
