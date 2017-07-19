MAX_DEPTH = 2

class BFSPlayer
  def self.color
    @@color
  end

  attr_accessor :root_node
  attr_reader :board, :color, :name, :display

  def initialize(display, color, name = Bot)
    @@color = color
    @color = color
    @display = display
    @board = display.board
    @name = name
    # self.root_node = BFSNode.new(board, nil, true)

    # @thread = Thread.new { populate_tree }
  end

  def play_turn
    display.render
    populate_tree
    root_node.best_score
    node = root_node.children.shuffle.max_by(&:points)
    # @root_node = node
    node.move
  end

  private

  def populate_tree
    # @thread.priority = -1
    self.root_node = BFSNode.new(board, nil, true)
    remaining_nodes = []
    nodes_for_this_turn = [root_node]

    MAX_DEPTH.times do
      until nodes_for_this_turn.empty?
        # sleep(0.0001)
        node = nodes_for_this_turn.shift
        next_nodes = node.next_nodes
        remaining_nodes.concat next_nodes
      end
      nodes_for_this_turn = remaining_nodes
      remaining_nodes = []
    end
  end
end

class BFSNode

  attr_reader :points, :children, :move

  def initialize(board, move, my_turn, depth = 0)
    @board = board
    @move = move
    @depth = depth
    @my_turn = my_turn
    @children = []
  end

  def best_score
    return total_score if depth == MAX_DEPTH
    scores = self.children.map { |node| node.best_score }

    debugger if scores.nil?

    self.points = my_turn ? scores.max || -999 : scores.min || 999
    debugger if points.nil?
    points
  end

  # private

  attr_writer :points, :children
  attr_reader :board, :depth, :my_turn

  def next_nodes
    self.children = board.all_complete_moves_for(current_color).map do |start_pos, end_pos|
      copy = board.dup
      copy.move_piece(start_pos, end_pos)
      BFSNode.new(copy, [start_pos, end_pos], !my_turn, depth + 1)
    end
  end

  def current_color
    my_turn ? BFSPlayer.color : opposite_color
  end

  def opposite_color
    BFSPlayer.color == :black ? :white : :black
  end

  def total_score
    calc_score(board.all_pieces_of(BFSPlayer.color)) -
      calc_score(board.all_pieces_of(opposite_color))
  end

  def calc_score(pieces)
    pieces.reduce(0) { |acc, piece| acc + piece.value }
  end

  def inspect
    move.to_s + '------- ' + points
  end
end
