class NullPiece < Piece
  include Singleton

  def initialize
  end

  def value
    0
  end

  def symbol
    nil
  end

  # def moves
  #   []
  # end
end
