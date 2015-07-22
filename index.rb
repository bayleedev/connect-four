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
        print "\u25A0 ".colorize(char || :light_black)
      end
      print "\n"
    end
  end

  def moves
    pieces.flatten.compact.length
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

  def red?
    moves % 2 == 0
  end

  def current_color
    red? ? :red : :yellow
  end

  def current_player
    current_color.to_s.colorize(current_color)
  end

  def place(col)
    if col.match(/\A[^\d]/)
      false
    else
      col = col.to_i
      id = column(col).each_with_index.find { |el, i| el.nil? }[1]
      column(col)[id] = current_color
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
while board.draw and !board.won?
  print "What would #{board.current_player} like to do: "
  unless board.place(gets.chomp)
    puts 'Invalid input.'
  end
end
