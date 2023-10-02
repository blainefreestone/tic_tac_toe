class Board
  attr_accessor :board_status

  def initialize
    @board_status = Array.new(3, Array.new(3, ''))
  end

	def to_s
		column_strings = []
		horizontal_line_string = "-----------\n"
		@board_status.each {|column_array| column_strings.push " #{column_array[0]} | #{column_array[1]} | #{column_array[2]}\n"}
		column_strings[0] + horizontal_line_string + column_strings[1] + horizontal_line_string + column_strings[2]
	end
end

board = Board.new
p board.board_status
puts board
