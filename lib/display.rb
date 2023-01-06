module DisplayText
  def show_intro
    "\n- - - - Connect Four - - - -" \
    "\n This is a Two Player game." \
    "\n Try to get four in a row." \
    "\n- - - - - - -  - - - - - - -"
  end

  def show_input_error
    'Invalid input - try again.'
  end

  def show_turn(player)
    if player.eql?('Player One')
      "\n - - \e[31m#{player}'s turn\e[0m - - " \
      "\n  Choose a column number: "
    else
      "\n - - \e[34m#{player}'s turn\e[0m - - " \
      "\n  Choose a column number: "
    end
  end

  def show_winner(player)
    if player.eql?('Player One')
      "\n ~ ~ \e[31m#{player} wins! Great job!\e[0m ~ ~ \n "
    else
      "\n ~ ~ \e[34m#{player} wins! Great job!\e[0m ~ ~ \n "
    end
  end

  def show_tie
    "\n ++ TIE GAME ++ \n "
  end

  def show_turn_divider
    "________________________________ \n\n "
  end

  def show_column_numbers
    '       ' + (1..7).to_a.join(' ')
  end
  
  def show_row(board_row)
    print '      |'
    print board_row.join('|')
    puts '|'
  end

  def blank_space
    "\u25ce"
  end

  def red_piece
    "\e[31m\u25c9\e[0m"
  end

  def blue_piece
    "\e[34m\u25c9\e[0m"
  end

end