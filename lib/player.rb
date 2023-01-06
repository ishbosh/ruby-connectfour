# frozen_string_literal: true

# Player Class Object
class Player
  attr_accessor :piece, :name

  def initialize(piece, name)
    @name = name
    @piece = piece
  end
end
