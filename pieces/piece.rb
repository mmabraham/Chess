require 'byebug'
require 'singleton'

class Piece
  attr_accessor :color, :pos, :symbol, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @symbol = :p
    @board = board
  end

  def dup(new_board)
    self.class.new(color, pos.dup, new_board)
  end

  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  private

  def move_into_check?(end_pos)
    copy = board.dup
    copy.move_piece!(pos, end_pos)
    copy.in_check?(color)
  end
end
