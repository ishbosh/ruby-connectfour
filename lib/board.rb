require_relative 'display'

class Board
  include DisplayText

  def initialize
    @grid = Array.new(6) { Array.new(7) { blank_space } }
  end

  def show
    puts show_column_numbers
    @grid.each do |row|
      show_row(row)
    end
    puts show_column_numbers
  end

  def game_over?
  end

  def update(move_column)
  end
end