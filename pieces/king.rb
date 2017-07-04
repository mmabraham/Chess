class King < Piece
  include Stepable

  def symbol
    :K
  end

  def value
    100
  end

  def diffs
    [ [0, 1], [0, -1], [1, 0], [-1, 0], [1, -1], [1, 1], [-1, -1], [-1, 1] ]
  end
end
