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
end