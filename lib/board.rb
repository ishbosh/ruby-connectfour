require_relative 'display'

class Board
  include DisplayText
  
  def initialize
    @grid = Array.new(6) { Array.new(7) { blank_space } }
  end

  def show
    
  end

  def game_over?
  end

  def update(move_column)
  end
end