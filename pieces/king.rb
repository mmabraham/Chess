class King < Piece
  include Stepable

  def symbol
    :K
  end

  def diffs
    [ [0, 1], [0, -1], [1, 0], [-1, 0], [1, -1], [1, 1], [-1, -1], [-1, 1] ]
  end
end
