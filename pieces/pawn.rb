class Pawn < Piece
  attr_reader :initial_pos

  def initialize(color, pos, board, initial_pos = nil)
    @initial_pos = initial_pos || pos.dup
    super(color, pos, board)
  end

  def symbol
    :p
  end

  def value
    1
  end

  def moves
    valid_moves = [[pos[0] + dirr, pos[1]]]
    valid_moves << [pos[0] + (dirr * 2), pos[1]] if pos == initial_pos
    valid_moves.reject { |pos| debugger if pos.first > 7 || pos.first < 0 ; board[pos].symbol } + captures
  end

  # overwriting Piece dup to retain initial_pos
  def dup(new_board)
    Pawn.new(color, pos.dup, new_board, initial_pos)
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
