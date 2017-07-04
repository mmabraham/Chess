class Queen < Piece
  include Slidable

  def symbol
    :Q
  end

  def value
    9
  end

  private

  def move_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0],
    [1, -1], [1, 1], [-1, -1], [-1, 1]]
  end
end
