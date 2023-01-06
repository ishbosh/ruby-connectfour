require_relative 'player'
require_relative 'board'
require_relative 'display'

class Game
  include DisplayText

  attr_accessor :board, :current_turn, :player_one, :player_two

  def initialize
    @board = Board.new
    @player_one = Player.new(red_piece, 'Player One')
    @player_two = Player.new(blue_piece, 'Player Two')
    @current_turn = nil
  end

  def play
    puts show_intro
    game_loop
  end

  def game_loop
    loop do
      update_current_turn
      show_board
      take_turn
      break if game_over?

    end
    announce_winner
  end

  def take_turn
    print show_turn(current_turn.name)
    validated_move = player_input
    update_board(validated_move, current_turn)
    puts show_turn_divider
  end

  def update_current_turn
    self.current_turn = current_turn.eql?(player_one) ? player_two : player_one
  end

  def player_input
    loop do
      input = gets.chomp
      verified_move = verify_input(input)
      return verified_move if verified_move

      print show_input_error
    end
  end

  def verify_input(input)
    if input.to_i.between?(1, 7)
      verified_input = input.to_i - 1
      return verified_input if board.open_column?(verified_input)
    end
  end

  def update_board(valid_move, player)
    board.update(valid_move, player.piece)
  end

  def show_board
    board.show
  end

  def game_over?
    return true if board.full? || board.winner?

    false
  end

  def tie_game?
    return false unless board.full?

    board.winner? ? false : true
  end

  def winning_player
    return 'tie' if tie_game?

    current_turn
  end

  def announce_winner
    show_board # show final board
    winner = winning_player
    puts winner.eql?('tie') ? show_tie : show_winner(winner.name)
  end
end
