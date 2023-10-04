class Board
  attr_accessor :board_status

  LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @board_status = Array.new(10)
  end

  def board_in_text
    row_seperator = '---+---+---'
    column_seperator = ' | '
    rows = LINES[0..2]

    position_label = ->(position) { @board_status[position] || '-' }
    full_row = ->(row) { row.map(&position_label).join(column_seperator) }

    ' ' + rows.map(&full_row).join(" \n" + row_seperator + "\n ")
  end

  def add_marker(row_index, column_index, marker_type = 'x')
    @board_status[row_index][column_index] = marker_type
  end

  def game_over?
    completed_row? || completed_column? || completed_diagonal?
  end

  private

  def completed_array?(array)
    is_complete = false

    array.each do |row_array|
      if row_array.all? { |row_value| row_value == 'x' } || row_array.all? { |row_value| row_value == 'o' }
        is_complete = true
      end
    end
    is_complete
  end

  def completed_row?
    completed_array?(@board_status)
  end

  def completed_column?
    # column_arrays = @board_status.reduce(Array.new(3) { [] }) do |result_array, row_array|
    #   result_array[0].push(row_array[0])
    #   result_array[1].push(row_array[1])
    #   result_array[2].push(row_array[2])
    #   result_array
    # end

    column_arrays = @board_status.each_with_object(Array.new(3) { [] }) do |row_array, result_array|
      result_array[0].push(row_array[0])
      result_array[1].push(row_array[1])
      result_array[2].push(row_array[2])
    end

    completed_array?(column_arrays)
  end

  def completed_diagonal?
    diagonal_down = [@board_status[0][0], @board_status[1][1], @board_status[2][2]]
    diagonal_up = [@board_status[0][2], @board_status[1][1], @board_status[2][0]]
    diagonal_arrays = [diagonal_down, diagonal_up]

    completed_array?(diagonal_arrays)
  end
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
