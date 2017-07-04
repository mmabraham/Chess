class InvalidMoveError < StandardError; end

class Board
  attr_accessor :grid, :errors, :prev_move

  def initialize(grid = nil)
    @grid ||= Array.new(8) { Array.new(8) }
    @errors = ''
    populate_board
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise InvalidMoveError.new("Please choose a cell with a piece.")
    end

    unless self[start_pos].valid_moves.include?(end_pos)
      raise InvalidMoveError.new("Please choose a valid move.")
    end

    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    self[start_pos].pos = end_pos
    self[end_pos].pos = nil
    self[end_pos], self[start_pos] = self[start_pos], NullPiece.instance
    self.errors = ''
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end

  def in_check?(color)
    all_moves_for(opposite(color)).include?(king_pos(color))
  end

  def game_over?(color)
    valid_moves_for(color).empty?
  end

  def checkmate?(color)
    in_check?(color) && game_over?(color)
  end

  def valid_moves_for(color)
    result = []

    all_pieces_of(color).each do |piece|
      result += piece.valid_moves
    end

    result
  end

  # for ai
  def all_complete_moves_for(color)
    all_moves = []
    all_pieces_of(color).each do |piece|
      all_moves += piece.valid_moves.map { |move| [piece.pos, move]}
    end
    all_moves
  end

  def dup
    double_board = Board.new
    double_board.grid = grid.map do |rows|
      rows.map do |piece|
        if piece.is_a?(NullPiece)
          NullPiece.instance
        else
          piece.dup(double_board)
        end
      end
    end

    double_board
  end

  def all_pieces_of(color)
    grid.flatten.select { |piece| piece.color == color }
  end

  private

  def populate_board
    place_nulls
    place_pieces(pieces_row(0, :black) + pawn_row(1, :black) +
      pawn_row(6, :white) + pieces_row(7, :white))
  end

  def pieces_row(row_idx, color)
    [
      Rook.new(color, [row_idx, 0], self),
      Knight.new(color, [row_idx, 1], self),
      Bishop.new(color, [row_idx, 2], self),
      Queen.new(color, [row_idx, 3], self),
      King.new(color, [row_idx, 4], self),
      Bishop.new(color, [row_idx, 5], self),
      Knight.new(color, [row_idx, 6], self),
      Rook.new(color, [row_idx, 7], self),
    ]
  end

  def pawn_row(row_idx, color)
    (0..7).map { |col_idx| Pawn.new(color, [row_idx, col_idx], self)}
  end

  def place_pieces(pieces)
    pieces.each { |piece| self[piece.pos] = piece }
  end

  def place_nulls
    (2..5).each do |row_idx|
      8.times { |col_idx| self[[row_idx, col_idx]] = NullPiece.instance }
    end
  end

  def all_moves_for(color)
    all_pos = []
    all_pieces_of(color).each { |piece| all_pos += piece.moves }
    all_pos
  end


  def king_pos(color)
    grid.flatten.find { |piece| piece.is_a?(King) && piece.color == color }.pos
  end

  def opposite(player_color)
    player_color == :black ? :white : :black
  end
end
