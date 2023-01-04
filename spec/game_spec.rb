require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  
  subject(:game) { described_class.new }

  describe '#play' do
    # script method does not need tests - instead test the methods inside
  end

  describe '#game_loop' do
    before do
      allow(game).to receive(:take_turn)
      allow(game).to receive(:show_board)
    end

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

  describe '#player_input' do
    context 'when input is valid' do
      it 'stops loop and does not display error message' do
        valid_input = '1'
        allow(game).to receive(:gets).and_return(valid_input)
        expect(game).not_to receive(:puts).with(game.show_input_error)
        game.player_input
      end
    end

    context 'when input is invalid' do
      before do
        allow(game).to receive(:loop).and_yield
      end

      it 'shows the input error and does not return anything' do
        invalid_input = 'z'
        allow(game).to receive(:gets).and_return(invalid_input)
        expect(game).to receive(:puts).with(game.show_input_error).once
        game.player_input
      end
    end

    context 'when player inputs incorrect value followed by correct value' do
      it 'stops the loop after displaying the error message once' do
        invalid_input = 'a'
        valid_input = '2'
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
        expect(game).to receive(:puts).with(game.show_input_error).once
        game.player_input
      end
    end

    context 'when player inputs two incorrect values followed by a correct value' do
      it 'stops the loop after displaying the error message twice' do
        invalid_one = 'one'
        invalid_two = '11'
        valid_input = '7'
        allow(game).to receive(:gets).and_return(invalid_one, invalid_two, valid_input)
        expect(game).to receive(:puts).with(game.show_input_error).twice
        game.player_input
      end
    end
  end

  describe '#verify_input' do
    # Not necessary to test, the player_input test already tests the return value of this method
    # and would not pass if this method was not correctly returning valid input.
  end

  describe '#update_board' do
    it 'sends update to board with the move' do
      move = '1'
      expect(game.board).to receive(:update).with(move)
      game.update_board(move)
    end
  end
  
  describe '#show_board' do
    it 'sends show to the board' do
      expect(game.board).to receive(:show)
      game.show_board
    end
  end
end