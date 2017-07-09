class Rook < Piece
  include Slidable

  def symbol
    :R
  end

  def value
    5 + super
  end

  private

  def move_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end
