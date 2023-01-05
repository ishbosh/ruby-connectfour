module DisplayText
  def show_intro
    'Connect Four'
  end

  def show_input_error
    'Invalid input - try again.'
  end

  def show_column_numbers
    ' ' + (1..7).to_a.join(' ')
  end
  
  def show_row(board_row)
    print '|'
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