# frozen_string_literal: true

require_relative 'display'

# Board class object
class Board
  include DisplayText

  attr_accessor :grid, :last_move

  def initialize
    @grid = Array.new(6) { Array.new(7) { blank_space } }
    @last_move = nil
  end

  def show
    puts "\n#{show_column_numbers}"
    grid.each do |row|
      show_row(row)
    end
    puts show_column_numbers
  end

  def update(column, piece)
    row = open_row(column)
    self.last_move = [row, column]
    grid[row][column] = piece
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
    win_threshold = 3
    best_line_count(win_threshold) >= win_threshold
  end

  def best_line_count(threshold, count = 0)
    player_piece = grid[last_move.first][last_move.last] # first is row, last is column
    # Directions array must keep this order! direction then opposite direction
    directions = %i[left right up down up_left down_right up_right down_left]
    # Check each direction and its opposite,and then reset the count to 0 after each pair checked
    directions.each_with_index do |dir, i|
      count = 0 if (i % 2).zero?
      count += count_adjacent_pieces(player_piece, last_move, dir)
      break if count >= threshold
    end
    count
  end

  def count_adjacent_pieces(piece, origin, direction, count = 0)
    steps = {
      left: [0, -1], right: [0, 1], up: [-1, 0], down: [1, 0],
      up_left: [-1, -1], up_right: [-1, 1], down_left: [1, -1], down_right: [1, 1]
    }
    new_row = origin.first + steps[direction].first
    new_col = origin.last + steps[direction].last
    return count unless in_bounds?(new_row, new_col) && matching_piece?(new_row, new_col, piece)

    count += 1
    count_adjacent_pieces(piece, [new_row, new_col], direction, count)
  end

  def in_bounds?(row, col)
    border = { top: 0, bot: 5, left: 0, right: 6 }
    row.between?(border[:top], border[:bot]) && col.between?(border[:left], border[:right])
  end

  def matching_piece?(row, col, piece)
    grid[row][col].eql?(piece)
  end
end
