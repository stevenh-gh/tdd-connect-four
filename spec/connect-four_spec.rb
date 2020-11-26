require './lib/connect-four'
describe Game do
  describe '#initialize' do
    it 'creates a new game object' do
      game = Game.new
      expect(game).to be_a(Game)
    end
    it 'creates a 6x7 grid by default' do
      game = Game.new
      expect(game.grid).to eql(Array.new(6) { Array.new 7, '' })
    end
    it 'creates a nxm grid if arguments are passed' do
      game = Game.new 10, 6
      expect(game.grid).to eql(Array.new(10) { Array.new 6, '' })
    end
  end
  describe '#drop_piece_at' do
    it 'takes in x/o and col pos and returns coordinate of piece placed' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      arr[5][4] = 'x'
      expect(game.drop_piece_at('x', 4)).to eql([5, 4])
    end
    it 'puts piece on top of another piece if there\'s another piece below it' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      arr[5][4] = 'x'
      arr[4][4] = 'o'
      game.drop_piece_at('x', 4)
      expect(game.drop_piece_at('o', 4)).to eql([4, 4])
    end
  end
  describe '#check_win' do
    it 'checks if there\'s connect four based on coordinates given' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      game.drop_piece_at('x', 1)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 3)
      coord = game.drop_piece_at('x', 4)
      expect(game.check_win(coord)).to eql(true)
    end
    it 'checks if there\'s connect four based on coordinates given' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      game.drop_piece_at('x', 0)
      game.drop_piece_at('o', 1)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 3)
      coord = game.drop_piece_at('x', 4)
      expect(game.check_win(coord)).to eql(false)
    end
    it 'checks for connect four vertically' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      game.drop_piece_at('x', 1)
      game.drop_piece_at('x', 1)
      game.drop_piece_at('x', 1)
      coord = game.drop_piece_at('x', 1)
      expect(game.check_win(coord)).to eql(true)
    end
    it 'checks for connect four vertically' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      game.drop_piece_at('x', 1)
      game.drop_piece_at('x', 1)
      game.drop_piece_at('o', 1)
      coord = game.drop_piece_at('x', 1)
      expect(game.check_win(coord)).to eql(false)
    end
    it 'checks for connect four diagonally (upwards)' do
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
      game.print_grid
      expect(game.check_win(coord)).to eql(true)
    end
    it 'checks for connect four diagonally (upwards)' do
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
      game.drop_piece_at('o', 2)
      game.drop_piece_at('x', 3)
      coord = game.drop_piece_at('x', 3)
      game.print_grid
      expect(game.check_win(coord)).to eql(false)
    end
    it 'checks for connect four diagonally (downwards)' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('o', 2)
      game.drop_piece_at('o', 2)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 3)
      game.drop_piece_at('o', 3)
      game.drop_piece_at('o', 3)
      game.drop_piece_at('x', 3)
      game.drop_piece_at('x', 3)
      game.drop_piece_at('o', 4)
      game.drop_piece_at('x', 4)
      game.drop_piece_at('o', 4)
      game.drop_piece_at('x', 4)
      game.drop_piece_at('o', 5)
      game.drop_piece_at('o', 5)
      coord = game.drop_piece_at('x', 5)
      game.print_grid
      expect(game.check_win(coord)).to eql(true)
    end
    it 'checks for connect four diagonally (downwards)' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('o', 2)
      game.drop_piece_at('o', 2)
      game.drop_piece_at('x', 2)
      game.drop_piece_at('x', 3)
      game.drop_piece_at('o', 3)
      game.drop_piece_at('o', 3)
      game.drop_piece_at('x', 3)
      game.drop_piece_at('x', 3)
      game.drop_piece_at('o', 4)
      game.drop_piece_at('x', 4)
      game.drop_piece_at('o', 4)
      game.drop_piece_at('x', 4)
      game.drop_piece_at('o', 5)
      game.drop_piece_at('o', 5)
      coord = game.drop_piece_at('o', 5)
      game.print_grid
      expect(game.check_win(coord)).to eql(false)
    end
  end
end
