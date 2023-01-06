# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  describe '#show' do
    # Do not need to test - only contains puts/print statements
  end

  describe '#update' do
    context 'when player choice is first column' do
      it 'updates first column' do
        column = 0
        piece = board.red_piece
        allow(board).to receive(:open_row).with(column).and_return(5)
        expect { board.update(0, piece) }.to change { board.grid[5][0] }.to(board.red_piece)
      end
    end

    context 'when player choice is 4th/middle column' do
      it 'updates middle column' do
        column = 3
        piece = board.red_piece
        allow(board).to receive(:open_row).with(column).and_return(5)
        expect { board.update(3, piece) }.to change { board.grid[5][3] }.to(board.red_piece)
      end
    end

    context 'when player choice is last column' do
      it 'updates last column' do
        column = 6
        piece = board.red_piece
        allow(board).to receive(:open_row).with(column).and_return(5)
        expect { board.update(6, piece) }.to change { board.grid[5][6] }.to(board.red_piece)
      end
    end

    context 'when first row is full' do
      it 'adds piece to second row' do
        column = 0
        piece = board.red_piece
        allow(board).to receive(:open_row).with(column).and_return(4)
        expect { board.update(0, piece) }.to change { board.grid[4][0] }.to(board.red_piece)
      end
    end
  end

  describe '#open_row' do
    context 'when first row is open' do
      it 'returns first row' do
        expect(board.open_row(0)).to eq(5)
      end
    end

    context 'when first row is not open' do
      it 'returns second row' do
        board.grid[5][0] = board.red_piece
        expect(board.open_row(0)).to eq(4)
      end
    end
  end

  describe '#full?' do
    context 'when full' do
      it 'returns true' do
        board.grid[0] = Array.new(7) { board.red_piece }
        expect(board.full?).to be true
      end
    end

    context 'when not full' do
      it 'returns false' do
        expect(board.full?).to be false
      end
    end
  end

  describe '#open_column?' do
    context 'when column is open' do
      it 'returns true' do
        column = 0
        expect(board.open_column?(column)).to be true
      end
    end

    context 'when column is not open' do
      it 'returns false' do
        column = 5
        board.grid = Array.new(6) { Array.new(7) { board.red_piece } }
        expect(board.open_column?(column)).to be false
      end
    end
  end

  describe '#winner?' do
    win_threshold = 3

    context 'when there is a winner' do
      it 'returns true' do
        allow(board).to receive(:best_line_count).with(win_threshold).and_return(3)
        expect(board.winner?).to be true
      end
    end

    context 'when there is not a winner' do
      it 'returns false' do
        allow(board).to receive(:best_line_count).with(win_threshold).and_return(2)
        expect(board.winner?).to be false
      end
    end
  end

  describe '#best_line_count' do
    win_threshold = 3

    context 'when there are 4 adjacent pieces' do
      it 'returns 4' do
        board.last_move = [0, 0]
        allow(board).to receive(:count_adjacent_pieces).and_return(4)
        expect(board.best_line_count(win_threshold)).to eq(4)
      end
    end

    context 'when there are 3 adjacent pieces' do
      it 'returns 3' do
        board.last_move = [0, 3]
        allow(board).to receive(:count_adjacent_pieces).and_return(3)
        expect(board.best_line_count(win_threshold)).to eq(3)
      end
    end

    context 'when there are no adjacent pieces' do
      it 'returns 0' do
        board.last_move = [0, 0]
        allow(board).to receive(:count_adjacent_pieces).and_return(0)
        expect(board.best_line_count(win_threshold)).to eq(0)
      end
    end
  end

  describe '#count_adjacent_pieces' do
    context 'when the next piece matches' do
      direction = :left
      let(:piece) { board.blank_space }

      context 'and when the next step is out of bounds' do
        it 'does not recurse and keeps count at 0' do
          origin = [0, 0]
          count = 0
          expect { count = board.count_adjacent_pieces(piece, origin, direction, count) }.not_to change { count }
        end
      end

      context 'and when one step away from boundary' do
        it 'recurses and adds to count once' do
          origin = [0, 1]
          count = 0
          expect { count = board.count_adjacent_pieces(piece, origin, direction, count) }.to change { count }.to(1)
        end
      end

      context 'and when two steps away from boundary' do
        it 'recurses and adds to count twice' do
          origin = [0, 2]
          count = 0
          expect { count = board.count_adjacent_pieces(piece, origin, direction, count) }.to change { count }.to(2)
        end
      end

      context 'and when six steps away from boundary' do
        it 'recurses and adds to count six times' do
          origin = [0, 6]
          count = 0
          expect { count = board.count_adjacent_pieces(piece, origin, direction, count) }.to change { count }.to(6)
        end
      end
    end

    context 'when next piece does not match' do
      it 'does not recurse and keeps count at 0' do
        origin = [0, 1]
        direction = :left
        count = 0
        piece = board.red_piece
        expect { count = board.count_adjacent_pieces(piece, origin, direction, count) }.not_to change { count }
      end
    end
  end

  describe '#in_bounds?' do
    # Not necessary to test, this was tested in #count_adjacent_pieces
    # and that test would have failed if this method was not returning correctly
  end

  describe '#matching_piece?' do
    # Not necessary to test, this was tested in #count_adjacent_pieces
    # and that test would have failed if this method was not returning correctly
  end
end
# rubocop:enable Metrics/BlockLength
