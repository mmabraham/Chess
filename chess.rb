
load 'load.rb'
require 'byebug'

class Game

  attr_reader :players, :board

  def initialize(player1, player2, board)
    @board = board
    @players = [player1, player2]
  end

  def play
    until board.checkmate?(players.first.color)
      begin
        start_pos, end_pos = players.first.play_turn

        unless board[start_pos].color == players.first.color
          raise InvalidMoveError.new("Not your turn!")
        end

        board.move_piece(start_pos, end_pos)
      rescue InvalidMoveError => error
        board.errors = error.message
        retry
      end
      switch_player!
    end

    puts "Congrats, #{players.last.name} has won!"
  end

  private

  def switch_player!
    players.rotate!
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)

  player1 = AiPlayer.new(display, :white, "Bot")
  player2 = HumanPlayer.new(display, :black, "Menachem")

  game = Game.new(player1, player2, board)
  game.play
end
