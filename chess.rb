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
  player1 = BFSPlayer.new(display, :white, "BFS Bot")
  player2 = DFSPlayer.new(display, :black, "DFS Bot")
  player3 = HumanPlayer.new(display, :black, "Menachem")

  game = Game.new(player2, player1, board)
  game.play
end
