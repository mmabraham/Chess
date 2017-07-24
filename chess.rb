require_relative 'lib/board'
require_relative 'lib/display'
require_relative 'lib/pieces'
require_relative 'lib/players'

class Game

  attr_reader :players, :board

  def initialize(player1, player2, board)
    @board = board
    @players = [player1, player2]
  end

  def play
    until board.game_over?(players.first.color)
      begin
        start_pos, end_pos = players.first.play_turn
        unless board[start_pos].color == players.first.color
          raise InvalidMoveError.new("Not your piece")
        end
        board.move_piece(start_pos, end_pos)
      rescue InvalidMoveError => error
        board.errors = error.message
        retry
      end

      switch_player!
    end
    players.last.display.render
    puts "#{players.last.name} wins!"
  end

  private

  def switch_player!
    players.rotate!
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  player1 = HumanPlayer.new(display, :white, "White")
  player2 = HumanPlayer.new(display, :black, "Black")
  player3 = BFSPlayer.new(display, :white, "BFS Bot")
  player4 = DFSPlayer.new(display, :black, "DFS Bot")

  if ARGV[0] == '-h'
    game = Game.new(player1, player2, board)
  elsif ARGV[0] == '-c'
    game = Game.new(player3, player4, board)
  else
    game = Game.new(player1, player4, board)
  end
  game.play
end
