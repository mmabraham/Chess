require 'colorize'
require_relative 'cursor'

class Display
  W_ICON = {
    K: "\u2654",
    Q: "\u2655",
    R: "\u2656",
    B: "\u2657",
    N: "\u2658",
    p: "\u2659",
  }

  B_ICON = {
    K: "\u265A",
    Q: "\u265B",
    R: "\u265C",
    B: "\u265D",
    N: "\u265E",
    p: "\u265F",
  }

  attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system('clear')
    board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        pos = [row_idx, col_idx]
        print format(pos)
      end
      puts
    end
    puts board.errors
  end

  private

  def format(pos)
    symbol = board[pos].symbol || :null_piece
    icon = board[pos].color == :white ? W_ICON[symbol] : B_ICON[symbol]
    cell = " #{icon || ' '} "
    cell = cell_color(cell, pos)
    if pos == cursor.cursor_pos
      cell = cursor_color(cell)
    end

    cell
  end

  def cursor_color(cell)
    if cursor.selected
      cell.colorize(background: :light_yellow)
    else
      cell.colorize(background: :yellow)
    end
  end

  def cell_color(cell, pos)
    pos.reduce(:+).even? ? cell.colorize(background: :cyan  ) : cell.colorize(background: :white)
  end
end
