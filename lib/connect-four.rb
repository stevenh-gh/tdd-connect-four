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

  def print_grid
    grid.each do |ele|
      ele.each { |pi| print "[#{pi.empty? ? ' ' : pi}]" }
      puts
    end
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
    until x.zero? || y == grid[0].length - 1
      x = next_x
      y = next_y
      next_x = x - 1
      next_y = y + 1
    end
    # get diagonal elements
    print "START UP: [#{x},#{y}]"
    puts
    diagonal_arr = []
    next_x = x + 1
    next_y = y - 1
    until grid[x].nil?
      diagonal_arr << grid[x][y]
      x = next_x
      y = next_y
      next_x = x + 1
      next_y = y - 1
    end
    print "DIAGONAL UP: #{diagonal_arr}"
    puts
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
    until x.zero? || y.zero?
      x = next_x
      y = next_y
      next_x = x - 1
      next_y = y - 1
    end
    # get diagonal elements
    print "START DOWN: [#{x},#{y}]"
    puts
    diagonal_arr = []
    next_x = x + 1
    next_y = y + 1
    until grid[x].nil?
      diagonal_arr << grid[x][y]
      x = next_x
      y = next_y
      next_x = x + 1
      next_y = y + 1
    end
    print "DIAGONAL DOWN: #{diagonal_arr}"
    puts
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

class Player
  @@turn_count = 0
  attr_accessor :symbol, :grid
  def initialize(symbol, grid)
    @symbol = symbol
    @grid = grid
    puts "You are player #{symbol}!"
  end

  def drop_piece(col)
    @@turn_count += 1
    grid.drop_piece_at symbol, col
  end

  def self.turn_count
    @@turn_count
  end
end

def make_grid
  ans = ''
  row = 0
  col = 0
  loop do
    print 'Use default grid size? (Y/N): '
    ans = gets.chomp.downcase
    break if ans == 'y' || ans == 'n'
  end
  if ans == 'n'
    loop do
      print 'Enter row size (must be at least 4): '
      row = gets.chomp.to_i
      break if row >= 4
    end
    loop do
      print 'Enter column size: (must be at least 4): '
      col = gets.chomp.to_i
      break if col >= 4
    end
    return Game.new row, col
  end
  Game.new
end

puts 'Connect Four initialized'
puts
grid = make_grid
p1 = Player.new 'x', grid
puts 'Player x created.'
p2 = Player.new 'o', grid
puts 'Player o created.'
loop do
  col = 0
  if Player.turn_count.even?
    loop do
      print 'Player x enter column number: '
      col = gets.chomp.to_i - 1
      break if col >= 0
    end
    coord = p1.drop_piece col
    result = grid.check_win coord
    grid.print_grid
    print "#{coord}\n"
    puts result
    if result
      puts 'Player x wins!'
      break
    end
  else
    loop do
      print 'Player o enter column number: '
      col = gets.chomp.to_i - 1
      break if col >= 0
    end
    coord = p2.drop_piece col
    result = grid.check_win coord
    grid.print_grid
    print "#{coord}\n"
    puts result
    if result
      puts 'Player o wins!'
      break
    end
  end
end
