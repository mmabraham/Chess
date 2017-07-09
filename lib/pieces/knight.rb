class Knight < Piece
  include Stepable

  def symbol
    :N
  end

  def value
    3 + super
  end

  def diffs
    [ [-2,-1], [-2,1], [2,1], [2,-1],  [1,2], [1,-2], [-1,2], [-1,-2] ]
  end
end
