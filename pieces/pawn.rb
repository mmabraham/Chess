require_relative 'piece'

class Pawn < Piece
  attr_reader :initial_pos

  def initialize(color, pos, board)
    @initial_pos = pos.dup
    super
  end

  def symbol
    :p
  end

  def value
    1
  end

  def moves
    result = [[pos[0] + dirr, pos[1]]]
    result << [pos[0] + (dirr * 2), pos[1]] if pos == initial_pos
    result.reject { |pos| board[pos].symbol } + captures
  end

  private

  def dirr
    initial_pos.first == 1 ? 1 : -1
  end

  def captures
    result = [[pos[0] + dirr, pos[1] + 1], [pos[0] + dirr, pos[1] - 1]]

    result.select do |pos| pos.all? { |idx| idx.between?(0, 7) } &&
      board[pos].symbol && board[pos].color != color
    end
  end
end
