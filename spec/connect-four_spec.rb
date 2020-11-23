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
    it 'takes in x/o and col pos and returns board with piece' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      arr[5][4] = 'x'
      expect(game.drop_piece_at('x', 4)).to eql(arr)
    end
    it 'puts piece on top of another piece if there\'s another piece below it' do
      game = Game.new
      arr = Array.new(game.grid.length) { Array.new game.grid[0].length, '' }
      arr[5][4] = 'x'
      arr[4][4] = 'o'
      game.drop_piece_at('x', 4)
      p game.grid
      expect(game.drop_piece_at('o', 4)).to eql(arr)
    end
  end
end
