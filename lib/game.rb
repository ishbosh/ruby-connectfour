require_relative 'player'
require_relative 'board'
require_relative 'display'

class Game
  include DisplayText

  attr_accessor :board, :current_turn, :player_one, :player_two

  def initialize
    @board = Board.new
    @player_one = Player.new
    @player_two = Player.new
    @current_turn = nil
  end

  def play
    show_intro
    game_loop
  end

  def game_loop
    loop do
      show_board
      take_turn
      break if board.game_over?

    end
  end

  def take_turn
    validated_move = player_input
    update_board(validated_move)
    update_current_turn
  end

  def update_current_turn
    self.current_turn = current_turn.eql?(player_one) ? player_two : player_one
  end

  def player_input
    loop do
      input = gets.chomp
      verified_move = verify_input(input)
      return verified_move if verified_move

      puts show_input_error
    end
  end

  def verify_input(input)
    if input.to_i.between?(1, 7)
      return input #unless board.column_full?
    end
  end

  def update_board(valid_move)
    board.update(valid_move)
  end

  def show_board
    board.show
  end
  
# what do we need:
# 2 players
# a game board
# player input
# check for win or draw after each turn
# display text
# display the board each turn
# update the board 
# start the game
# game loop

end