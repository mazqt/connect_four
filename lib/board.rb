require 'byebug'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(7) { Array.new(6, "_") }
  end

  def row_full?(index)
    !@rows[index].any? { |x| x == "_" }
  end

  def place_mark(row, mark)
    length = @rows[row].length
    target = nil

    #debugger

    @rows[row].reverse.each_with_index do |value, index|
      if value == "_"
        target = index
        break
      end
    end
    return false if target == nil
    target = length - target - 1
    @rows[row][target] = mark
  end

end
