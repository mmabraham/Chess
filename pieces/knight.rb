require_relative 'piece'

class Knight < Piece
  include Stepable

  def symbol
    :N
  end

  def diffs
    [ [-2,-1], [-2,1], [2,1], [2,-1],  [1,2], [1,-2], [-1,2], [-1,-2] ]
  end
end
