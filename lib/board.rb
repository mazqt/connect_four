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

  def win?
    return false if empty_board()
    return true if win_straight_line() || win_straight_line(@rows.transpose)
    return true if win_diagonal()

    false
  end

  def empty_board
    @rows.each do |row|
      row.any? { |mark| return false if mark != "_" }
    end
    true
  end

  def win_straight_line(rows = @rows)
    rows.each do |row|
      chain = []
      #debugger
      row.each do |mark|
        if chain.empty? || chain[0] == mark
          chain << mark
          return true if (chain.length == 4 && chain[0] != "_")
        else
          chain = [mark]
        end
      end
    end
    false
  end

  def win_diagonal()
    rows_hash = Hash.new()
    rows_hash_reverse = Hash.new()
    @rows.each_with_index do |row, y|
      row.each_with_index do |mark, x|
        if rows_hash[x - y].nil?
          rows_hash[x - y] = []
        end
        if rows_hash_reverse[y - x].nil?
          rows_hash_reverse[y - x] = []
        end
        rows_hash[x - y] << mark
      end
    end

    @rows.reverse.each_with_index do |row, y|
      row.each_with_index do |mark, x|
        if rows_hash_reverse[x - y].nil?
          rows_hash_reverse[x - y] = []
        end
        rows_hash_reverse[x - y] << mark
      end
    end

    rows_array = []
    rows_hash.each_value { |row| rows_array << row }
    rows_array_reverse = []
    rows_hash_reverse.each_value { |row| rows_array_reverse << row }

    return true if win_straight_line(rows_array) || win_straight_line(rows_array_reverse)
  end

end
