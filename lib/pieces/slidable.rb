module Slidable
  def moves
    moves = []

    move_dirs.each do |diff|
      new_pos = pos
      while true
        new_pos = next_after(new_pos, diff)
        break unless new_pos.all? { |idx| idx < 8 && idx > -1 }
        if board[new_pos].symbol
          moves << new_pos unless board[new_pos].color == color
          break
        end
        moves << new_pos
      end
    end
    moves
  end

  private

  def next_after(pos, diff)
    [pos[0] + diff[0], pos[1] + diff[1]]
  end
end
