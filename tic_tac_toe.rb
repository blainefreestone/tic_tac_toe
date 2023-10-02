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
    is_complete = false

    if @board_status[0][0] == 'x' && @board_status[1][1] == 'x' && @board_status[2][2] == 'x'
      is_complete = true
    elsif @board_status[0][0] == 'o' && @board_status[1][1] == 'o' && @board_status[2][2] == 'o'
      is_complete = true
    elsif @board_status[0][2] == 'x' && @board_status[1][1] == 'x' && @board_status[2][0] == 'x'
      is_complete = true
    elsif @board_status[0][2] == 'o' && @board_status[1][1] == 'o' && @board_status[2][0] == 'o'
      is_complete = true
    end

    is_complete
  end
end

board = Board.new
board.add_o(1, 1)
board.add_o(0, 2)
board.add_o(2, 0)
puts board
puts board.game_over?
