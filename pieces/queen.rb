require_relative 'piece'
require_relative 'slidable'

class Queen < Piece
  include Slidable

  def symbol
    :Q
  end

  private
  
  def move_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0],
    [1, -1], [1, 1], [-1, -1], [-1, 1]]
  end
end
