class AiPlayer
  attr_reader :board, :color, :name

  def initialize(display, color, name = Bot)
    @board = display.board
    @color = color
    @name = name
  end

  def play_turn
    @root_node = Node.new(board, nil, true)
    @root_node.set_score
    move = @root_node.children.max_by(&:points).move
    return move
  end

  private

  def any_move
    all_moves.sample
  end

  def all_moves(board)
    moves = []
    board.all_pieces_of(color).each do |piece|
      moves += piece.valid_moves.map { |end_pos| [piece.pos, end_pos] }
    end
    moves
  end
end

class Node
  MAX_DEPTH = 2
  attr_accessor :points
  attr_reader :move, :board, :depth, :children, :my_turn

  def initialize(board, move, my_turn, depth = MAX_DEPTH)
    @board = board
    @move = move
    @depth = depth
    @my_turn = my_turn
    @children = []
  end

  def best_move

  end

  def set_score
    if depth <= 0
      @points = score
      return score
    end
    next_boards = next_moves_and_boards(self.move, self.board)
    next_boards.each { |move, board| children << Node.new(board, move, !my_turn, depth - 1) }
    scores = self.children.map { |node| node.set_score }
    my_turn ? scores.max : scores.min
  end


  # should eventually live in ComputerPlayer and be passed as proc
  # with ComputerPlayer#all_moves within closure
  def next_moves_and_boards(move, board)
    board.all_complete_moves_for(current_color).map do |start_pos, end_pos|
      copy = board.dup
      copy.move_piece(start_pos, end_pos)
      [[start_pos, end_pos], copy]
    end
  end

  def current_color
    my_turn ? :white : :black
  end

  def score
    board.all_pieces_of(current_color).count
  end

  def inspect
    ''
  end
end
