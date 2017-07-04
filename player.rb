class HumanPlayer
  attr_reader :display, :color, :name

  def initialize(display, color, name=nil)
    @name = name
    @color = color
    @display = display
  end

  def play_turn
    [get_pos, get_pos]
  end

  def get_pos
    while true
      display.render
      pos = display.cursor.get_input
      return pos if pos
    end
  end
end
