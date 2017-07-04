require_relative 'piece'
require_relative 'slidable'

class Bishop < Piece
  include Slidable
  
  def symbol
    :B
  end

  def move_dirs
    [[1, -1], [1, 1], [-1, -1], [-1, 1]]
  end
end
