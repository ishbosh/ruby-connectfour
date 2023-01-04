require_relative 'board'

module DisplayText
  def show_intro
  end

  def show_input_error
    'Invalid input - try again.'
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