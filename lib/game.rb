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
      update_current_turn
      take_turn(current_turn)
      break if board.game_over?

    end
  end

  def take_turn(player)
  end

  def update_current_turn
    current_turn == player_one ? player_two : player_one
  end

  def player_input
    # accept input
    # validate input
    # return validated input
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