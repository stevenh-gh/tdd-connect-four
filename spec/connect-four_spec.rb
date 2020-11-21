require './lib/connect-four'
describe Game do
  game = Game.new
  describe '#initialize' do
    it 'creates a new game object' do
      expect(game).to be_a(Game)
    end
    it 'creates a 6x7 grid by default' do
      expect(game.grid).to eql(Array.new(6) { Array.new 7 })
    end
    it 'creates a nxm grid if arguments are passed' do
      game = Game.new 10, 6
      expect(game.grid).to eql(Array.new(10) { Array.new 6 })
    end
  end
end
