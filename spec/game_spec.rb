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

  describe '#take_turn' do
    # public script method does not need testing - behavior of methods inside will be tested
  end

  describe '#update_current_turn' do
    context 'when it is the first turn' do
      it 'updates player turn to first player' do
        game.update_current_turn
        expect(game.current_turn).to be(game.player_one)
      end
    end

    context 'when the last turn was player one' do
      it 'updates player turn to second player' do
        game.current_turn = game.player_one
        game.update_current_turn
        expect(game.current_turn).to be(game.player_two)
      end
    end

    context 'when the last turn was player two' do
      it 'updates player turn to first player' do
        game.current_turn = game.player_two
        game.update_current_turn
        expect(game.current_turn).to be(game.player_one)
      end
    end
  end

end
