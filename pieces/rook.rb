require_relative 'piece'
require_relative 'slidable'

class Rook < Piece
  include Slidable

  def symbol
    :R
  end

  private

  def move_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end
