module Stepable
  def moves
    diffs.map { |diff| absolute_pos(pos, diff) }
      .select { |pos| pos.all? { |idx| idx < 8 && idx > -1 } }
      .reject { |pos| board[pos].symbol && board[pos].color == color }
  end

  def absolute_pos(pos, diff)
    [pos[0] + diff[0], pos[1] + diff[1]]
  end
end
