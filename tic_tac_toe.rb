class Board
  attr_accessor :board_status

  def initialize
    @board_status = Array.new(3) { Array.new(3, '-') }
  end

  def to_s
    row_strings = []
    horizontal_line_string = "-----------\n"
    @board_status.each do |row_array|
      row_strings.push " #{row_array[0]} | #{row_array[1]} | #{row_array[2]}\n"
    end
    row_strings[0] + horizontal_line_string + row_strings[1] + horizontal_line_string + row_strings[2]
  end

  def add_x(row_index, column_index)
    @board_status[row_index][column_index] = 'x'
  end

  def add_o(row_index, column_index)
    @board_status[row_index][column_index] = 'o'
  end

  def game_over?
    completed_row? || completed_column? || completed_diagonal?
  end

  private

  def column_arrays
    @board_status.reduce(Array.new(3) { [] }) do |column_arrays, row_array|
      column_arrays[0].push(row_array[0])
      column_arrays[1].push(row_array[1])
      column_arrays[2].push(row_array[2])
      column_arrays
    end
  end

  def completed_row?
    is_complete = false

    @board_status.each do |row_array|
      if row_array.all? { |row_value| row_value == 'x' } || row_array.all? { |row_value| row_value == 'o' }
        is_complete = true
      end
    end
    is_complete
  end

  def completed_column?
    is_complete = false

    column_arrays.each do |column_array|
      if column_array.all? { |column_value| column_value == 'x' } || column_array.all? { |column_value| column_value == 'o' }
        is_complete = true
      end
    end
    is_complete
  end

  def completed_diagonal?
    if @board_status[0][0] == 'x' && @board_status[1][1] == 'x' && @board_status[2][2] == 'x'
      true
    elsif @board_status[0][0] == 'o' && @board_status[1][1] == 'o' && @board_status[2][2] == 'o'
      true
    elsif @board_status[0][2] == 'x' && @board_status[1][1] == 'x' && @board_status[2][0] == 'x'
      true
    elsif @board_status[0][2] == 'o' && @board_status[1][1] == 'o' && @board_status[2][0] == 'o'
      true
    else false end
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
    end
    puts @board
    puts "Game over!"
  end

  def make_move(player_number)
    made_move = false
    until made_move
      puts "Player #{player_number}, type the row number where you would like to play"
      row = gets.to_i - 1
      puts 'Now type the column number where you would like to play'
      column = gets.to_i - 1
      if @board.board_status[row, column]
        @board.add_x(row, column)
        made_move = true
      end
    end
  end
end

game = Game.new
game.play_game