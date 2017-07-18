class DFSPlayer
  MAX_DEPTH = 2
  attr_reader :board, :color, :name, :display

  def initialize(display, color, name = Bot)
    @display = display
    @board = display.board
    @color = color
    @name = name
  end

  def play_turn
    display.render
    mini_max.first
  end

  private

  def mini_max(board = self.board, my_turn = true, depth = 0)
    best_move = nil
    return [best_move, total_score(board, my_turn)] if depth == MAX_DEPTH

    moves = board.all_complete_moves_for(current_color(my_turn))

    best_score = my_turn ? -999999 : 999999

    moves.each do |move|
      copy = board.dup
      copy.move_piece!(*move)
      _, best = mini_max(copy, !my_turn, depth + 1)
      if my_turn
        best_score, best_move = best, move if best > best_score
      else
        best_score, best_move = best, move if best < best_score
      end
    end
    [best_move, best_score]
  end

  def current_color(my_turn)
    my_turn ? color : opposite_color
  end

  def opposite_color
    color == :black ? :white : :black
  end

  def total_score(board, my_turn)
    calc_score(board.all_pieces_of(color)) -
      calc_score(board.all_pieces_of(opposite_color))
  end

  def calc_score(pieces)
    pieces.reduce(0) { |acc, piece| acc + piece.value }
  end
end
