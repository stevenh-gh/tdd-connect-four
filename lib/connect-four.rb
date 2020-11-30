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
      check_win_diagonal(coord, 'up') || check_win_diagonal(coord, 'down')
  end

  def print_grid
    grid.each do |ele|
      ele.each { |pi| print "[#{pi.empty? ? ' ' : pi}]" }
      puts
    end
  end

  private

  def check_win_horizontal(coord)
    verify_connect_four grid[coord[0]], grid[coord[0]][coord[1]]
  end

  def check_win_vertical(coord)
    vertical_arr = []
    (0...grid.length).each { |n| vertical_arr << grid[n][coord[1]] }
    verify_connect_four vertical_arr, grid[coord[0]][coord[1]]
  end

  def check_win_diagonal(coord, dir)
    c = get_top_diagonal_coord coord[0], coord[1], dir
    x = c[0]
    y = c[1]
    diagonal_arr = make_diagonal_array x, y, dir
    verify_connect_four diagonal_arr, grid[coord[0]][coord[1]]
  end

  def verify_connect_four(arr, char)
    count = arr.reduce(0) do |acc, ele|
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

  def get_top_diagonal_coord(c0, c1, dir)
    direction = dir == 'up'
    x = c0
    y = c1
    next_x = x - 1
    next_y = direction ? y + 1 : y - 1
    until x.zero? || (direction ? (y == grid[0].length - 1) : y.zero?)
      x = next_x
      y = next_y
      next_x = x - 1
      next_y = direction ? y + 1 : y - 1
    end
    [x, y]
  end

  def make_diagonal_array(xcoord, ycoord, dir)
    direction = dir == 'up'
    diagonal_arr = []
    x = xcoord
    y = ycoord
    next_x = x + 1
    next_y = direction ? y - 1 : y + 1
    until grid[x].nil?
      diagonal_arr << grid[x][y]
      x = next_x
      y = next_y
      next_x = x + 1
      next_y = direction ? y - 1 : y + 1
    end
    diagonal_arr
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

def prompt_size(rc)
  print "Enter #{rc} size (must be at least 4): "
  gets.chomp.to_i
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
      row = prompt_size 'row'
      break if row >= 4
    end
    loop do
      col = prompt_size 'col'
      break if col >= 4
    end
    return Game.new row, col
  end
  Game.new
end

def make_player(symbol, grid)
  puts "Player #{symbol} created."
  Player.new symbol, grid
end

def player_turn(player, grid, col)
  loop do
    print "Player #{player.symbol} enter column number: "
    col = gets.chomp.to_i - 1
    break if col >= 0 && col < grid.grid[0].length
  end
  coord = player.drop_piece col
  result = grid.check_win coord
  grid.print_grid
  print "#{coord}\n"
  puts result
  result
end

puts 'Connect Four initialized'
puts
grid = make_grid
p1 = make_player 'x', grid
p2 = make_player 'o', grid
loop do
  col = 0
  if Player.turn_count.even?
    result = player_turn p1, grid, col
    (puts 'Player x wins!'; break) if result
  else
    result = player_turn p2, grid, col
    (puts 'Player o wins!'; break) if result
  end
end
