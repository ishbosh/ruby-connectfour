require_relative 'display'

class Board
  include DisplayText

  attr_accessor :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) { blank_space } }
  end

  def show
    puts show_column_numbers
    grid.each do |row|
      show_row(row)
    end
    puts show_column_numbers
  end

  def update(column, piece)
    row = open_row(column)
    self.grid[row][column] = piece
  end

  def open_row(column)
    open_spot = nil
    grid.each_with_index do |row, i|
      break unless row[column].eql?(blank_space)

      open_spot = i
    end
    open_spot
  end

  def full?
    grid.first.include?(blank_space) ? false : true
  end

  def open_column?(column)
    grid.first[column].eql?(blank_space)
  end

  def winner?
    # check for winner
  end
end