class AiPlayer
  attr_reader :board, :color, :name, :display

  def initialize(display, color, name = Bot)
    @display = display
    @board = display.board
    @color = color
    @name = name
  end

  def play_turn
    display.render
    root_node = Node.new(board, nil, true)
    root_node.set_score
    move = root_node.children.shuffle.max_by(&:points).move
    return move
  end
end

class Node
  MAX_DEPTH = 2

  attr_reader :points, :children, :move

  def initialize(board, move, my_turn, depth = MAX_DEPTH)
    @board = board
    @move = move
    @depth = depth
    @my_turn = my_turn
    @children = []
  end

  def set_score
    if depth <= 0
      self.points = total_score
      return total_score
    end
    self.children = next_nodes
    scores = self.children.map { |node| node.set_score }
    self.points = my_turn ? scores.max : scores.min
  end

  private

  attr_writer :points, :children
  attr_reader :board, :depth, :my_turn

  def next_nodes
    board.all_complete_moves_for(current_color).map do |start_pos, end_pos|
      copy = board.dup
      copy.move_piece(start_pos, end_pos)
      Node.new(copy, [start_pos, end_pos], !my_turn, depth - 1)
    end
  end

  def current_color
    my_turn ? :white : :black
  end

  def opposite_color
    my_turn ? :black : :white
  end

  def total_score
    calc_score(board.all_pieces_of(current_color)) -
      calc_score(board.all_pieces_of(opposite_color))
  end

  def calc_score(pieces)
    pieces.reduce(0) { |acc, piece| acc + piece.value }
  end

  def inspect
    move.to_s + '------- ' + points
  end
end
