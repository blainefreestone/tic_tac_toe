class Board

  LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @board_status = Array.new(10)
  end

  def board_in_text
    row_seperator = '---+---+---'
    column_seperator = ' | '
    rows = LINES[0..2]

    position_label = ->(position) { @board_status[position] || position }
    full_row = ->(row) { row.map(&position_label).join(column_seperator) }

    ' ' + rows.map(&full_row).join(" \n" + row_seperator + "\n ")
  end

  def add_marker(position, marker_type)
    @board_status[position] = marker_type
  end

  def player_won?(player)
    LINES.any? do |line|
      line.all { |position| @board_status[position] == player.marker }
    end
  end

  def board_full?
    @board_status[1..9].none?(&:!)
  end
end

class Player
  attr_accessor :current_marker

  def initialize(name)
    @name = name
  end
end

class HumanPlayer < Player
  
end

class Game
  def initialize
    @board = Board.new
    @turn_number = 1
  end

  def play_game
    until @board.game_over?
      puts @board
      make_move(1)
      puts @board
      make_move(2)
    end
    puts @board
    puts 'Game over!'
  end

  def make_move(player_number)
    made_move = false
    until made_move
      puts "Player #{player_number}, type the row number where you would like to play"
      row = gets.to_i - 1
      puts 'Now type the column number where you would like to play'
      column = gets.to_i - 1
      unless @board.board_status[row, column] == '-'
        player_number == 1 ? @board.add_marker(row, column, 'x') : @board.add_marker(row, column, 'o')
        made_move = true
      end
    end
  end
end

board = Board.new
puts board.board_in_text
puts board.board_full?
