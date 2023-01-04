require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  
  subject(:game) { described_class.new }

  describe '#play' do
    # script method does not need tests - instead test the methods inside
  end

  describe '#game_loop' do
    context 'when game is over' do
      it 'exits loop' do
        allow(game.board).to receive(:game_over?).and_return true
        expect(game.board).to receive(:game_over?).once
        game.game_loop
      end
    end
    
    context 'until game is over' do
      it 'loops multiple times' do
        allow(game.board).to receive(:game_over?).and_return(false, false, true)
        expect(game.board).to receive(:game_over?).exactly(3).times
        game.game_loop
      end
    end
  end
end
