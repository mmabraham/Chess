require "io/console"

KEYMAP = {
  "\u0003" => :ctrl_c,
  "\r" => :return,
  " " => :space,
  "k" => :up,
  "j" => :down,
  "h" => :left,
  "l" => :right,
  "w" => :up,
  "s" => :down,
  "a" => :left,
  "d" => :right,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[D" => :left,
  "\e[C" => :right
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :board
  attr_accessor :cursor_pos, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e"
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true
    STDIN.cooked!
    input
  end

  def handle_key(key)
    case key
    when :left, :right, :up, :down
      diff = MOVES[key]
      update_pos(diff)
      nil
    when :return, :space
      toggle_selected
      return cursor_pos
    when :ctrl_c
      Process.exit(0)
    end
  end

  def update_pos(diff)
    new_pos = [cursor_pos[0] + diff[0], cursor_pos[1] + diff[1]]
    self.cursor_pos = new_pos if in_bounds?(new_pos)
  end

  def in_bounds?(pos)
    pos.all? { |idx| idx.between?(0, 7) }
  end

  def toggle_selected
    self.selected = !selected
  end
end
