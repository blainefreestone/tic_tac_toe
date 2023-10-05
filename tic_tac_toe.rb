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

  def add_marker(position, player)
    @board_status[position] = player.current_marker
  end

  def player_won?(player)
    LINES.any? do |line|
      line.all { |position| @board_status[position] == player.current_marker }
    end
  end

  def board_full?
    @board_status[1..9].none?(&:!)
  end

  def position_empty?(position)
    !@board_status[position]
  end

  def position_exists?(position)
    return false if position.zero?

    @board_status[position]
  end
end

class Player
  attr_accessor :current_marker, :win_count
  attr_reader :name

  def initialize(name)
    @name = name
    @win_count = 0
  end
end

class Game
  def initialize(first_player, second_player)
    @board = Board.new
    @first_player = first_player
    @second_player = second_player

    @first_player.current_marker = 'x'
    @second_player.current_marker = 'o'
  end

  def make_move(player)
    puts @board.board_in_text
    puts "#{player.name}, where would you like to play?"

    Kernel.loop do
      position = gets.to_i
      if @board.position_empty?(position) && @board.position_exists?(position)
        @board.add_marker(position, player)
        break
      end
      puts 'That position is not valid. Please try again.'
    end
  end

  def play
    make_move(@first_player)
    make_move(@second_player)
    make_move(@first_player)
  end
  # def play_game
  #   until @board.game_over?
  #     puts @board
  #     make_move(1)
  #     puts @board
  #     make_move(2)
  #   end
  #   puts @board
  #   puts 'Game over!'
  # end

  # def make_move(player_number)
  #   made_move = false
  #   until made_move
  #     puts "Player #{player_number}, type the row number where you would like to play"
  #     row = gets.to_i - 1
  #     puts 'Now type the column number where you would like to play'
  #     column = gets.to_i - 1
  #     unless @board.board_status[row, column] == '-'
  #       player_number == 1 ? @board.add_marker(row, column, 'x') : @board.add_marker(row, column, 'o')
  #       made_move = true
  #     end
  #   end
  # end
end

player1 = Player.new("Blaine")
player2 = Player.new("Destiny")
game = Game.new(player1, player2)
game.play
