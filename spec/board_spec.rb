require_relative '../lib/board'

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
end