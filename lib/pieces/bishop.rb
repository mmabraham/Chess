class Bishop < Piece
  include Slidable

  def symbol
    :B
  end

  def value
    3 + super
  end

  def move_dirs
    [[1, -1], [1, 1], [-1, -1], [-1, 1]]
  end
end
