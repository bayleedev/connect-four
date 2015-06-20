require 'pry'
require 'colorize'

class Board
  attr_accessor :pieces

  COLS = 7
  ROWS = 6

  def initialize
    @pieces = ([nil] * COLS).map { [nil] * ROWS }
  end

  def draw
    ROWS.times do |i|
      row(ROWS - 1 - i).each do |char|
        print "\u25A0 ".colorize(char || :light_black).bold
      end
      print "\n"
    end
  end

  def won?
    ROWS.times.find do |r|
      COLS.times.find do |c|
        point_won?(r, c)
      end
    end
  end

  def point_won?(row, column)
    possible_wins(row, column).find do |items|
      items.compact.size == 4 and items.uniq.length == 1
    end
  end

  def possible_wins(row, column)
    directions = {n: [-1, 0], w: [0, -1], nw: [-1, -1], ne: [-1, 1]}
    directions.keys.map do |direction|
      relative_direction = directions[direction]
      (0..3).map do |i|
        x = row + (relative_direction[0] * i)
        y = column + (relative_direction[1] * i)
        pieces[x][y] if x >= 0 and y >= 0
      end
    end
  end

  def place(col, val)
    id = column(col).each_with_index.find { |el, i| el.nil? }[1]
    column(col)[id] = val
  end

  def row(id)
    pieces.collect { |el| el[id] }
  end

  def column(id)
    pieces[id]
  end
end

board = Board.new

while !board.won?
  board.draw
  print 'What would you like to do: '
  input = gets.chomp
  unless input.match /\A[^\d]/
    board.place(input.to_i, :red)
  end
end
board.draw
