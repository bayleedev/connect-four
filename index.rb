require 'pry'
require 'colorize'

class Board
  attr_accessor :pieces

  COLS = 7
  ROWS = 6

  def initialize
    @pieces = [
      [:red, :orange, :orange, :white, :orange, :black],
      [:yellow, nil, :white, nil, nil, nil],
      [:red, :white, nil, nil, nil, nil],
      [:white, nil, nil, nil, nil, nil],
      [:red, nil, nil, nil, nil, nil],
      [:red, nil, nil, nil, nil, nil],
      [:red, :yellow, nil, nil, nil, :black]
    ]
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
    [:n, :w, :nw, :ne].find do |dir|
      items = possible_win(dir, row, column)
      items.compact.size == 4 and items.uniq.length == 1
    end
  end

  def possible_win(direction, row, column)
    relative_direction = {n: [-1, 0], w: [0, -1], nw: [-1, -1], ne: [-1, 1]}[direction]
    (0..3).map do |i|
      x = row + (relative_direction[0] * i)
      y = column + (relative_direction[1] * i)
      pieces[x][y] if x >= 0 and y >= 0
    end
  end

  def row(id)
    pieces.collect { |el| el[id] }
  end

  def column(id)
    pieces[id]
  end

end

board = Board.new
board.draw
if board.won?
  puts "Somebody won!"
else
  puts "Fail."
end
