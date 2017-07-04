class NullPiece < Piece
  include Singleton

  def initialize
  end

  def symbol
    nil
  end
end
